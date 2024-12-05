<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    // Hardcoded credentials (replace with database validation in real-world use)
    String validUsername = "admin";
    String validPassword = "password";

    if (username.equals(validUsername) && password.equals(validPassword)) {
        session.setAttribute("user", username);
        response.sendRedirect("uindex.jsp"); // Redirect to homepage after successful login
    } else {
        response.sendRedirect("login.jsp?error=1"); // Redirect back to login with error
    }
%>
