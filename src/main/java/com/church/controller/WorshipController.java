/*
    작성자 : 박지원
    작성일 : 2023-04-10
*/
package com.church.controller;

import com.church.domain.SchedulePageHandler;
import com.church.domain.SearchCondition;
import com.church.domain.Worship;
import com.church.service.WorshipService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/worship")
public class WorshipController {
    private final WorshipService worshipService;

    @GetMapping("/list")
    public String list(SearchCondition sc, Model model){
        try {
            int totalCnt = worshipService.worshipSearchCount(sc);
            SchedulePageHandler sph = new SchedulePageHandler(totalCnt, sc);
            List<Worship> list = worshipService.worshipSearchPage(sc);
            model.addAttribute("sph", sph);
            model.addAttribute("worshipList", list);
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg","listError");
        }
        return "worship/list";
    }
    @GetMapping("/view")
    public String view(@RequestParam int wno, SearchCondition sc, Model model, RedirectAttributes attr){
        try {
            Worship worship = worshipService.worshipView(wno);
            if(wno!=worship.getWno()){
                throw new Exception();
            }
            model.addAttribute("worship", worship);
            model.addAttribute("mode", "view");
        } catch (Exception e) {
            e.printStackTrace();
            attr.addFlashAttribute("msg", "viewError");
            return "redirect:/worship/list" + sc.getQueryString();
        }
        return "worship/worship";
    }
    @GetMapping("/register")
    public String register(Model model){
        model.addAttribute("mode", "new");
        return "worship/worship";
    }
    @PostMapping("/register")
    public String register(Worship worship, RedirectAttributes attr, Model model){
        try {
            String embedUrl = worship.getWfile().replace("https://www.youtube.com/watch?v=", "https://www.youtube.com/embed/");
            worship.setWfile(embedUrl);
            String thumbnail = embedUrl.replace("https://www.youtube.com/embed/","https://img.youtube.com/vi/");
            worship.setWimg(thumbnail + "/0.jpg");
            if(worshipService.worshipRegister(worship)){
                attr.addFlashAttribute("msg", "registerOk");
                return "redirect:/worship/list";
            } else{
                throw new Exception("worshipService.worshipRegister(worship) != 1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Exception : " + e.getMessage());
            model.addAttribute("worship", worship);
            model.addAttribute("mode", "new");
            model.addAttribute("msg", "writerError");
            return "worship/worship";
        }
    }
    @PostMapping("/modify")
    public String update(SearchCondition sc, Worship worship, Model model, RedirectAttributes attr){
        try {
            String embedUrl = worship.getWfile().replace("https://www.youtube.com/watch?v=", "https://www.youtube.com/embed/");
            worship.setWfile(embedUrl);
            String thumbnail = embedUrl.replace("https://www.youtube.com/embed/","https://img.youtube.com/vi/");
            worship.setWimg(thumbnail + "/0.jpg");
            if(worshipService.worshipModify(worship)){
                attr.addFlashAttribute("msg", "modifyOk");
                return "redirect:/worship/list" + sc.getQueryString();
            } else{
                throw new Exception("worshipService.worshipModify(worship)!=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Exception : " + e.getMessage());
            model.addAttribute("msg", "modelError");
            model.addAttribute("worship", worship);
            return "worship/worship";
        }
    }
    @PostMapping("/adminRemove")
    public String removeForAdmin(@RequestParam int wno, SearchCondition sc, RedirectAttributes attr){
        try {
            if(worshipService.worshipRemoveForAdmin(wno)){
                attr.addFlashAttribute("msg", "removeOk");
            } else{
                throw new Exception("worshipService.worshipRemoveForAdmin(map) != 1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
            attr.addAttribute("removeError");
        }
        return "redirect:/worship/list" + sc.getQueryString();
    }

}
