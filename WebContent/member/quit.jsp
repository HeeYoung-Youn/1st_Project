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
	<link href="${conPath }/css/quitMember.css" rel="stylesheet">
	<script>
		function deleteInfoChk(){
			var booleanAgree = 0;
			if(frm.quitAgree.checked){
				booleanAgree ++;
			}
			if(!booleanAgree){
				alert('탈퇴 안내를 확인하고 동의해 주세요.');
				return false;
			}
		}
	</script>
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="content">
		<div id="quit_content">
			<form action="${conPath }/quitMember.do" name="frm" method="get" onsubmit="return deleteInfoChk()">
				<input type="hidden" name="mId" value="${member.mId }">
				<div class="row_group">
					<div class="quit_row">
						<h2>탈퇴 안내</h2>
						<p class="">회원탈퇴를 신청하기 전에 안내 사항을 꼭 확인해주세요.</p>
					</div>
					<div class="quit_row">
						<h3>사용하고 계신 아이디(${member.mId })는 탈퇴할 경우 재사용 및 복구가 불가능합니다.</h3>
						<p class=""><b>탈퇴한 아이디는 본인과 타인 모두 재사용 및 복구가 불가</b>하오니 신중하게 선택하시기 바랍니다.</p>
					</div>
					<div class="quit_row">
						<h3>탈퇴 후에도 게시판형 서비스에 등록한 게시물은 그대로 남아 있습니다.</h3>
						<p class="">
							REVIEW, QnA 등에 올린 게시글 및 댓글은 탈퇴 시 자동 삭제되지 않고 그대로 남아 있습니다.<br>
							삭제를 원하는 게시글이 있다면 <b>반드시 탈퇴 전 삭제하시기 바랍니다.</b><br>
							탈퇴 후에는 회원정보가 삭제되어 본인 여부를 확인할 수 있는 방법이 없어, 게시글을 임의로 삭제해드릴 수 없습니다.
						</p>
					</div>
					<div class="quit_row">
						<input type="checkbox" id="quitAgree" name="quitAgree" value="agree">
						<label for="quitAgree"><span></span>안내 사항을 모두 확인하였으며, 이에 동의합니다.</label>
					</div>
				</div>
				<div class="btn_area">
					<input type="submit" value="회원 탈퇴">
				</div>
			</form>
		</div>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>