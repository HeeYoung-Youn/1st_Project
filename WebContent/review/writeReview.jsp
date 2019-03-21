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
	<link href="${conPath }/css/reviewWrite.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script>
		$(document).ready(function(){
			var file1 = $('.review_file');
			file1.on('change', function(){
				if(window.FileReader){
					var filename = $(this)[0].files[0].name;
				}else {
					var filename = $(this).val().split('/').pop().split('\\').pop(); // 파일명만 추출	
				}
				$(this).siblings('.file_name').val(filename);
			});
		});
	</script>
	<script type="text/javascript">
		function fileCheck(obj){
			pathpoint = obj.value.lastIndexOf('.');
			filepoint = obj.value.substring(pathpoint+1, obj.length);
			filetype = filepoint.toLowerCase();
			if(filetype=='jpg' || filetype=='gif' || filetype=='png' || filetype=='jpeg' || filetype=='bmp'){
				return true;
			}else{
				alert('이미지 파일만 첨부 가능합니다');
				parentObj = obj.parentNode;
				node = parentObj.replaceChilde(obj.cloneNode(true), obj);
				return false;
			}
			if(filetype=='bmp'){
				upload = confirm('BMP 파일은 웹상에서 사용하기엔 적절한 이미 포맷이 아닙니다.\n그래도 계속 하시겠습니까?');
				if(!upload){
					return false;
				}
			}
		}
	</script>
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
		<div id="content">
			<div id="writeReview_content">
				<div class="row_group" id="writeReview_caption">
					<a href="${conPath }/listReview.do">
						<span>[</span>&nbsp;
						<strong>REVIEW</strong>&nbsp;
						<span>]</span>
					</a>
				</div>
				<div class="row_group">
					<form action="${conPath }/writeReview.do" name="frm" method="post" enctype="multipart/form-data">
						<input type="hidden" name="mId" value="${member.mId }">
						<input type="hidden" name="mName" value="${member.mName }">
						<table id="writeReview_table_div">
							<tr>
								<td class="writeReview_title"><span>ID</span></td>
								<td><input type="text" id="review_id" readonly="readonly"
								value="${member.mId }"></td>
								<td class="writeReview_title"><span>NAME</span></td>
								<td><input type="text" id="review_name" readonly="readonly"
								value="${member.mName }"></td>
							</tr>
							<tr>
								<td class="writeReview_title"><span>E-MAIL</span></td>
								<td colspan="3"><input type="text" id="review_email"
								readonly="readonly" value="${member.mEmail }"></td>
							</tr>
							<tr>
								<td class="writeReview_title"><span>TITLE</span></td>
								<td colspan="3"><input type="text" id="review_title" name="rTitle" required="required"></td>
							</tr>
							<tr>
								<td class="writeReview_title"><span>CONTENT</span></td>
								<td colspan="3">
									<textarea id="review_content" name="rContent"></textarea>
								</td>
							</tr>
							<tr>
								<td class="writeReview_title"><span>FILE 1</span></td>
								<td colspan="3">
									<input type="text" class="file_name" disabled="disabled">&nbsp;
									<label for="review_file1">업로드</label>
									<input type="file" class="review_file" id="review_file1" name="rFileName_1" 
									accept='image/jpeg,image/gif,image/png' onchange='fileCheck(this)'>
								</td>
							</tr>
							<tr>
								<td class="writeReview_title"><span>FILE 2</span></td>
								<td colspan="3">
									<input type="text" class="file_name" disabled="disabled">&nbsp;
									<label for="review_file2">업로드</label>
									<input type="file" class="review_file" id="review_file2" name="rFileName_2"
									accept='image/jpeg,image/gif,image/png' onchange='fileCheck(this)'>
								</td>
							</tr>
							<tr>
								<td class="writeReview_title"><span>FILE 3</span></td>
								<td colspan="3">
									<input type="text" class="file_name" disabled="disabled">&nbsp;
									<label for="review_file3">업로드</label>
									<input type="file" class="review_file" id="review_file3" name="rFileName_3"
									accept='image/jpeg,image/gif,image/png' onchange='fileCheck(this)'>
								</td>
							</tr>
							<tr>
								<td class="writeReview_title"><span>FILE 4</span></td>
								<td colspan="3">
									<input type="text" class="file_name" disabled="disabled">&nbsp;
									<label for="review_file4">업로드</label>
									<input type="file" class="review_file" id="review_file4" name="rFileName_4"
									accept='image/jpeg,image/gif,image/png' onchange='fileCheck(this)'>
								</td>
							</tr>
							<tr>
								<td class="writeReview_title"><span>FILE 5</span></td>
								<td colspan="3">
									<input type="text" class="file_name" disabled="disabled">&nbsp;
									<label for="review_file5">업로드</label>
									<input type="file" class="review_file" id="review_file5" name="rFileName_5"
									accept='image/jpeg,image/gif,image/png' onchange='fileCheck(this)'>
								</td>
							</tr>
							<tr>
								<td colspan="4" id="btn_area">
									<input type="button" value="목록" onclick="location.href='${conPath}/listReview.do?pageNum=${param.pageNum }'">
									<input type="submit" value="확인">
								</td>
							</tr>
						</table>
					</form>
				</div><!-- .row_group -->
			</div><!-- #writeReview_content -->
		</div><!-- #content -->
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>