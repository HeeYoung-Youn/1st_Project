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
	<link href="${conPath }/css/noticeList.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="content">
		<div id="noticeList_content">
			<div class="row_group" id="noticeList_caption">
				<a href="${conPath }/listNotice.do">
					<span>[</span>&nbsp;
					<strong>NOTICE</strong>&nbsp;
					<span>]</span>
				</a>
			</div>
			<div class="row_group" id="noticeList_search">
				<form action="${conPath }/listNotice.do?searchnTitle=${param.searchnTitle }" name="frm" method="get">
					<input type="text" id="searchnTitle" name="searchnTitle" placeholder="제목" autofocus="autofocus"
					value=${param.searchnTitle }>
					<input type="submit" value="검색">
				</form>
			</div>
			<form action="${conPath }/contentNotice.do" name="frm" method="post" >
				<input type="hidden" name="pageNum" value="${pageNum }">
				<div class="row_group" id="noticeList_table">
					<table class="noticeInfo_table">
						<tr>
							<td id="no" class="subject">NO.</td>
							<td id="title" class="subject">TITLE</td>
							<td id="name" class="subject">NAME</td>
							<td id="date" class="subject">DATE</td>
							<td id="hits" class="subject">HITS</td>
						</tr>
						<c:forEach var="dto" items="${noticeList }">
							<tr id="info">
								<td id="info_no" class="notice_info"><span>${dto.nNum }</span></td>
								<td id="info_title" class="notice_info">
									<div class="nTitle">
										<a href="${conPath }/contentNotice.do?nNum=${dto.nNum}&pageNum=${pageNum}">${dto.nTitle }</a>&nbsp;<c:if test="${dto.commentCnt!=0 }">[${dto.commentCnt }]</c:if>
										<c:if test="${dto.nDelete==0 }"><b>[DELETED]</b></c:if>
									</div>
								</td>
								<td id="info_name" class="notice_info"><span>${dto.aName }</span></td>
								<td id="info_date" class="notice_info"><span>${dto.nDate }</span></td>
								<td id="info_hits" class="notice_info"><span>${dto.nHit }</span></td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</form>
			<c:if test="${not empty admin }">
				<div class="row_group" id="write_notice_btn">
					<input type="button" value="글쓰기" onclick="location.href='${conPath}/writeNoticeView.do?pageNum=${pageNum }'">
				</div>
			</c:if>
			<div class="paging">
				<c:if test="${pageCnt > BLOCKSIZE}">
					<a href="${conPath }/listNotice.do?pageNum=1&searchnTitle=${param.searchnTitle}">[처음]</a>
				</c:if>
				<c:if test="${startPage > BLOCKSIZE }">
					<a href="${conPath }/listNotice.do?pageNum=${startPage-1}&searchnTitle=${param.searchnTitle}">[이전]</a>
				</c:if>
				&nbsp; &nbsp; &nbsp;
				<c:forEach var="i" begin="${startPage }" end="${endPage }">
					<c:if test="${i == pageNum }">
						<b>&nbsp;${i }&nbsp;</b>
					</c:if>
					<c:if test="${i != pageNum }">
						<a href="${conPath }/listNotice.do?pageNum=${i}&searchnTitle=${param.searchnTitle}">&nbsp;${i }&nbsp;</a>
					</c:if>
				</c:forEach>
				&nbsp; &nbsp; &nbsp;
				<c:if test="${endPage < pageCnt }">
					<a href="${conPath }/listNotice.do?pageNum=${endPage+1}&searchnTitle=${param.searchnTitle}">[다음]</a>
				</c:if>
				<c:if test="${pageCnt > BLOCKSIZE }">
					<a href="${conPath }/listNotice.do?pageNum=${pageCnt}&searchnTitle=${param.searchnTitle}">[끝]</a>
				</c:if>
			</div>
		</div>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>