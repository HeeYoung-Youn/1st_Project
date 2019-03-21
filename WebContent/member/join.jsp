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
	<link href="${conPath }/css/join.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script>
		var idCon = 0;
		var pwCon = 0;
		$(document).ready(function(){
			$('#mId').keyup(function(){
				var mId = $('input[name="mId"]').val();
				if(mId.length == 0){
					$('#mIdMsg').html("<b>ID는 반드시 입력해야합니다</b>");
					idCon = 0;
				}else if(mId.length > 29){
					$('#mIdMsg').html("<b>ID가 너무 깁니다</b>");
					idCon = 0;
				}else{
					$.ajax({
						url : '${conPath}/mIdConfirm.do',
						type : 'get', 
						dataType : 'html', 
						data : "mId=" + mId, 
						success : function(data){
							if(data.indexOf("사용가능한 ID입니다")==-1){
								$('#mIdMsg').html("<b>" + data + "</b>");
								idCon = 0;
							}else{
								$('#mIdMsg').html("<span>" + data + "</span>");
								idCon = 1;
							}
						} 
					});
				}
			});
			
			$('#mPw').keyup(function(){
				var mPw = $('input[name="mPw"]').val();
				if(mPw.length == 0){
					$('#mPwMsg').html("<b>비밀번호는 반드시 입력해야합니다</b>");
					pwCon = 0;
				}else{
					$('#mPwMsg').html("");
				}
			});
			
			$('input[name="mPwChk"]').keyup(function(){
				if($('input[name="mPw"]').val() == $('input[name="mPwChk"]').val()){
					$('#mPwChkMsg').html("<span>비밀번호가 일치합니다</span>");
					pwCon = 1;
				}else{
					$('#mPwChkMsg').html("<b>비밀번호가 일치하지 않습니다</b>");
					pwCon = 0;
				}
			});
			
			$('#mName').keyup(function(){
				var mName = $('input[name="mName"]').val();
				if(mName.length == 0){
					$('#mNameMsg').html("<b>이름은 반드시 입력해야합니다</b>");
				}else{
					$('#mNameMsg').html("");
				}
			});
		});
	</script>
	<script>
		function joinInfoChk(){
			/* if(frm.mId.value.length > 29){
				alert('ID가 너무 깁니다');
				frm.mId.focus();
				frm.mId.value = '';
				return false;
			} */
			
			//var mIdMsg = '${mIdMsg}';
			/* if(mIdMsg != "" ){
				alert('중복된 ID입니다');
				frm.mId.focus();
				frm.mId.value = '';
				return false;
			} */
			if(idCon == 0){
				alert('중복된 ID이거나 ID의 길이가 너무 깁니다');
				frm.mId.focus();
				frm.mId.value = '';
				return false;
			}
			if(pwCon == 0){
				alert('비밀번호가 일치하지 않습니다');
				frm.mPw.focus();
				frm.mPw.value = '';
				frm.mPwChk.value = '';
				return false;
			}
			
			/* if(frm.mPw.value != frm.mPwChk.value){
				alert('비밀번호가 일치하지 않습니다');
				frm.mPw.focus();
				frm.mPw.value = '';
				frm.mPwChk.value = '';
				return false;
			} */
		}
	</script>
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="content">
		<div id="join_content">
			<div class="row_group" id="join_caption">
					<span>[</span>&nbsp;
					<strong>JOIN</strong>&nbsp;
					<span>]</span>
			</div>
			<form action="${conPath }/join.do" name="frm" method="post" onsubmit="return joinInfoChk()">
				<div class="row_group">
					<div class="join_row">
						<h3 class="join_title">
							<label for="mId">아이디</label>
						</h3>
						<input type="text" id="mId" name="mId" class="input" autofocus="autofocus" required="required">
						<div class="error_next_box" id="mIdMsg"></div>
					</div>
					<div class="join_row">
						<h3 class="join_title">
							<label for="mPw">비밀번호</label>
						</h3>
						<input type="password" id="mPw" name="mPw" class="input" required="required">
						<div class="error_next_box" id="mPwMsg"></div>
					</div>
					<div class="join_row">
						<h3 class="join_title">
							<label for="mPwChk">비밀번호 재확인</label>
						</h3>
						<input type="password" id="mPwChk" name="mPwChk" class="input" required="required">
						<div class="error_next_box" id="mPwChkMsg"></div>
					</div>
					<div class="join_row">
						<h3 class="join_title">
							<label for="mName">이름</label>
						</h3>
						<input type="text" id="mName" name="mName" class="input" required="required">
						<div class="error_next_box" id="mNameMsg"></div>
					</div>
					<div class="join_row">
						<h3 class="join_title">
							<label for="mBirth">생년월일(선택)</label>
						</h3>
						<input type="date" id="mBirth" name="mBirth" class="input">
						<div class="error_next_box" id="mBirthMsg"></div>
					</div>
					<div class="join_row">
						<h3 class="join_title">
							<label for="mEmail">이메일(선택)</label>
						</h3>
						<input type="email" id="mEmail" name="mEmail" class="input">
						<div class="error_next_box" id="mEmailMsg"></div>
					</div>
				</div><!-- .row_group -->
				<div class="btn_area">
					<input type="submit" value="가입하기">
				</div>
			</form>
		</div><!-- #join_content -->
	</div><!-- #content -->
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>