package com.church.controller;

import com.church.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    UsersService usersService;
    @Autowired
    WeeklyService weeklyService;
    @Autowired
    WorshipService worshipService;
    @Autowired
    PraiseService praiseService;
    @Autowired
    BoardService boardsService;
    @Autowired
    AlbumsService albumsService;
    @Autowired
    ScheduleService scheduleService;
    @Autowired
    NoticeService noticeService;
    @Autowired
    EventService eventService;
    @Autowired
    PickUpsService pickUpsService;


    @GetMapping("/main")
    public String main(Model model) throws Exception {
        model.addAttribute("countUsers", usersService.countUsers());
        model.addAttribute("countWeekly", weeklyService.count());
        model.addAttribute("countWorships", worshipService.count());
        model.addAttribute("countPraises", praiseService.count());
        model.addAttribute("countBoards", boardsService.count());
        model.addAttribute("countAlbums", albumsService.count());
        model.addAttribute("countSchedules", scheduleService.scheduleTotalCnt());
        model.addAttribute("countNotices", noticeService.count());
        model.addAttribute("countEvents", eventService.count());
        model.addAttribute("countPickUp", pickUpsService.count());

        return "admin/adminMain";
    }
}
