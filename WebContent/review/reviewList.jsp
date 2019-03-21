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
	<link href="${conPath }/css/reviewList.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="content">
		<div id="reviewList_content">
			<div class="row_group" id="reviewList_caption">
				<a href="${conPath }/listReview.do">
					<span>[</span>&nbsp;
					<strong>REVIEW</strong>&nbsp;
					<span>]</span>
				</a>
			</div>
			<div class="row_group" id="reviewList_search">
				<form action="${conPath }/listReview.do?searchrTitle=${param.searchrTitle }" name="frm" method="get">
					<input type="text" id="searchrTitle" name="searchrTitle" placeholder="제목" autofocus="autofocus"
					value=${param.searchrTitle }>
					<input type="submit" value="검색">
				</form>
			</div>
			<form action="${conPath }/contentReview.do" name="frm" method="post" >
				<input type="hidden" name="pageNum" value="${pageNum }">
				<div class="row_group" id="reviewList_table">
					<table class="reviewInfo_table">
						<tr>
							<td id="no" class="subject">NO.</td>
							<td id="title" class="subject">TITLE</td>
							<td id="name" class="subject">NAME</td>
							<td id="date" class="subject">DATE</td>
							<td id="hits" class="subject">HITS</td>
							<td id="like" class="subject">LIKE</td>
						</tr>
						<c:forEach var="dto" items="${reviewList }">
							<tr id="info">
								<td id="info_no" class="review_info"><span>${dto.rNum }</span></td>
								<td id="info_title" class="review_info">
									<span>
										<a href="${conPath }/contentReview.do?rNum=${dto.rNum}&pageNum=${pageNum}">${dto.rTitle }</a>&nbsp;<c:if test="${dto.commentCnt!=0 }">[${dto.commentCnt }]</c:if>
										<c:if test="${not empty dto.rFileName_1 or not empty dto.rFileName_2
										or not empty dto.rFileName_3 or not empty dto.rFileName_4 or not empty dto.rFileName_5}">
											<img src="${conPath }/img/file.gif">
										</c:if>
										<c:if test="${dto.rDelete==0 }"><b>[DELETED]</b></c:if>
									</span>
								</td>
								<td id="info_name" class="review_info"><span>${dto.mName }</span></td>
								<td id="info_date" class="review_info"><span>${dto.rDate }</span></td>
								<td id="info_hits" class="review_info"><span>${dto.rHit }</span></td>
								<td id="info_like" class="review_info"><span>${dto.likeCnt }</span></td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</form>
			<c:if test="${not empty member and member.mGrade==1}">
				<div class="row_group" id="write_review_btn">
					<input type="button" value="글쓰기" onclick="location.href='${conPath}/writeReviewView.do?pageNum=${pageNum }'">
				</div>
			</c:if>
			<div class="paging">
				<c:if test="${pageCnt > BLOCKSIZE}">
					<a href="${conPath }/listReview.do?pageNum=1&searchrTitle=${param.searchrTitle}">[처음]</a>
				</c:if>
				<c:if test="${startPage > BLOCKSIZE }">
					<a href="${conPath }/listReview.do?pageNum=${startPage-1}&searchrTitle=${param.searchrTitle}">[이전]</a>
				</c:if>
				&nbsp; &nbsp; &nbsp;
				<c:forEach var="i" begin="${startPage }" end="${endPage }">
					<c:if test="${i == pageNum }">
						<b>&nbsp;${i }&nbsp;</b>
					</c:if>
					<c:if test="${i != pageNum }">
						<a href="${conPath }/listReview.do?pageNum=${i}&searchrTitle=${param.searchrTitle}">&nbsp;${i }&nbsp;</a>
					</c:if>
				</c:forEach>
				&nbsp; &nbsp; &nbsp;
				<c:if test="${endPage < pageCnt }">
					<a href="${conPath }/listReview.do?pageNum=${endPage+1}&searchrTitle=${param.searchrTitle}">[다음]</a>
				</c:if>
				<c:if test="${pageCnt > BLOCKSIZE }">
					<a href="${conPath }/listReview.do?pageNum=${pageCnt}&searchrTitle=${param.searchrTitle}">[끝]</a>
				</c:if>
			</div>
		</div>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>