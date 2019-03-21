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
	<link href="${conPath }/css/contentNotice.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script>
		$(document).ready(function(){
			var totCnt = '${totCnt}'
			if(totCnt < 20){
				$('#comment_find_btn').css('display','none');
			}
			
			var pageCnt = Number('${pageCnt}');
			
			$('#comment_find_btn').click(function(){
				var pageNum = Number($('.pageNum').last().val());
				var nNum = '${param.nNum}';
				if(isNaN(pageNum)){
					pageNum=1;
				}
				$.ajax({
					url : '${conPath}/NoticeCommentAppend.do', 
					type : 'get', 
					dataType : 'html', 
					data : "pageNum=" + pageNum + "&nNum=" + nNum, 
					success : function(data){
						$('#comment_append').append(data);
						if(pageCnt == pageNum + 1){
							$('#comment_find_btn').css('display','none');
						}
					}
				}); //ajax
			}); //click
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
	<jsp:include page="../main/header.jsp"/>
	<div id="content">
		<div id="noticeContent">
			<div class="row_group" id="noticeContent_caption">
				<a href="${conPath }/listNotice.do">
					<span>[</span>&nbsp;
					<strong>NOTICE</strong>&nbsp;
					<span>]</span>
				</a>
			</div>
			<div class="row_group" id="noticeContent_noticeInfo">
				<div id="noticeContent_title">
					<h4>${noticeDto.nTitle }</h4>
				</div>
				<div id="noticeContent_others">
					<table>
						<tr>
							<td class="first_td">NAME : ${noticeDto.aName }</td>
							<td class="second_td">HITS : ${noticeDto.nHit }</td>
						</tr>
						<tr>
							<td class="first_td">DATE : ${noticeDto.nDate }</td>
						</tr>
					</table>
				</div>
			</div>
			<div class="row_group" id="noticeContent_content">
				<pre>${noticeDto.nContent }</pre>
			</div>
			<div id="btn_area">
				<c:if test="${not empty admin and noticeDto.nDelete==0}">
					<button onclick="location='${conPath}/recoverNotice.do?nNum=${param.nNum }&pageNum=${param.pageNum }'">복구</button>
				</c:if>
				<c:if test="${not empty admin }">
					<button onclick="location='${conPath}/modifyNoticeView.do?nNum=${param.nNum }&pageNum=${param.pageNum }'">수정</button>
				</c:if>
				<c:if test="${not empty admin}">
					<button onclick="location='${conPath}/deleteNotice.do?nNum=${param.nNum }&pageNum=${param.pageNum }'">삭제</button>
				</c:if>
				<button onclick="location='${conPath}/listNotice.do'">목록</button>
			</div>
		</div><!-- #noticeContent -->
		<c:if test="${not empty member }">
			<div id="write_comment">
				<div id="write_area">
					<form action="${conPath }/writeCommentNotice.do" method="post">
						<input type="hidden" name="mId" value="${member.mId }">
						<input type="hidden" name="nNum" value="${param.nNum }">
						<input type="hidden" name="pageNum" value="${param.pageNum }">
						<div>
							<textarea name="ncContent"></textarea>
						</div>
						<div>
							<input type="submit" value="등록" id="insert_comment_btn">
						</div>
					</form>
				</div>
			</div>
		</c:if>
		<c:if test="${not empty commentList }">
			<c:set var="j" value="0"/>
			<div id="comment">
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
			<div id="comment_append">
			</div>
			<div id="comment_find_btn">
				<div id="comment_find">
					<span id="search_text">더보기 </span><img src="${conPath }/img/down_arrow.png">
				</div>
			</div>
		</c:if>
	</div><!-- #content -->
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>