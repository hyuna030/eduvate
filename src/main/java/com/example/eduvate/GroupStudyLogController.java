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
@RequestMapping("/groupstudylog")
public class GroupStudyLogController {

 @Autowired
 private JdbcTemplate jdbcTemplate;

 @GetMapping
 public String getGroupStudyLogs(@RequestParam(name = "date", required = false) String date,
                                 HttpSession session, Model model) {
     // 사용자 로그인 여부 확인
     if (session.getAttribute("user") == null) {
         return "redirect:/login";
     }

     // 날짜가 주어지지 않았을 경우, 오늘 날짜로 설정
     if (date == null || date.isEmpty()) {
         SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
         date = dateFormat.format(new Date());
     }

     // 해당 날짜의 스터디 로그 가져오기
     List<GroupStudyLog> studyLogs = getStudyLogsByDate(date);

     model.addAttribute("studyLogs", studyLogs);
     model.addAttribute("selectedDate", date);
     model.addAttribute("isLoggedIn", true);

     return "studygroupdetail";
 }

 private List<GroupStudyLog> getStudyLogsByDate(String date) {
     String query = "SELECT * FROM GroupStudyLog WHERE GroupStudyDate = ?";
     return jdbcTemplate.query(query, new Object[]{date}, (rs, rowNum) -> {
         GroupStudyLog studyLog = new GroupStudyLog();
         studyLog.setGroupLogID(rs.getInt("GroupLogID"));
         studyLog.setGroupID(rs.getInt("GroupID"));
         studyLog.setUserID(rs.getString("UserID"));
         studyLog.setGroupStudyDate(rs.getDate("GroupStudyDate"));
         studyLog.setGroupStudyDuration(rs.getInt("GroupStudyDuration"));
         studyLog.setGroupTopic(rs.getString("GroupTopic"));
         return studyLog;
     });
 }
}
