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
	<link href="${conPath }/css/qnaModify.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
		<div id="content">
			<div id="modifyQnA_content">
				<div class="row_group" id="modifyQnA_caption">
					<a href="${conPath }/listQnA.do">
						<span>[</span>&nbsp;
						<strong>Q & A</strong>&nbsp;
						<span>]</span>
					</a>
				</div>
				<div class="row_group">
					<form action="${conPath }/modifyQnA.do" name="frm" method="post">
						<input type="hidden" name="pageNum" value="${param.pageNum }">
						<input type="hidden" name="qNum" value="${param.qNum }">
						<input type="hidden" name="mId" value="${member.mId }">
						<input type="hidden" name="mName" value="${member.mName }">
						<table id="modifyQnA_table_div">
							<tr>
								<td class="modifyQnA_title"><span>ID</span></td>
								<td><input type="text" id="qna_id" readonly="readonly"
								value="${member.mId }"></td>
								<td class="modifyQnA_title"><span>NAME</span></td>
								<td><input type="text" id="qna_name" readonly="readonly"
								value="${member.mName }"></td>
							</tr>
							<tr>
								<td class="modifyQnA_title"><span>E-MAIL</span></td>
								<td colspan="3"><input type="text" id="qna_email"
								readonly="readonly" value="${member.mEmail }"></td>
							</tr>
							<tr>
								<td class="modifyQnA_title"><span>TITLE</span></td>
								<td colspan="3"><input type="text" id="qna_title" name="qTitle"
									value="${modify_view.qTitle }" required="required"></td>
							</tr>
							<tr>
								<td class="modifyQnA_title"><span>CONTENT</span></td>
								<td colspan="3">
									<textarea id="qna_content" name="qContent">${modify_view.qContent }</textarea>
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
			</div><!-- #modifyQnA_content -->
		</div><!-- #content -->
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>