package com.example.eduvate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
public class StudyController {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @GetMapping("/study")
    public String studyForm(Model model, HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }

        StudyLog studyLog = new StudyLog();
        // 날짜 자동으로 설정
        studyLog.setStudyDate(java.sql.Date.valueOf(java.time.LocalDate.now()));

        model.addAttribute("studyLog", studyLog);
        return "study";
    }

    @PostMapping("/study")
    public String study(HttpSession session, @RequestParam("studyDate") String studyDate,
                        @RequestParam("studyDuration") int studyDuration, @RequestParam("studyTopic") String studyTopic,
                        Model model) {
        // 사용자가 로그인되어 있는지 확인
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }

        User user = (User) session.getAttribute("user");
        System.out.println("user.getUserID(): " + user.getUserID());

        // studyDate를 필요한 형식으로 파싱 (예: yyyy-MM-dd)
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date parsedDate = null;

        try {
            parsedDate = dateFormat.parse(studyDate);
        } catch (ParseException e) {
            e.printStackTrace();
            // 잘못된 형식의 날짜라면 적절한 처리
            model.addAttribute("errorMessage", "유효하지 않은 날짜 형식입니다.");
            return "errorPage";
        }

        // 날짜가 성공적으로 파싱되었는지 확인
        if (parsedDate != null) {
            // 입력된 데이터로 StudyLog 객체 생성
            StudyLog studyLog = new StudyLog();
            studyLog.setUserID(user.getUserID()); // 변경된 부분
            System.out.println("studyLog.getUserID(): " + studyLog.getUserID());
            studyLog.setStudyDate(parsedDate);
            studyLog.setStudyDuration(studyDuration);
            studyLog.setTopic(studyTopic);

            // StudyLog를 데이터베이스에 저장
            String checkRecordQuery = "SELECT COUNT(*) FROM StudyLog WHERE userID = ? AND StudyDate = ?";
            int count = jdbcTemplate.queryForObject(checkRecordQuery, Integer.class, user.getUserID(), studyLog.getStudyDate());

            if (count > 0) {
                // 이미 해당 날짜의 기록이 있다면 수정 처리
                String updateQuery = "UPDATE StudyLog SET StudyDuration = ?, Topic = ? WHERE userID = ? AND StudyDate = ?";
                jdbcTemplate.update(updateQuery, studyLog.getStudyDuration(), studyLog.getTopic(), user.getUserID(), studyLog.getStudyDate());
            } else {
                // 해당 날짜의 기록이 없다면 새로운 기록 추가
                String insertQuery = "INSERT INTO StudyLog (userID, StudyDate, StudyDuration, Topic) VALUES (?, ?, ?, ?)";
                jdbcTemplate.update(insertQuery, studyLog.getUserID(), studyLog.getStudyDate(), studyLog.getStudyDuration(), studyLog.getTopic());
            }

            return "redirect:/myroom";
        } else {
            // 날짜 파싱에 실패한 경우에 대한 처리
            model.addAttribute("errorMessage", "유효하지 않은 날짜 형식입니다.");
            return "errorPage";
        }
    }


    @GetMapping("/myroom")
    public String dashboard(@RequestParam(required = false) String date, Model model, HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }

        User user = (User) session.getAttribute("user");
        System.out.println("User ID from session: " + (user != null ? user.getUserID() : "null"));

        // 요청된 날짜가 없으면 오늘 날짜를 기본값으로 설정
        final String selectedDate = (date == null || date.isEmpty()) ? java.time.LocalDate.now().toString() : date;

        // 해당 날짜에 해당하는 기록만 가져오도록 쿼리 수정
        String selectQuery = "SELECT * FROM StudyLog WHERE userID = ? AND StudyDate = ?";

        List<StudyLog> studyLogs = jdbcTemplate.query(selectQuery, (preparedStatement) -> {
            preparedStatement.setString(1, user.getUserID());
            preparedStatement.setObject(2, java.time.LocalDate.parse(selectedDate));
        }, (resultSet, rowNum) -> {
            StudyLog log = new StudyLog();
            log.setUserID(user.getUserID());
            log.setStudyDate(resultSet.getDate("StudyDate"));
            log.setStudyDuration(resultSet.getInt("StudyDuration"));
            log.setTopic(resultSet.getString("Topic"));
            return log;
        });

        model.addAttribute("studyLogs", studyLogs);
        model.addAttribute("selectedDate", selectedDate); // 선택된 날짜를 모델에 추가

        return "myroom";
    }

    @PostMapping("/editStudy")
    public String editStudyForm(HttpSession session, @RequestParam("userID") String userID,
                                @RequestParam("studyDate") String studyDate, Model model) {
        // 사용자 로그인 여부 확인
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }

        User user = (User) session.getAttribute("user");
        System.out.println("user.getUserID(): " + user.getUserID());

        // studyDate를 필요한 형식으로 파싱 (예: yyyy-MM-dd)
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date parsedDate;

        try {
            parsedDate = dateFormat.parse(studyDate);
        } catch (ParseException e) {
            e.printStackTrace();
            // 잘못된 형식의 날짜라면 적절한 처리
            model.addAttribute("errorMessage", "유효하지 않은 날짜 형식입니다.");
            return "errorPage";
        }

        // 날짜가 성공적으로 파싱되었는지 확인
        if (parsedDate != null) {
            // 해당 날짜의 기록을 가져옴
            String selectQuery = "SELECT * FROM StudyLog WHERE userID = ? AND StudyDate = ?";
            List<StudyLog> studyLogs = jdbcTemplate.query(selectQuery, (preparedStatement) -> {
                preparedStatement.setString(1, user.getUserID());
                preparedStatement.setObject(2, parsedDate);
            }, (resultSet, rowNum) -> {
                StudyLog log = new StudyLog();
                log.setUserID(user.getUserID());
                log.setStudyDate(resultSet.getDate("StudyDate"));
                log.setStudyDuration(resultSet.getInt("StudyDuration"));
                log.setTopic(resultSet.getString("Topic"));
                return log;
            });

            // 수정 폼으로 전달
            model.addAttribute("studyLog", studyLogs.get(0));
            return "myroom";
        } else {
            // 날짜 파싱에 실패한 경우에 대한 처리
            model.addAttribute("errorMessage", "유효하지 않은 날짜 형식입니다.");
            return "errorPage";
        }
    }
    
    @PostMapping("/updateStudy")
    public String updateStudy(@RequestParam("userID") String userID,
                              @RequestParam("studyDate") String studyDate,
                              @RequestParam("studyDuration") int studyDuration,
                              @RequestParam("studyTopic") String studyTopic) {
        // Update the StudyLog in the database
        String updateQuery = "UPDATE StudyLog SET StudyDuration = ?, Topic = ? WHERE userID = ? AND StudyDate = ?";
        jdbcTemplate.update(updateQuery, studyDuration, studyTopic, userID, java.sql.Date.valueOf(java.time.LocalDate.parse(studyDate)));

        return "redirect:/myroom";
    }
}






