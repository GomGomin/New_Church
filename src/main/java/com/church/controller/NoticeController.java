//작성자 : 심현민
//최초 작성일 : 23.04.04
package com.church.controller;

import com.church.domain.Notice;
import com.church.domain.Paging;
import com.church.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneOffset;
import java.util.List;

@Controller
@RequestMapping("notice")
public class NoticeController {

    @Autowired
    NoticeService noticeService;

    @GetMapping("/setNewNotice")
    public String requestAddNoticeForm(@ModelAttribute("NewNotice") Notice notice) {
        return "notice/addNotice";
    }

    @PostMapping("/setNewNotice")
    public String submitAddNoticeForm(@ModelAttribute("NewNotice") Notice notice) {
        noticeService.newNotice(notice);

        return "redirect:/notice/list";
    }

    @GetMapping("/list")
    public String list(Model model, @RequestParam(value = "num",required = false, defaultValue = "1") int num,
                     @RequestParam(value = "searchType",required = false, defaultValue = "title") String searchType,
                     @RequestParam(value = "keyword",required = false, defaultValue = "") String keyword) throws Exception {
        Paging page = new Paging();

        page.setNum(num);
        page.setCount(noticeService.searchCount(searchType, keyword));
        page.setSearchType(searchType);
        page.setKeyword(keyword);
        int endPage = (int)Math.ceil(noticeService.searchCount(searchType, keyword)/page.getPostNum()) + 1;

        List<Notice> list = null;
        list = noticeService.list(page.getDisplayPost(), page.getPostNum(), searchType, keyword);

        model.addAttribute("list", list);
        model.addAttribute("page", page);
        model.addAttribute("select", num);
        model.addAttribute("endPage", endPage);

        return "notice/listNotice";
    }

    @GetMapping("/detail")
    public String requestNoticeById(@RequestParam("nno") int nno, @RequestParam("username") String username,
                                    HttpServletRequest request, HttpServletResponse response, Model model) {
        // 게시물
        Notice noticeById = noticeService.noticeById(nno);
        if (noticeById == null) {
            HttpSession session = request.getSession();
            String errorMessage;

            errorMessage = "존재하지 않는 게시물 입니다.<br>다시 이용해주세요.";

            session.setAttribute("errorMessage", errorMessage);

            return "redirect:/notice/list";
        }
        model.addAttribute("notice", noticeById);

        viewCountValidation(noticeById, nno, username, request, response);

        return "notice/notice";
    }

    private void viewCountValidation(Notice notice, int nno, String username,
                                    HttpServletRequest request, HttpServletResponse response) {
        Cookie[] cookies = request.getCookies();

        Cookie cookie = null;
        boolean isCookie = false;

        // request에 쿠키들이 있을 때
        for (int i = 0; cookies != null && i < cookies.length; i++) {
            // 사용자명_notice 쿠키가 있을 때
            if (cookies[i].getName().equals(username + "_notice")) {//다른 게시판은 "_notice" 변경
                // cookie 변수에 저장
                cookie = cookies[i];
                // 만약 cookie 값에 현재 게시글 번호가 없을 때
                if (!cookie.getValue().contains("[" + notice.getNno() + "]")) {
                    // 해당 게시글 조회수를 증가시키고, 쿠키 값에 해당 게시글 번호를 추가
                    noticeService.updateView(nno);
                    cookie.setValue(cookie.getValue() + "[" + notice.getNno() + "]");
                }
                isCookie = true;
                break;
            }
        }
        // 만약 사용자명_notice라는 쿠키가 없으면 처음 접속한 것이므로 새로 생성
        if (!isCookie) {
            noticeService.updateView(nno);
            cookie = new Cookie(username + "_notice", "[" + notice.getNno() + "]"); // 새 쿠키 생성
        }

        // 쿠키 유지시간을 오늘 하루 자정까지로 설정
        long todayEndSecond = LocalDate.now().atTime(LocalTime.MAX).toEpochSecond(ZoneOffset.UTC);
        long currentSecond = LocalDateTime.now().toEpochSecond(ZoneOffset.UTC);
        cookie.setPath("/"); // 모든 경로에서 접근 가능
        cookie.setMaxAge((int) (todayEndSecond - currentSecond + 32400));//크롬 UTC 기준 +9시간(32400초) 필요
        response.addCookie(cookie);
    }


    @ResponseBody
    @RequestMapping("/removeNotice")
    public void removeNotice(@RequestParam("nno") String nno) {
        noticeService.removeNotice(nno);
    }

    @GetMapping("/edit")
    public String requestEditNotice(@RequestParam("nno") int nno, Model model, HttpServletRequest request,
                                    @ModelAttribute("EditNotice") Notice notice) {
        Notice noticeById = noticeService.noticeById(nno);
        if (noticeById == null) {
            HttpSession session = request.getSession();
            String errorMessage;

            errorMessage = "존재하지 않는 게시물 입니다.<br>다시 이용해주세요.";

            session.setAttribute("errorMessage", errorMessage);

            return "redirect:/notice/list";
        }
        model.addAttribute("notice", noticeById);

        return "notice/editNotice";
    }

    @PostMapping("/edit")
    public String submitEditNotice(@ModelAttribute("EdiNotice") Notice notice) {
        noticeService.editNotice(notice);
        return "redirect:/notice/detail?nno="+notice.getNno()+"&username="+notice.getNwriter();
    }
}