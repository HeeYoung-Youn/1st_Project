<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="conPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>PHONE_REV</title>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script>
		$(document).ready(function(){
			
			$('.write_comment_comment').css('display', 'none');
			$('.write_comment_comment_btn').each(function(idx, item){
				$(this).click(function(){
					$('#write_comment_commentId'+(idx+1)).css('display', 'block');
				});
			});
		});
	</script>
</head>
<body>
	<c:if test="${empty error }">
		<div id="comment">
			<c:set var="j" value="${(pageNum-1)*20 }"/>
				<c:forEach var="dto" items="${commentList }">
					<c:set var="j" value="${j+1 }"/>
					<div id="comment_content">
						<c:forEach var="i" begin="1" end="${dto.ncIndent }">
							<div class="commentList_indent">
								<c:if test="${i==dto.ncIndent }">
									<div class="commentList_arrow">
										<img src="${conPath }/img/comment.png">
									</div>
								</c:if>
								<c:if test="${i!=dto.ncIndent }">
									<div class="commentList_space">
										&nbsp; &nbsp;
									</div>
								</c:if>
							</div>
						</c:forEach>
						<div class="commentList_info">
							<span class="mName"><b>${dto.mName }</b></span><br>
							<span class="cIp">${dto.ncDate } [${dto.ncIp }]</span>	
						</div>
						<div class="commentList_content">
							<pre><span>${dto.ncContent }</span></pre>
						</div>
						<c:if test="${not empty member }">
							<div class="write_comment_comment_btn" id="write_comment_comment_btnId${j }">
								<span>댓글</span>
							</div>
						</c:if>
					</div><!-- #comment_content -->
					<div class="write_comment_comment" id="write_comment_commentId${j }">
						<div id="write_area">
							<form action="${conPath }/writeComment_commentNotice.do" method="post">
								<input type="hidden" name="mId" value="${member.mId }">
								<input type="hidden" name="nNum" value="${param.nNum }">
								<input type="hidden" name="pageNum" value="${param.pageNum }">
								<input type="hidden" name="ncGroup" value="${dto.ncGroup }">
								<input type="hidden" name="ncStep" value="${dto.ncStep }">
								<input type="hidden" name="ncIndent" value="${dto.ncIndent }">
								<div>
									<textarea name="ncContent"></textarea>
								</div>
								<div>
									<input type="submit" value="등록" class="insert_comment_comment_btn">
								</div>
							</form>
						</div>
					</div>
				</c:forEach>
			</div><!-- #comment -->
		<input type="hidden" name="pageNum" class="pageNum" value="${pageNum }">
	</c:if>
	<c:if test="${not empty error }">
		<script>
			alert('마지막 페이지입니다');
		</script>
	</c:if>
</body>
</html>