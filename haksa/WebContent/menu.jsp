<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
    
<div class="menuItem"><a href="/haksa/index.jsp">HOME</a></div>     
<div class="menuLogin">
	<c:if test="${ id!=null }">
		<div class="menuItem"><a href="/haksa/pro/list.jsp">교수목록</a></div> 
		<div class="menuItem"><a href="/haksa/pro/insert.jsp">교수등록</a></div> 
		<div class="menuItem"><a href="/haksa/stu/list.jsp">학생목록</a></div> 
		<div class="menuItem"><a href="/haksa/stu/insert.jsp">학생등록</a></div> 
		<div class="menuItem"><a href="/haksa/cou/list.jsp">강좌목록</a></div> 
		<div class="menuItem"><a href="/haksa/cou/insert.jsp">강좌등록</a></div>
		<span>안녕하세요 ${ name }님 !</span>
		<a href="/haksa/user/logout">LOGOUT</a>
	</c:if>
	<c:if test="${ id==null }">
		<div class="menuItem"><a href="/haksa/user/login.jsp">교수목록</a></div> 
		<div class="menuItem"><a href="/haksa/user/login.jsp">교수등록</a></div> 
		<div class="menuItem"><a href="/haksa/user/login.jsp">학생목록</a></div> 
		<div class="menuItem"><a href="/haksa/user/login.jsp">학생등록</a></div> 
		<div class="menuItem"><a href="/haksa/user/login.jsp">강좌목록</a></div> 
		<div class="menuItem"><a href="/haksa/user/login.jsp">강좌등록</a></div>
		<a href="/haksa/user/logout">LOGIN</a>
	</c:if>
</div>