<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="conPath" value="${pageContext.request.contextPath }"/>
<c:if test="${not empty SuccessMsg }">
	<script>
		alert('${SuccessMsg}');
	</script>
</c:if>
<c:if test="${not empty FailMsg }">
	<script>
		alert('${FailMsg}');
		history.back();
	</script>
</c:if>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>PHONE_REV</title>
	<link href="${conPath }/css/style.css" rel="stylesheet">
	<link href="${conPath }/css/contentQnA.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="content">
		<div id="qnaContent">
			<div class="row_group" id="qnaContent_caption">
				<a href="${conPath }/listQnA.do">
					<span>[</span>&nbsp;
					<strong>Q & A</strong>&nbsp;
					<span>]</span>
				</a>
			</div>
			<div class="row_group" id="qnaContent_qnaInfo">
				<div id="qnaContent_title">
					<h4>${qnaDto.qTitle }</h4>
				</div>
				<div id="qnaContent_others">
					<table>
						<tr>
							<td class="first_td">NAME : ${qnaDto.mName }</td>
							<td class="second_td">HITS : ${qnaDto.qHit }</td>
						</tr>
						<tr>
							<td class="first_td">DATE : ${qnaDto.qDate }</td>
							<td colspan="2">IP : ${qnaDto.qIp }</td>
						</tr>
					</table>
				</div>
			</div>
			<div class="row_group" id="qnaContent_content">
				<pre>${qnaDto.qContent }</pre>
			</div>
			<div id="btn_area">
				<c:if test="${not empty admin and qnaDto.qDelete==0}">
					<button onclick="location='${conPath}/recoverQnA.do?qNum=${param.qNum }&pageNum=${param.pageNum }'">복구</button>
				</c:if>
				<c:if test="${qnaDto.mId eq member.mId }">
					<button onclick="location='${conPath}/modifyQnAView.do?qNum=${param.qNum }&pageNum=${param.pageNum }'">수정</button>
				</c:if>
				<c:if test="${qnaDto.mId eq member.mId or not empty admin}">
					<button onclick="location='${conPath}/deleteQnA.do?qNum=${param.qNum }&pageNum=${param.pageNum }'">삭제</button>
				</c:if>
				<c:if test="${not empty member }">
					<button onclick="location='${conPath}/replyQnAView.do?qNum=${param.qNum }&pageNum=${param.pageNum }'">답변</button>
				</c:if>
				<button onclick="location='${conPath}/listQnA.do'">목록</button>
			</div>
		</div><!-- #qnaContent -->
	</div><!-- #content -->
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>