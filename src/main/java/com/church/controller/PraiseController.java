/*
    작성자 : 박지원
    작성일 : 2023-04-05
*/
package com.church.controller;

import com.church.domain.Praise;
import com.church.domain.SchedulePageHandler;
import com.church.domain.SearchCondition;
import com.church.service.PraiseService;
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
@RequestMapping("/praise")
public class PraiseController {
    private final PraiseService praiseService;

    @GetMapping("/list")
    public String list(SearchCondition sc, Model model){
        try {
            int totalCnt = praiseService.praiseSearchCount(sc);
            SchedulePageHandler sph = new SchedulePageHandler(totalCnt, sc);
            List<Praise> list = praiseService.praiseSearchPage(sc);
            model.addAttribute("sph", sph);
            model.addAttribute("praiseList", list);
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg","listError");
        }
        return "praise/list";
    }
    @GetMapping("/view")
    public String view(@RequestParam int sno, SearchCondition sc, Model model, RedirectAttributes attr){
        try {
            Praise praise = praiseService.praiseView(sno);
            model.addAttribute("praise", praise);
            model.addAttribute("mode", "view");
        } catch (Exception e) {
            e.printStackTrace();
            attr.addFlashAttribute("msg", "viewError");
            return "redirect:/praise/list" + sc.getQueryString();
        }
        return "praise/praise";
    }
    @GetMapping("/register")
    public String register(Model model){
        model.addAttribute("mode", "new");
        return "praise/praise";
    }
    @PostMapping("/register")
    public String register(Praise praise, RedirectAttributes attr, Model model){
        try {
            if(praiseService.praiseRegister(praise)){
                attr.addFlashAttribute("msg", "registerOk");
                return "redirect:/praise/list";
            } else{
                throw new Exception("praiseService.praiseRegister(praise) != 1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Exception : " + e.getMessage());
            model.addAttribute("praise", praise);
            model.addAttribute("mode", "new");
            model.addAttribute("msg", "writerError");
            return "praise/praise";
        }
    }
    @PostMapping("/modify")
    public String update(SearchCondition sc, Praise praise, Model model, RedirectAttributes attr){
        try {
            if(praiseService.praiseModify(praise)){
                attr.addFlashAttribute("msg", "modifyOk");
                return "redirect:/praise/list" + sc.getQueryString();
            } else{
                throw new Exception("praiseService.praiseModify(praise)!=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Exception : " + e.getMessage());
            model.addAttribute("msg", "modelError");
            model.addAttribute("praise", praise);
            return "praise/praise";
        }
    }
    @PostMapping("/adminRemove")
    public String removeForAdmin(@RequestParam int sno, SearchCondition sc, RedirectAttributes attr){
        try {
            if(praiseService.praiseRemoveForAdmin(sno)){
                attr.addFlashAttribute("msg", "removeOk");
            } else{
                throw new Exception("praiseService.praiseRemoveForAdmin(map) != 1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
            attr.addAttribute("removeError");
        }
        return "redirect:/praise/list" + sc.getQueryString();
    }

}
