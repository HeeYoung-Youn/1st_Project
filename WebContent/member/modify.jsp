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
	<link href="${conPath }/css/modifyMember.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script>
		var nowPwCon = 0;
		var pwCon    = 0;
		$(document).ready(function(){
			$('#nowPw').keyup(function(){
				var nowPw = $('input[name="nowPw"]').val();
				var mId   = $('input[name="mId"]').val();
				if(nowPw.length == 0){
					$('#nowPwMsg').html("<b>현재 비밀번호는 반드시 입력해야합니다</b>");
					nowPwCon = 0;
				}else{
					$.ajax({
						url : '${conPath}/mPwConfirm.do', 
						type : 'get', 
						dataType : 'html', 
						data : "mId=" + mId + "&nowPw=" + nowPw, 
						success : function(data){
							if(data.indexOf("등록된 비밀번호와 일치합니다")==-1){
								$('#nowPwMsg').html("<b>" + data + "</b>");
								nowPwCon = 0;
							}else{
								$('#nowPwMsg').html("<span>" + data + "</span>");
								nowPwCon = 1;
							}
						}
					});
				}
			});
			
			$('input[name="mPwChk"]').keyup(function(){
				if($('input[name="mPw"]').val().length == 0){
					$('#mPwChkMsg').html("");
					pwCon = 1;	
				}else if($('input[name="mPw"]').val() != $('input[name="mPwChk"]').val()){
					$('#mPwChkMsg').html("<b>변경할 비밀번호가 일치하지 않습니다</b>");
					pwCon = 0;
					return false;
				}else if($('input[name="mPw"]').val() == $('input[name="mPwChk"]').val()){
					$('#mPwChkMsg').html("<span>변경할 비밀번호가 일치합니다</span>");
					pwCon = 1;
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
		function modifyInfoChk(){
			if(nowPwCon == 0){
				alert('등록된 비밀번호와 일치하지 않습니다');
				frm.nowPw.focus();
				frm.nowPw.value = '';
				return false;
			}
			if(pwCon == 0){
				alert('변경할 비밀번호가 일치하지 않습니다');
				frm.mPw.focus();
				frm.mPw.value = '';
				frm.mPwChk.value = '';
				return false;
			}
		}
		
		function quitMemberChk(){
			if(nowPwCon == 0){
				alert('비밀번호 확인 후 회원 탈퇴가 가능합니다');
				frm.nowPw.focus();
				frm.nowPw.value = '';
				return false;
			}else{
				alert('회원탈퇴 페이지로 이동합니다');
				location.href="${conPath}/quitMemberView.do";
			}
		}
	</script>
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="content">
		<div id="modify_content">
			<div class="row_group" id="modify_caption">
					<span>[</span>&nbsp;
					<strong>MODIFY</strong>&nbsp;
					<span>]</span>
			</div>
			<form action="${conPath }/modifyMember.do" name="frm" method="post" onsubmit="return modifyInfoChk()">
				<input type="hidden" id="dbmPw" name="dbmPw" value="${member.mPw }">
				<div class="row_group">
					<div class="modify_row">
						<h3 class="modify_title">
							<label for="mId">아이디</label>
						</h3>
						<input type="text" id="mId" name="mId" class="input" required="required"
						value="${member.mId }" readonly="readonly">
						<div class="error_next_box" id="mIdMsg"></div>
					</div>
					<div class="modify_row">
						<h3 class="modify_title">
							<label for="nowPw">현재 비밀번호</label>
						</h3>
						<input type="password" id="nowPw" name="nowPw" class="input" required="required"
						autofocus="autofocus">
						<div class="error_next_box" id="nowPwMsg"></div>
					</div>
					<div class="modify_row">
						<h3 class="modify_title">
							<label for="mPw">새 비밀번호</label>
						</h3>
						<input type="password" id="mPw" name="mPw" class="input">
						<div class="error_next_box" id="mPwMsg"></div>
					</div>
					<div class="modify_row">
						<h3 class="modify_title">
							<label for="mPwChk">새 비밀번호 확인</label>
						</h3>
						<input type="password" id="mPwChk" name="mPwChk" class="input">
						<div class="error_next_box" id="mPwChkMsg"></div>
					</div>
					<div class="modify_row">
						<h3 class="modify_title">
							<label for="mName">이름</label>
						</h3>
						<input type="text" id="mName" name="mName" class="input" required="required"
						value="${member.mName }">
						<div class="error_next_box" id="mNameMsg"></div>
					</div>
					<div class="modify_row">
						<h3 class="modify_title">
							<label for="mBirth">생년월일(선택)</label>
						</h3>
						<input type="date" id="mBirth" name="mBirth" class="input" value="${member.mBirth }">
						<div class="error_next_box" id="mBirthMsg"></div>
					</div>
					<div class="modify_row">
						<h3 class="modify_title">
							<label for="mEmail">이메일(선택)</label>
						</h3>
						<input type="email" id="mEmail" name="mEmail" class="input" value="${member.mEmail }">
						<div class="error_next_box" id="mEmailMsg"></div>
					</div>
				</div>
				<div class="btn_area">
					<input type="submit" value="수정하기">
				</div>
				<div class="span_area">
					<span>PHONE_REV를 더 이상 이용하지 않는다면&nbsp;&nbsp;<span onclick="return quitMemberChk()">회원탈퇴 바로가기</span>▶</span>
				</div>
			</form>
		</div>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>