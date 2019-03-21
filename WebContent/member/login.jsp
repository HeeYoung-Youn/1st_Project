<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="conPath" value="${pageContext.request.contextPath }"/>
<c:if test="${not empty joinSuccessMsg }">
	<script>
		alert('${joinSuccessMsg} ');
	</script>
</c:if>
<c:if test="${not empty joinFailMsg }">
	<script>
		alert('${joinFailMsg} ');
		history.back();
	</script>
</c:if>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>PHONE_REV</title>
	<link href="${conPath }/css/style.css" rel="stylesheet">
	<link href="${conPath }/css/login.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script>
		$(document).ready(function(){
			$('#mId').keyup(function(){
				var mId = $('input[name="mId"]').val();
				if(mId.length == 0){
					$('#mIdMsg').html("<b>ID를 입력해주세요</b>");
				}else{
					$('#mIdMsg').html("");
				}
			});
			
			$('#mPw').keyup(function(){
				var mPw = $('input[name="mPw"]').val();
				if(mPw.length == 0){
					$('#mPwMsg').html("<b>비밀번호를 입력해주세요</b>");
				}else{
					$('#mPwMsg').html("");
				}
			});
		});
	</script>
	<script>
		function joinMemberChk(){
			location.href="${conPath}/joinView.do";
		}
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
			<form action="${conPath }/login.do" name="frm" method="post" onsubmit="return loginInfoChk()">
				<div class="row_group">
					<div class="login_row">
						<input type="text" id="mId" name="mId" class="input" required="required"
						autofocus="autofocus" placeholder="아이디">
						<div class="error_next_box" id="mIdMsg"></div>
					</div>
					<div class="login_row">
						<input type="password" id="mPw" name="mPw" class="input" required="required"
						placeholder="비밀번호">
						<div class="error_next_box" id="mPwMsg"></div>
					</div>
				</div><!-- row_group -->
				<div class="btn_area">
					<input type="submit" value="로그인">
				</div>
				<div class="span_area">
					<span>아직 PHONE_REV의 회원이 아니라면&nbsp;&nbsp;<span onclick="return joinMemberChk()">회원가입 바로가기</span>▶</span>
				</div>
			</form>
		</div>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>