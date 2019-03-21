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
	<link href="${conPath }/css/myContent.css" rel="stylesheet">
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
				
				<form action="${conPath }/contentReview.do" name="frm" method="post" >
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
											<a href="${conPath }/contentReview.do?rNum=${dto.rNum}&pageNum=1">${dto.rTitle }</a>&nbsp;<c:if test="${dto.commentCnt!=0 }">[${dto.commentCnt }]</c:if>
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
				<div class="paging">
					<c:if test="${rpageCnt > rBLOCKSIZE}">
						<a href="${conPath }/myContent.do?rpageNum=1&mId=${member.mId}">[처음]</a>
					</c:if>
					<c:if test="${rstartPage > rBLOCKSIZE }">
						<a href="${conPath }/myContent.do?rpageNum=${rstartPage-1}&mId=${member.mId}">[이전]</a>
					</c:if>
					&nbsp; &nbsp; &nbsp;
					<c:forEach var="i" begin="${rstartPage }" end="${rendPage }">
						<c:if test="${i == rpageNum }">
							<b>&nbsp;${i }&nbsp;</b>
						</c:if>
						<c:if test="${i != rpageNum }">
							<a href="${conPath }/myContent.do?rpageNum=${i}&mId=${member.mId}">&nbsp;${i }&nbsp;</a>
						</c:if>
					</c:forEach>
					&nbsp; &nbsp; &nbsp;
					<c:if test="${rendPage < rpageCnt }">
						<a href="${conPath }/myContent.do?rpageNum=${rendPage+1}&mId=${member.mId}">[다음]</a>
					</c:if>
					<c:if test="${rpageCnt > rBLOCKSIZE }">
						<a href="${conPath }/myContent.do?rpageNum=${rpageCnt}&mId=${member.mId}">[끝]</a>
					</c:if>
				</div>
			</div>
<!----------------------------------------------------------------------------------------------------------------------------------------------->
			<div id="qnaList_content">
				<div class="row_group" id="qnaList_caption">
					<a href="${conPath }/listQnA.do">
						<span>[</span>&nbsp;
						<strong>Q & A</strong>&nbsp;
						<span>]</span>
					</a>
				</div>
				
				<form action="${conPath }/contentQnA.do" name="frm" method="post" >
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
											<a href="${conPath }/contentQnA.do?qNum=${dto.qNum}&pageNum=1">${dto.qTitle }</a>
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
				<div class="paging">
					<c:if test="${qpageCnt > qBLOCKSIZE}">
						<a href="${qconPath }/myContent.do?qpageNum=1&mId=${member.mId}">[처음]</a>
					</c:if>
					<c:if test="${qstartPage > qBLOCKSIZE }">
						<a href="${conPath }/myContent.do?qpageNum=${qstartPage-1}&mId=${member.mId}">[이전]</a>
					</c:if>
					&nbsp; &nbsp; &nbsp;
					<c:forEach var="i" begin="${qstartPage }" end="${qendPage }">
						<c:if test="${i == qpageNum }">
							<b>&nbsp;${i }&nbsp;</b>
						</c:if>
						<c:if test="${i != qpageNum }">
							<a href="${conPath }/myContent.do?qpageNum=${i}&mId=${member.mId}">&nbsp;${i }&nbsp;</a>
						</c:if>
					</c:forEach>
					&nbsp; &nbsp; &nbsp;
					<c:if test="${qendPage < qpageCnt }">
						<a href="${conPath }/myContent.do?qpageNum=${qendPage+1}&mId=${member.mId}">[다음]</a>
					</c:if>
					<c:if test="${qpageCnt > qBLOCKSIZE }">
						<a href="${conPath }/myContent.do?qpageNum=${qpageCnt}&mId=${member.mId}">[끝]</a>
					</c:if>
				</div>
			</div>
		</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>