<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="conPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="${conPath }/css/style.css" rel="stylesheet">
	<link href="${conPath }/css/login.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script>
		$(document).ready(function(){
			$('#aId').keyup(function(){
				var aId = $('input[name="aId"]').val();
				if(aId.length == 0){
					$('#aIdMsg').html("<b>ID를 입력해주세요</b>");
				}else{
					$('#aIdMsg').html("");
				}
			});
			
			$('#aPw').keyup(function(){
				var aPw = $('input[name="aPw"]').val();
				if(aPw.length == 0){
					$('#aPwMsg').html("<b>비밀번호를 입력해주세요</b>");
				}else{
					$('#aPwMsg').html("");
				}
			});
		});
	</script>
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="content">
		<div id="login_content">
			<div class="row_group" id="login_caption">
					<span>[</span>&nbsp;
					<strong>LOG IN</strong>&nbsp;
					<span>]</span>
			</div>
			<form action="${conPath }/adminLogin.do" name="frm" method="post" onsubmit="return loginInfoChk()">
				<div class="row_group">
					<div class="login_row">
						<input type="text" id="aId" name="aId" class="input" required="required"
						autofocus="autofocus" placeholder="아이디">
						<div class="error_next_box" id="aIdMsg"></div>
					</div>
					<div class="login_row">
						<input type="password" id="aPw" name="aPw" class="input" required="required"
						placeholder="비밀번호">
						<div class="error_next_box" id="aPwMsg"></div>
					</div>
				</div><!-- row_group -->
				<div class="btn_area">
					<input type="submit" value="로그인">
				</div>
			</form>
		</div>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>