package com.chesscourse.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Hapus session
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        // Redirect ke login halaman
        response.sendRedirect("index.jsp");
    }
}
