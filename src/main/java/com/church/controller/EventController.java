/*
    작성자 : 박지원
    작성일 : 2023-04-10
*/
package com.church.controller;

import com.church.domain.SchedulePageHandler;
import com.church.domain.SearchCondition;
import com.church.domain.Event;
import com.church.service.EventService;
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
@RequestMapping("/event")
public class EventController {
    private final EventService eventService;

    @GetMapping("/list")
    public String list(SearchCondition sc, Model model){
        try {
            int totalCnt = eventService.eventSearchCount(sc);
            SchedulePageHandler sph = new SchedulePageHandler(totalCnt, sc);
            List<Event> list = eventService.eventSearchPage(sc);
            model.addAttribute("sph", sph);
            model.addAttribute("eventList", list);
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg","listError");
        }
        return "event/list";
    }
    @GetMapping("/view")
    public String view(@RequestParam int eno, SearchCondition sc, Model model, RedirectAttributes attr){
        try {
            Event event = eventService.eventView(eno);
            if(eno!=event.getEno()){
                throw new Exception();
            }
            model.addAttribute("event", event);
            model.addAttribute("mode", "view");
        } catch (Exception e) {
            e.printStackTrace();
            attr.addFlashAttribute("msg", "viewError");
            return "redirect:/event/list" + sc.getQueryString();
        }
        return "event/event";
    }
    @GetMapping("/register")
    public String register(Model model){
        model.addAttribute("mode", "new");
        return "event/event";
    }
    @PostMapping("/register")
    public String register(Event event, RedirectAttributes attr, Model model){
        try {
            String embedUrl = event.getEfile().replace("https://www.youtube.com/watch?v=", "https://www.youtube.com/embed/");
            event.setEfile(embedUrl);
            String thumbnail = embedUrl.replace("https://www.youtube.com/embed/","https://img.youtube.com/vi/");
            event.setEimg(thumbnail + "/0.jpg");
            if(eventService.eventRegister(event)){
                attr.addFlashAttribute("msg", "registerOk");
                return "redirect:/event/list";
            } else{
                throw new Exception("eventService.eventRegister(event) != 1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Exception : " + e.getMessage());
            model.addAttribute("event", event);
            model.addAttribute("mode", "new");
            model.addAttribute("msg", "writerError");
            return "event/event";
        }
    }
    @PostMapping("/modify")
    public String update(SearchCondition sc, Event event, Model model, RedirectAttributes attr){
        try {
            String embedUrl = event.getEfile().replace("https://www.youtube.com/watch?v=", "https://www.youtube.com/embed/");
            event.setEfile(embedUrl);
            String thumbnail = embedUrl.replace("https://www.youtube.com/embed/","https://img.youtube.com/vi/");
            event.setEimg(thumbnail + "/0.jpg");
            if(eventService.eventModify(event)){
                attr.addFlashAttribute("msg", "modifyOk");
                return "redirect:/event/list" + sc.getQueryString();
            } else{
                throw new Exception("eventService.eventModify(event)!=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Exception : " + e.getMessage());
            model.addAttribute("msg", "modelError");
            model.addAttribute("event", event);
            return "event/event";
        }
    }
    @PostMapping("/adminRemove")
    public String removeForAdmin(@RequestParam int eno, SearchCondition sc, RedirectAttributes attr){
        try {
            if(eventService.eventRemoveForAdmin(eno)){
                attr.addFlashAttribute("msg", "removeOk");
            } else{
                throw new Exception("eventService.eventRemoveForAdmin(map) != 1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
            attr.addAttribute("removeError");
        }
        return "redirect:/event/list" + sc.getQueryString();
    }

}
