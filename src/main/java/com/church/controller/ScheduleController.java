/*
    작성자 : 박지원
    작성일 : 2023-04-05
*/
package com.church.controller;

import com.church.domain.Schedule;
import com.church.domain.SchedulePageHandler;
import com.church.service.ScheduleService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/schedule")
public class ScheduleController {
    private final ScheduleService scheduleService;

    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "10") int pageSize, Model model, RedirectAttributes attr){
        Map map = new HashMap();
        map.put("offset", (page-1) * pageSize);
        map.put("pageSize", pageSize);
        try {
            int totalCnt = scheduleService.scheduleTotalCnt();
            SchedulePageHandler sph = new SchedulePageHandler(totalCnt, page, pageSize);
            List<Schedule> list = scheduleService.schedulePageList(map);
            model.addAttribute("sph", sph);
            model.addAttribute("scheduleList", list);
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg","listError");
        }
        return "schedule/list";
    }
    @GetMapping("/view")
    public String view(@RequestParam int sno, @RequestParam int page, @RequestParam(defaultValue = "10") int pageSize, Model model, RedirectAttributes attr){
        try {
            Schedule schedule = scheduleService.scheduleView(sno);
            model.addAttribute("schedule", schedule);
            model.addAttribute("page", page);
            model.addAttribute("pageSize", pageSize);
        } catch (Exception e) {
            e.printStackTrace();
            attr.addAttribute("page", page);
            attr.addAttribute("pageSize", pageSize);
            attr.addFlashAttribute("msg", "viewError");
            return "redirect:/schedule/list";
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
    public String update(@RequestParam int page, @RequestParam(defaultValue = "10") int pageSize, Schedule schedule, Model model, RedirectAttributes attr){
        try {
            if(scheduleService.scheduleModify(schedule)){
                attr.addAttribute("sno", schedule.getSno());
                attr.addAttribute("page", page);
                attr.addAttribute("pageSize", pageSize);
                attr.addFlashAttribute("msg", "modifyOk");
                return "redirect:schedule/view";
            } else{
                throw new Exception("scheduleService.scheduleModify(schedule)!=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Exception : " + e.getMessage());
            model.addAttribute("msg", "modelError");
            model.addAttribute("schedule", schedule);
            model.addAttribute("page", page);
            model.addAttribute("pageSize", pageSize);
            return "schedule/schedule";
        }
    }
    @PostMapping("/remove")
    public String remove(@RequestParam int sno, @RequestParam int page, @RequestParam(defaultValue = "10") int pageSize, @RequestParam String swriter, RedirectAttributes attr){
        Map map = new HashMap();
        map.put("sno", sno);
        map.put("swriter", swriter);
        try {
            if(scheduleService.scheduleRemove(map)){
                attr.addAttribute("page", page);
                attr.addAttribute("pageSize", pageSize);
                attr.addFlashAttribute("msg", "removeOk");
            } else{
                throw new Exception("scheduleService.scheduleRemove(map) != 1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
            attr.addAttribute("removeError");
        }
        return "redirect:/schedule/list";
    }
    @PostMapping("/adminRemove")
    public String removeForAdmin(@RequestParam int sno, @RequestParam int page, @RequestParam(defaultValue = "10") int pageSize, RedirectAttributes attr){
        try {
            if(scheduleService.scheduleRemoveForAdmin(sno)){
                attr.addAttribute("page", page);
                attr.addAttribute("pageSize", pageSize);
                attr.addFlashAttribute("msg", "removeOk");
            } else{
                throw new Exception("scheduleService.scheduleRemoveForAdmin(map) != 1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
            attr.addAttribute("removeError");
        }
        return "redirect:/schedule/list";
    }

}
