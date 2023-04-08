/*
    작성자 : 박지원
    작성일 : 2023-04-05
*/
package com.church.controller;

import com.church.domain.Schedule;
import com.church.domain.SchedulePageHandler;
import com.church.domain.SearchCondition;
import com.church.service.ScheduleService;
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
@RequestMapping("/schedule")
public class ScheduleController {
    private final ScheduleService scheduleService;

    @GetMapping("/list")
    public String list(SearchCondition sc, Model model, RedirectAttributes attr){
        try {
            int totalCnt = scheduleService.scheduleSearchCount(sc);
            SchedulePageHandler sph = new SchedulePageHandler(totalCnt, sc);
            List<Schedule> list = scheduleService.scheduleSearchPage(sc);
            model.addAttribute("sph", sph);
            model.addAttribute("scheduleList", list);
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg","listError");
        }
        return "schedule/list";
    }
    @GetMapping("/view")
    public String view(@RequestParam int sno, SearchCondition sc, Model model, RedirectAttributes attr){
        try {
            Schedule schedule = scheduleService.scheduleView(sno);
            model.addAttribute("schedule", schedule);
            model.addAttribute("mode", "view");
        } catch (Exception e) {
            e.printStackTrace();
            attr.addFlashAttribute("msg", "viewError");
            return "redirect:/schedule/list" + sc.getQueryString();
        }
        return "schedule/schedule";
    }
    @GetMapping("/register")
    public String register(Model model){
        model.addAttribute("mode", "new");
        return "schedule/schedule";
    }
    @PostMapping("/register")
    public String register(Schedule schedule, RedirectAttributes attr, Model model){
        try {
            if(scheduleService.scheduleRegister(schedule)){
                attr.addFlashAttribute("msg", "registerOk");
                return "redirect:/schedule/list";
            } else{
                throw new Exception("scheduleService.scheduleRegister(schedule) != 1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Exception : " + e.getMessage());
            model.addAttribute("schedule", schedule);
            model.addAttribute("mode", "new");
            model.addAttribute("msg", "writerError");
            return "schedule/schedule";
        }
    }
    @PostMapping("/modify")
    public String update(SearchCondition sc, Schedule schedule, Model model, RedirectAttributes attr){
        try {
            if(scheduleService.scheduleModify(schedule)){
                attr.addFlashAttribute("msg", "modifyOk");
                return "redirect:/schedule/list" + sc.getQueryString();
            } else{
                throw new Exception("scheduleService.scheduleModify(schedule)!=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Exception : " + e.getMessage());
            model.addAttribute("msg", "modelError");
            model.addAttribute("schedule", schedule);
            return "schedule/schedule";
        }
    }
    @PostMapping("/adminRemove")
    public String removeForAdmin(@RequestParam int sno, SearchCondition sc, RedirectAttributes attr){
        try {
            if(scheduleService.scheduleRemoveForAdmin(sno)){
                attr.addFlashAttribute("msg", "removeOk");
            } else{
                throw new Exception("scheduleService.scheduleRemoveForAdmin(map) != 1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
            attr.addAttribute("removeError");
        }
        return "redirect:/schedule/list" + sc.getQueryString();
    }

}
