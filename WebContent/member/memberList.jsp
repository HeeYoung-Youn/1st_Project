<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="conPath" value="${pageContext.request.contextPath }"/>
<c:if test="${not empty downGradeMsg }">
	<script>
		alert('${downGradeMsg}');
	</script>
</c:if>
<c:if test="${not empty upGradeMsg }">
	<script>
		alert('${upGradeMsg}');
	</script>
</c:if>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>PHONE_REV</title>
	<link href="${conPath }/css/style.css" rel="stylesheet">
	<link href="${conPath }/css/memberList.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script>
		$(document).ready(function(){
			$('#upgrade_member').click(function(){
				var locationString = '${conPath}/upgradeMember.do?';
				$('input[name="mId"]').each(function(idx,item){
					if(item.checked){
						locationString += 'mId='+$(this).val() +'&'; 
					}
				});
				location.href = locationString;
			});
		});
	</script>
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="content">
		<div id="memberList_content">
			<div class="row_group" id="memberList_caption">
				<a href="${conPath }/listMember.do">
					<span>[</span>&nbsp;
					<strong>MEMBER LIST</strong>&nbsp;
					<span>]</span>
				</a>
			</div>
			<div class="row_group" id="memberList_search">
				<form action="${conPath }/listMember.do" name="frm" method="post">
					<input type="text" id="searchmId" name="searchmId" placeholder="ID" autofocus="autofocus"
					value=${param.searchmId }>
					<input type="submit" value="검색">
				</form>
			</div>
			<form action="${conPath }/downgradeMember.do" name="frm" method="post" >
				<div class="row_group" id="memberList_table">
					<table class="memberInfo_table">
						<tr>
							<td id="id" class="subject">ID</td>
							<td id="name" class="subject">NAME</td>
							<td id="birth" class="subject">BIRTH</td>
							<td id="mail" class="subject">MAIL</td>
							<td id="grade" class="subject">GRADE</td>
							<td id="quit" class="subject">QUIT</td>
							<td id="downgrade" class="subject">DOWNGRADE</td>
						</tr>
						<c:forEach var="dto" items="${listMember }">
							<tr id="info">
								<td id="info_id" class="member_info"><span>${dto.mId }</span></td>
								<td id="info_name" class="member_info"><span>${dto.mName }</span></td>
								<td id="info_birth" class="member_info">
									<span>
										<c:if test="${not empty dto.mBirth }">
											${dto.mBirth }
										</c:if>
										<c:if test="${empty dto.mBirth }">
											X
										</c:if>
									</span>
								</td>
								<td id="info_mail" class="member_info">
									<span>
										<c:if test="${not empty dto.mEmail }">
											${dto.mEmail }
										</c:if>
										<c:if test="${empty dto.mEmail }">
											X
										</c:if>
									</span>
								</td>
								<td id="info_grade" class="member_info"><span>${dto.mGrade==0 ? "불량회원" : "일반회원" }</span></td>
								<td class="member_info"><span>${dto.mJoin==0 ? "탈퇴" : "가입" }</span></td>
								<td>
									<input type="checkbox" name="mId" id="down_grade_${dto.mId }" value="${dto.mId}">
									<label for="down_grade_${dto.mId }"></label>
								</td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<div class="row_group" id="memberList_downGrade">
					<input type="submit" value="불량회원 등록">
					<input type="button" id="upgrade_member" value="일반회원 등록">&nbsp;
				</div>
			</form>
			<div class="paging">
				<c:if test="${pageCnt > BLOCKSIZE }">
					<a href="${conPath }/listMember.do?pageNum=1&searchmId=${param.searchmId}">[처음]</a>
				</c:if>
				<c:if test="${startPage > BLOCKSIZE }">
					<a href="${conPath }/listMember.do?pageNum=${startPage-1}&searchmId=${param.searchmId}">[이전]</a>
				</c:if>
				&nbsp; &nbsp; &nbsp;
				<c:forEach var="i" begin="${startPage }" end="${endPage }">
					<c:if test="${i == pageNum }">
						<b>&nbsp;${i }&nbsp;</b>
					</c:if>
					<c:if test="${i != pageNum }">
						<a href="${conPath }/listMember.do?pageNum=${i}&searchmId=${param.searchmId}">&nbsp;${i }&nbsp;</a>
					</c:if>
				</c:forEach>
				&nbsp; &nbsp; &nbsp;
				<c:if test="${endPage < pageCnt }">
					<a href="${conPath }/listMember.do?pageNum=${endPage+1}&searchmId=${param.searchmId}">[다음]</a>
				</c:if>
				<c:if test="${pageCnt > BLOCKSIZE }">
					<a href="${conPath }/listMember.do?pageNum=${pageCnt}&searchmId=${param.searchmId}">[끝]</a>
				</c:if>
			</div>
		</div>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>