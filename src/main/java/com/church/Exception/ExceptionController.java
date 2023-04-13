/*
    작성자 : 박지원
    작성일 : 2023-04-13
*/
package com.church.Exception;

import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

@ControllerAdvice
public class ExceptionController {
    @ExceptionHandler(RuntimeException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST) //200->400 상태코드 변경해서 응답
    public String runtimeCatcher(Exception e, Model model) {
        model.addAttribute("msg", "400");/*model.addAttribute("e", e);*/
        return "exception/error";
    }
    @ExceptionHandler(NoHandlerFoundException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND) //404
    public String noHandlerFoundCatcher(Model model){
        model.addAttribute("msg", "404");
        return "exception/error";
    }
    @ExceptionHandler(Exception.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR) //500
    public String commonCatcher(Model model){
        model.addAttribute("msg", "500");
        return "exception/error";
    }
}
