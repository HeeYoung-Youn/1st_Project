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
	<link href="${conPath }/css/qnaReply.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
		<div id="content">
			<div id="replyQnA_content">
				<div class="row_group" id="replyQnA_caption">
					<a href="${conPath }/listQnA.do">
						<span>[</span>&nbsp;
						<strong>Q & A</strong>&nbsp;
						<span>]</span>
					</a>
				</div>
				<div class="row_group">
					<form action="${conPath }/replyQnA.do" name="frm" method="post">
						<input type="hidden" name="pageNum" value="${param.pageNum }">
						<input type="hidden" name="qGroup" value="${reply_view.qGroup }">
						<input type="hidden" name="qStep" value="${reply_view.qStep }">
						<input type="hidden" name="qIndent" value="${reply_view.qIndent }">
						<table id="replyQnA_table_div">
							<tr>
								<td class="replyQnA_title"><span>ID</span></td>
								<td><input type="text" id="qna_id" name="mId" readonly="readonly"
								value="${member.mId }"></td>
								<td class="replyQnA_title"><span>NAME</span></td>
								<td><input type="text" id="qna_name" name="mName" readonly="readonly"
								value="${member.mName }"></td>
							</tr>
							<tr>
								<td class="replyQnA_title"><span>E-MAIL</span></td>
								<td colspan="3"><input type="text" id="qna_email"
								readonly="readonly" value="${member.mEmail }"></td>
							</tr>
							<tr>
								<td class="replyQnA_title"><span>TITLE</span></td>
								<td colspan="3"><input type="text" id="qna_title" name="qTitle"
								value="[${reply_view.qTitle }]의 답변글" required="required"></td>
							</tr>
							<tr>
								<td class="replyQnA_title"><span>CONTENT</span></td>
								<td colspan="3">
									<textarea id="qna_content" name="qContent"></textarea>
								</td>
							</tr>
							<tr>
								<td colspan="4" id="btn_area">
									<input type="button" value="목록" onclick="location.href='${conPath}/listQnA.do?pageNum=${param.pageNum }'">
									<input type="submit" value="확인">
								</td>
							</tr>
						</table>
					</form>
				</div><!-- .row_group -->
			</div><!-- #replyQnA_content -->
		</div><!-- #content -->
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>