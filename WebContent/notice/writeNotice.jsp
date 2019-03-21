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
	<link href="${conPath }/css/noticeWrite.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="content">
		<div id="writeNotice_content">
			<div class="row_group" id="writeNotice_caption">
				<a href="${conPath }/listNotice.do">
					<span>[</span>&nbsp;
					<strong>NOTICE</strong>&nbsp;
					<span>]</span>
				</a>
			</div>
			<div class="row_group">
				<form action="${conPath }/writeNotice.do" name="frm" method="post">
					<table id="writeNotice_table_div">
						<tr>
							<td class="writeNotice_title"><span>ID</span></td>
							<td><input type="text" id="notice_id" name="aId" readonly="readonly"
							value="${admin.aId }"></td>
							<td class="writeNotice_title"><span>NAME</span></td>
							<td><input type="text" id="notice_name" name="aName" readonly="readonly"
							value="${admin.aName }"></td>
						</tr>
						<tr>
							<td class="writeNotice_title"><span>TITLE</span></td>
							<td colspan="3"><input type="text" id="notice_title" name="nTitle" required="required"></td>
						</tr>
						<tr>
							<td class="writeNotice_title"><span>CONTENT</span></td>
							<td colspan="3">
								<textarea id="notice_content" name="nContent"></textarea>
							</td>
						</tr>
						<tr>
							<td colspan="4" id="btn_area">
								<input type="button" value="목록" onclick="location.href='${conPath}/listNotice.do?pageNum=${param.pageNum }'">
								<input type="submit" value="확인">
							</td>
						</tr>
					</table>
				</form>
			</div><!-- .row_group -->
		</div><!-- #writeNotice_content -->
	</div><!-- #content -->
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>