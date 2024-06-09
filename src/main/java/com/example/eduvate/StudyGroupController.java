package com.example.eduvate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;

import java.time.LocalDate;
import java.util.List;

@Controller
public class StudyGroupController {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @GetMapping("/studygroups")
    public String studyGroups(Model model, HttpSession session) {
        // 사용자 로그인 여부 확인
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }

        // 스터디 그룹 목록 가져오기
        List<StudyGroup> studyGroups = jdbcTemplate.query("SELECT * FROM StudyGroup", (resultSet, rowNum) -> {
            StudyGroup group = new StudyGroup();
            group.setGroupID(resultSet.getInt("GroupID"));
            group.setGroupName(resultSet.getString("GroupName"));
            group.setDescription(resultSet.getString("Description"));
            group.setUserID(resultSet.getString("UserID"));
            return group;
        });

        model.addAttribute("studyGroups", studyGroups);
        model.addAttribute("isLoggedIn", true);

        return "studygroups";
    }

    @GetMapping("/createStudyGroup")
    public String createStudyGroupForm(HttpSession session, Model model) {
        // 사용자 로그인 여부 확인
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }

        model.addAttribute("isLoggedIn", true);
        model.addAttribute("studyGroup", new StudyGroup());

        return "createStudyGroup";
    }

    @PostMapping("/createStudyGroup")
    public String createStudyGroup(@ModelAttribute StudyGroup studyGroup, HttpSession session, Model model) {
        // 사용자 로그인 여부 확인
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }

        // 스터디 그룹 생성
        User user = (User) session.getAttribute("user");
        studyGroup.setUserID(user.getUserID());

        String insertQuery = "INSERT INTO StudyGroup (GroupName, Description, UserID) VALUES (?, ?, ?)";
        jdbcTemplate.update(insertQuery, studyGroup.getGroupName(), studyGroup.getDescription(), studyGroup.getUserID());

        // 생성된 그룹의 ID 가져오기
        int groupID = jdbcTemplate.queryForObject("SELECT last_insert_id()", Integer.class);

        // 리더를 GroupMembers에 추가
        String insertGroupMemberQuery = "INSERT INTO GroupMembers (GroupID, UserID) VALUES (?, ?)";
        jdbcTemplate.update(insertGroupMemberQuery, groupID, user.getUserID());

        // 생성 후 스터디그룹 목록으로 리디렉션
        return "redirect:/studygroups";
    }


    @GetMapping("/studygroup/{groupID}")
    public String studyGroupDetail(
            @PathVariable int groupID,
            @RequestParam(name = "selectedDate", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate selectedDate,
            Model model,
            HttpSession session) {
        // 사용자 로그인 여부 확인
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }

        // 스터디 그룹 상세 정보 가져오기
        StudyGroup group = jdbcTemplate.queryForObject(
            "SELECT * FROM StudyGroup WHERE GroupID = ?",
            (resultSet, rowNum) -> {
                StudyGroup studyGroup = new StudyGroup();
                studyGroup.setGroupID(resultSet.getInt("GroupID"));
                studyGroup.setGroupName(resultSet.getString("GroupName"));
                studyGroup.setDescription(resultSet.getString("Description"));
                studyGroup.setUserID(resultSet.getString("UserID"));
                return studyGroup;
            },
            groupID
        );

        // 해당 스터디 그룹의 가입한 조원 목록 조회
        List<User> groupMembers = jdbcTemplate.query(
            "SELECT u.* FROM User u JOIN GroupMembers gm ON u.userID = gm.UserID WHERE gm.GroupID = ?",
            (resultSet, rowNum) -> {
                User user = new User();
                user.setUserID(resultSet.getString("UserID"));
                user.setUsername(resultSet.getString("username"));
                return user;
            },
            groupID
        );

        // 해당 스터디 그룹의 기록 목록 조회
        List<GroupStudyLog> groupLogs = jdbcTemplate.query(
            "SELECT * FROM GroupStudyLog WHERE GroupID = ? ORDER BY GroupStudyDate ASC",
            (resultSet, rowNum) -> {
                GroupStudyLog log = new GroupStudyLog();
                log.setGroupLogID(resultSet.getInt("GroupLogID"));
                log.setGroupID(resultSet.getInt("GroupID"));
                log.setUserID(resultSet.getString("UserID"));
                log.setGroupStudyDate(resultSet.getDate("GroupStudyDate"));
                log.setGroupStudyDuration(resultSet.getInt("GroupStudyDuration"));
                log.setGroupTopic(resultSet.getString("GroupTopic"));
                return log;
            },
            groupID
        );

        // 현재 로그인한 사용자의 ID
        String currentUserID = ((User) session.getAttribute("user")).getUserID();
        System.out.println("현재 사용자 ID: " + currentUserID);  // 디버깅을 위해 추가

        // 사용자가 쓴 내용 수정 폼을 위한 현재 사용자의 스터디 로그 가져오기
        List<GroupStudyLog> userStudyLogs = jdbcTemplate.query(
            "SELECT * FROM GroupStudyLog WHERE GroupID = ? AND UserID = ? ORDER BY GroupStudyDate ASC",
            (resultSet, rowNum) -> {
                GroupStudyLog log = new GroupStudyLog();
                log.setGroupLogID(resultSet.getInt("GroupLogID"));
                log.setGroupID(resultSet.getInt("GroupID"));
                log.setUserID(resultSet.getString("UserID"));
                log.setGroupStudyDate(resultSet.getDate("GroupStudyDate"));
                log.setGroupStudyDuration(resultSet.getInt("GroupStudyDuration"));
                log.setGroupTopic(resultSet.getString("GroupTopic"));
                return log;
            },
            groupID, currentUserID
        );

        // 사용자가 그룹에 가입했는지 여부 확인
        boolean isUserJoined = groupMembers.stream().anyMatch(member -> member.getUserID().equals(currentUserID));

        model.addAttribute("group", group);
        model.addAttribute("groupMembers", groupMembers);
        model.addAttribute("isLoggedIn", true);
        model.addAttribute("groupLogs", groupLogs);
        model.addAttribute("userStudyLogs", userStudyLogs);
        model.addAttribute("currentDate", LocalDate.now());
        model.addAttribute("isUserJoined", isUserJoined); // 사용자 가입 여부 추가
        model.addAttribute("currentUserID", currentUserID); // currentUserID 추가

        return "studygroupdetail";
    }


    @PostMapping("/joinGroup/{groupID}")
    public String joinGroup(@PathVariable int groupID, HttpSession session) {
        // 사용자 로그인 여부 확인
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }

        // 사용자 정보 가져오기
        User user = (User) session.getAttribute("user");

        // GroupMembers 테이블에 데이터 추가
        String insertGroupMemberQuery = "INSERT INTO GroupMembers (GroupID, UserID) VALUES (?, ?)";
        jdbcTemplate.update(insertGroupMemberQuery, groupID, user.getUserID());

        // 가입 후 상세 페이지로 이동
        return "redirect:/studygroup/" + groupID;
    }

    // 내용 수정 엔드포인트 추가
    @PostMapping("/editStudyLog/{groupID}")
    public String editStudyLog(@PathVariable int groupID, HttpSession session,
                               @RequestParam("logID") int logID,
                               @RequestParam("studyDuration") int studyDuration,
                               @RequestParam("studyTopic") String studyTopic,
                               @RequestParam("studyDate") @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate studyDate) {
        // 사용자 로그인 여부 확인
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }

        // GroupStudyLog 업데이트
        String updateGroupLogQuery =
                "UPDATE GroupStudyLog SET GroupStudyDuration = ?, GroupTopic = ?, GroupStudyDate = ? WHERE GroupLogID = ?";
        jdbcTemplate.update(updateGroupLogQuery, studyDuration, studyTopic, java.sql.Date.valueOf(studyDate), logID);

        // 수정 후 상세 페이지로 리디렉션
        return "redirect:/studygroup/" + groupID;
    }

    // 내용 작성 엔드포인트 추가
    @PostMapping("/writeStudyLog/{groupID}")
    public String writeStudyLog(@PathVariable int groupID, HttpSession session,
                                @RequestParam("studyDuration") int studyDuration,
                                @RequestParam("studyTopic") String studyTopic,
                                @RequestParam("studyDate") @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate studyDate) {
        // 사용자 로그인 여부 확인
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }

        // 사용자 정보 가져오기
        User user = (User) session.getAttribute("user");

        // GroupStudyLog에 데이터 추가
        String insertGroupLogQuery =
                "INSERT INTO GroupStudyLog (GroupID, UserID, GroupStudyDate, GroupStudyDuration, GroupTopic) VALUES (?, ?, ?, ?, ?)";
        jdbcTemplate.update(insertGroupLogQuery, groupID, user.getUserID(), java.sql.Date.valueOf(studyDate), studyDuration, studyTopic);

        // 작성 후 상세 페이지로 리디렉션
        return "redirect:/studygroup/" + groupID;
    }
}
