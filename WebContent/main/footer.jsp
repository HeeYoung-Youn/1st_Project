<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="conPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>PHONE_REV</title>
	<link href="${conPath }/css/footer.css" rel="stylesheet">
</head>
<body>
	<div id="footer">
        <div id="footer_in">
        	<div id="footer_info">
        		<p>COMPANY INFORMATION</p><br>
	            <p>(주) PHONE_REV</p>
	            <p>대표 윤희영 | 서울특별시 종로구 삼일대로 17길 51 스타골드빌딩 501</p>
	            <p>사업자등록번호 144-30-00364</p>
	            <c:if test="${empty admin and empty member}">
	            	<p id="admin_login"><a href="${conPath }/adminLoginView.do">ADMIN LOGIN</a></p>
	            </c:if>
        	</div>
        </div>
        <div id="bottom">
            <p>2019 ⓒ PHONE_REV.All Rights Reserved.</p>
        </div>
    </div>
</body>
</html>