 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*" %>
<html>
<html>
<head>
<title>访问量统计</title>
</head>
<body>
<%
    Integer hitsCount = 
      (Integer)application.getAttribute("hitCounter");
    if( hitsCount ==null || hitsCount == 0 ){
       hitsCount = 1;
    }else{
       hitsCount += 1;
    }
    application.setAttribute("hitCounter", hitsCount);
%>

<p>session ID：: <%= session.getId()%></p>
<hr/>
<p>取得服务器IP      ：<span style="background-color: red;"><%= request.getLocalAddr()%>:<%= request.getLocalPort()%></span></p>  
<hr/>
<p>取得客户端的IP    ：<span style="background-color: red;"><%= request.getRemoteAddr() %>:<%= request.getRemotePort()%></span></p>  
<p>取得客户端的主机名：<%= request.getRemoteHost()%></p>
<p>取得客户端的用户  ：<%= request.getRemoteUser()%></p>
<p>取得客户端的系统版本：<%= request.getHeader("User-Agent") %></p>

<hr/>
<p>页面访问量为: <%= hitsCount%></p>


</body>
</html>