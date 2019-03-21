<%@page import="java.sql.Date"%>
<%@page import="com.phone_rev.dto.MemberDto"%>
<%@page import="com.phone_rev.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="conPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>PHONE_REV</title>
	<link href="${conPath }/css/style.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="content">
	<%
		for(int i=150; i<300; i++){
			MemberDao dao = MemberDao.getInstance();
			MemberDto dto = new MemberDto();
			dto.setmId("홍길동" + i);
			dto.setmGrade(1);
			dto.setmPw(String.valueOf(i));
			dto.setmName("홍길동" + i);
			dto.setmEmail(i + "@" + "naver.com");
			dto.setmBirth(Date.valueOf("1994-09-01"));
			dto.setmJoin(1);
			dao.joinMember(dto);
		}
		response.sendRedirect("../main.do");
	%>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>