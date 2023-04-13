package com.church.handler;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class CustomAccessDeniedHandler implements AccessDeniedHandler {

    private final String mainPage = "/";

    @Override
    public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException accessDeniedException) throws IOException, ServletException {
        if (!response.isCommitted()) {
            HttpSession session = request.getSession();
            String errorMessage;

            errorMessage = "권한이 없습니다.<br>관리자 계정으로 접속해주세요.";

            session.setAttribute("errorMessage", errorMessage);

            response.sendRedirect(mainPage);
        }
    }
}
