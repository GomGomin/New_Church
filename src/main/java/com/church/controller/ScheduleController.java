
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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/schedule")
public class ScheduleController {
    private final ScheduleService scheduleService;

    @GetMapping("/")
    public String home(){
        return "home";
    }
    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "10") int pageSize, Model model){
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
            System.out.println("Schedule list error");
            throw new RuntimeException(e);
        }
        return "schedule/list";
    }
    @GetMapping("/view")
    public String view(){

        return null;
    }
    @GetMapping("/update")
    public String update(){
        return null;
    }
    @PostMapping("/reigster")
    public String register(){
        return null;
    }
    @PostMapping("/update")
    public String update(Schedule schedule){
        return null;
    }
    @PostMapping("/remove")
    public String remove(Map map){
        return null;
    }
    @PostMapping("/adminRemove")
    public String removeForAdmin(int sno){
        return null;
    }

}
