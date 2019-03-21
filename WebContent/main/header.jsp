<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="conPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>PHONE_REV</title>
	<link href="${conPath }/css/header.css" rel="stylesheet">
</head>
<body>
	<div id="header">
		<c:if test="${empty member and empty admin}"><%-- 로그인 전 --%>
			<div id="gnb">
	            <ul>
	                <li><a href="${conPath }/loginView.do">LOGIN</a></li>
	                <li><a href="${conPath }/joinView.do">JOIN US</a></li>
	            </ul>
	        </div>
		</c:if>
		
		<c:if test="${not empty member and empty admin}"><%-- 사용자 로그인 후 --%>
			<div id="gnb">
	            <ul>
	            	<li><a href="${conPath }/myContent.do?mId=${member.mId}">${member.mName }님</a></li>
	            	<li>
	            		<c:if test="${member.mGrade==1 }"><span>일반회원</span></c:if>
	            		<c:if test="${member.mGrade==0 }"><span>불량회원</span></c:if>
            		</li>
            		<li><a href="${conPath }/modifyMemberView.do">MODIFY</a></li>
	                <li><a href="${conPath }/logout.do">LOGOUT</a></li>
	            </ul>
	        </div>
		</c:if>
		
		<c:if test="${empty member and not empty admin}"><%-- 관리자 로그인 후 --%>
			<div id="gnb">
	            <ul>
	            	<li><span>${admin.aName }님</span></li>
	                <li><a href="${conPath }/logout.do">LOGOUT</a></li>
	                <li><a href="${conPath }/listMember.do">MEMBER LIST</a></li>
	            </ul>
	        </div>
		</c:if>
		
		<div id="logo">
            <p><a href="${conPath }/main.do">PHONE_REV</a></p>
        </div>
        <div id="nav">
            <ul>
                <li><a href="${conPath }/listReview.do">REVIEW</a></li>
                <li><a href="${conPath }/listQnA.do">Q & A</a></li>
                <li><a href="${conPath }/listNotice.do">NOTICE</a></li>
            </ul>
        </div>
    </div>
</body>
</html>