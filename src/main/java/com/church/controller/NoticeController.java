//작성자 : 심현민
//최초 작성일 : 23.04.04
package com.church.controller;

import java.util.List;
import java.util.Map;

import com.church.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.church.domain.Notice;
import com.church.domain.Paging;
import com.church.service.NoticeService;

@Controller
@RequestMapping("notice")
public class NoticeController {

    @Autowired
    NoticeService noticeService;

    @GetMapping("setNewNotice")
    public String requestAddBoardForm(@ModelAttribute("NewNotice") Notice notice) {
        return "notice/addNotice";
    }

    @PostMapping("/setNewNotice")
    public String submitAddBoardForm(@ModelAttribute("NewNotice") Notice notice) {
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

        List<Notice> list = null;
        list = noticeService.list(page.getDisplayPost(), page.getPostNum(), searchType, keyword);

        model.addAttribute("list", list);
        model.addAttribute("page", page);
        model.addAttribute("select", num);

        return "notice/listNotice";
    }

    @GetMapping("/detail")
    public String requestBoardById(@RequestParam("nno") String nno, @RequestParam("username") String username, Model model) {
        // 게시물
        Notice noticeById = noticeService.noticeById(nno);
        model.addAttribute("notice", noticeById);

        //작성자 아닐 시에 조회수 증가
        if(!username.equals(noticeById.getNwriter())) { noticeService.updateView(nno); }

        return "notice/notice";
    }

    @ResponseBody
    @RequestMapping("/removeNotice")
    public void removeNotice(@RequestParam("nno") String nno) {
        noticeService.removeNotice(nno);
    }

    @GetMapping("/edit")
    public String requestEditNotice(@RequestParam("nno") String bno, Model model, @ModelAttribute("EditNotice") Notice notice) {
        Notice noticeById = noticeService.noticeById(bno);
        model.addAttribute("notice", noticeById);

        return "notice/editNotice";
    }

    @PostMapping("/edit")
    public String submitEditNotice(@ModelAttribute("EdiNotice") Notice notice) {
        noticeService.editNotice(notice);
        return "redirect:/notice/detail?nno="+notice.getNno()+"&username="+notice.getNwriter();
    }
}