<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="conPath" value="${pageContext.request.contextPath }"/>
<c:if test="${not empty SuccessMsg }">
	<script>
		alert('${SuccessMsg }');
	</script>
</c:if>
<c:if test="${not empty FailMsg }">
	<script>
		alert('${FailMsg }');
		history.back();
	</script>
</c:if>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>PHONE_REV</title>
	<link href="${conPath }/css/style.css" rel="stylesheet">
	<link href="${conPath }/css/qnaList.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="content">
		<div id="qnaList_content">
			<div class="row_group" id="qnaList_caption">
				<a href="${conPath }/listQnA.do">
					<span>[</span>&nbsp;
					<strong>Q & A</strong>&nbsp;
					<span>]</span>
				</a>
			</div>
			<div class="row_group" id="qnaList_search">
				<form action="${conPath }/listQnA.do?searchrTitle=${param.searchqTitle }" name="frm" method="get">
					<input type="text" id="searchqTitle" name="searchqTitle" placeholder="제목" autofocus="autofocus"
					value=${param.searchqTitle }>
					<input type="submit" value="검색">
				</form>
			</div>
			<form action="${conPath }/contentQnA.do" name="frm" method="post" >
				<input type="hidden" name="pageNum" value="${pageNum }">
				<div class="row_group" id="qnaList_table">
					<table class="qnaInfo_table">
						<tr>
							<td id="no" class="subject">NO.</td>
							<td id="title" class="subject">TITLE</td>
							<td id="name" class="subject">NAME</td>
							<td id="date" class="subject">DATE</td>
							<td id="hits" class="subject">HITS</td>
						</tr>
						<c:forEach var="dto" items="${qnaList }">
							<tr id="info">
								<td id="info_no" class="qna_info"><span>${dto.qNum }</span></td>
								<td id="info_title" class="qna_info">
									<c:forEach var="i" begin="1" end="${dto.qIndent }">
										<div class="qnaList_indent">
											<c:if test="${i==dto.qIndent }">
												<div class="qnaList_arrow">
													<img src="${conPath }/img/comment.png">
												</div>
											</c:if>
											<c:if test="${i!=dto.qIndent }">
												<div class="qnaList_space">
													&nbsp; &nbsp;
												</div>
											</c:if>
										</div>
									</c:forEach>
									<div class="qTitle">
										<a href="${conPath }/contentQnA.do?qNum=${dto.qNum}&pageNum=${pageNum}">${dto.qTitle }</a>
										<c:if test="${dto.qDelete==0 }"><b>[DELETED]</b></c:if>
									</div>
								</td>
								<td id="info_name" class="qna_info"><span>${dto.mName }</span></td>
								<td id="info_date" class="qna_info"><span>${dto.qDate }</span></td>
								<td id="info_hits" class="qna_info"><span>${dto.qHit }</span></td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</form>
			<c:if test="${not empty member and member.mGrade==1}">
				<div class="row_group" id="write_qna_btn">
					<input type="button" value="글쓰기" onclick="location.href='${conPath}/writeQnAView.do?pageNum=${pageNum }'">
				</div>
			</c:if>
			<div class="paging">
				<c:if test="${pageCnt > BLOCKSIZE}">
					<a href="${conPath }/listQnA.do?pageNum=1&searchqTitle=${param.searchqTitle}">[처음]</a>
				</c:if>
				<c:if test="${startPage > BLOCKSIZE }">
					<a href="${conPath }/listQnA.do?pageNum=${startPage-1}&searchqTitle=${param.searchqTitle}">[이전]</a>
				</c:if>
				&nbsp; &nbsp; &nbsp;
				<c:forEach var="i" begin="${startPage }" end="${endPage }">
					<c:if test="${i == pageNum }">
						<b>&nbsp;${i }&nbsp;</b>
					</c:if>
					<c:if test="${i != pageNum }">
						<a href="${conPath }/listQnA.do?pageNum=${i}&searchqTitle=${param.searchqTitle}">&nbsp;${i }&nbsp;</a>
					</c:if>
				</c:forEach>
				&nbsp; &nbsp; &nbsp;
				<c:if test="${endPage < pageCnt }">
					<a href="${conPath }/listQnA.do?pageNum=${endPage+1}&searchqTitle=${param.searchqTitle}">[다음]</a>
				</c:if>
				<c:if test="${pageCnt > BLOCKSIZE }">
					<a href="${conPath }/listQnA.do?pageNum=${pageCnt}&searchqTitle=${param.searchqTitle}">[끝]</a>
				</c:if>
			</div>
		</div>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>