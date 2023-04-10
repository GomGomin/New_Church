/*
    작성자 : 박지원
    작성일 : 2023-04-05
*/
package com.church.controller;

import com.church.domain.ScheduleReply;
import com.church.service.ScheduleReplyService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
public class ScheduleReplyController {
    private final ScheduleReplyService scheduleReplyService;

    @GetMapping("/reply")
    public ResponseEntity<List<ScheduleReply>> list(int sno) {
        try {
            List<ScheduleReply> list = scheduleReplyService.list(sno);
            return new ResponseEntity<>(list, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.OK);
        }
    }
    @PostMapping("/reply/{rno}")
    public ResponseEntity<String> remove(@PathVariable("rno") int rno, @RequestParam("sno") int sno, @RequestParam("rwriter") String rwriter){
        try {
            if(scheduleReplyService.remove(rno, rwriter, sno)!=1){
                throw new Exception("Delete Failed");
            }
            return new ResponseEntity<>("deleteOk",HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("exception : " + e.getMessage());
            return new ResponseEntity<>("deleteError",HttpStatus.BAD_REQUEST);

        }
    }
    @PostMapping("/reply")
    public ResponseEntity<ScheduleReply> register(@RequestBody ScheduleReply scheduleReply){
        System.out.println("ASfdasfd : " + scheduleReply);
        try {
            if(scheduleReplyService.register(scheduleReply)!=1){
                throw new Exception("Register Failed");
            }
            return new ResponseEntity<>(scheduleReply,HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }
    @PatchMapping("/reply/{rno}")
    public ResponseEntity<ScheduleReply> update(@RequestBody ScheduleReply scheduleReply){
        try {
            if(scheduleReplyService.modify(scheduleReply)!=1){
                throw new Exception("Modify Failed");
            }
            return new ResponseEntity<>(scheduleReply,HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }
}
