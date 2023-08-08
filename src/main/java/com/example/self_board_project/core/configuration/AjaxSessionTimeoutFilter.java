package com.example.self_board_project.core.configuration;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.AuthenticationException;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AjaxSessionTimeoutFilter implements Filter {

    private String ajaxHeader = "AJAX";

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        if (isAjaxRequest(req)) {
            System.out.println(">>>isAjaxRequest 통과");
            try {
                System.out.println(">>>chain.doFilter 시작");
                chain.doFilter(req, res);
            } catch (AccessDeniedException e) {
                System.out.println(">>>SC_FORBIDDEN 시작");
                res.sendError(HttpServletResponse.SC_FORBIDDEN);
            } catch (AuthenticationException e) {
                System.out.println(">>>SC_UNAUTHORIZED 시작");
                res.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            }
        } else{
            chain.doFilter(req, res);
        }
    }

    private boolean isAjaxRequest(HttpServletRequest req) {
        return req.getHeader(ajaxHeader) != null
                && req.getHeader(ajaxHeader).equals(Boolean.TRUE.toString());
    }

    public void init(FilterConfig filterConfig) throws ServletException {}
    public void destroy() {}

}
