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
	<link href="${conPath }/css/contentReview.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script>
		$(document).ready(function(){
			var totCnt = '${totCnt}'
			if(totCnt < 20){
				$('#comment_find_btn').css('display','none');
			}
			$('#like').click(function(){
				var mId = '${member.mId}';
				var rNum = '${param.rNum}';
				$.ajax({
					url : '${conPath}/reviewLike.do', 
					type : 'get', 
					dataType : 'html', 
					data : "mId=" + mId+ "&rNum=" + rNum,
					success : function(data){
						$('.likeCnt').html(data);
					}
				});
			});
			
			var pageCnt = Number('${pageCnt}');
			
			$('#comment_find_btn').click(function(){
				var pageNum = Number($('.pageNum').last().val());
				var rNum = '${param.rNum}';
				if(isNaN(pageNum)){
					pageNum=1;
				}
				$.ajax({
					url : '${conPath}/ReviewCommentAppend.do', 
					type : 'get', 
					dataType : 'html', 
					data : "pageNum=" + pageNum + "&rNum=" + rNum, 
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
		<div id="reviewContent">
			<div class="row_group" id="reviewContent_caption">
				<a href="${conPath }/listReview.do">
					<span>[</span>&nbsp;
					<strong>REVIEW</strong>&nbsp;
					<span>]</span>
				</a>			
			</div>
			<div class="row_group" id="reviewContent_reviewInfo">
				<div id="reviewContent_title">
					<h4>${reviewDto.rTitle }</h4>
				</div>
				<div id="reviewContent_others">
					<table>
						<tr>
							<td class="first_td">NAME : ${reviewDto.mName }</td>
							<td class="second_td">HITS : ${reviewDto.rHit }</td>
						</tr>
						<tr>
							<td class="first_td">DATE : ${reviewDto.rDate }</td>
							<td class="second_td">LIKE : <span class="likeCnt">${reviewDto.likeCnt }</span></td>
						</tr>
						<tr>
							<td colspan="2">IP : ${reviewDto.rIp }</td>
						</tr>
					</table>
				</div>
			</div>
			<c:if test="${not empty reviewDto.rFileName_1 or not empty reviewDto.rFileName_2
				or not empty reviewDto.rFileName_3 or not empty reviewDto.rFileName_4 or not empty reviewDto.rFileName_5}">
				<div class="row_group" id="reviewContent_file">
					<c:if test="${not empty reviewDto.rFileName_1 }">
						<div class="reviewImg">
							<img src="${conPath }/reviewFile/${reviewDto.rFileName_1}" class="review_Img">
						</div>
					</c:if>
					<c:if test="${not empty reviewDto.rFileName_2 }">
						<div class="reviewImg">
							<img src="${conPath }/reviewFile/${reviewDto.rFileName_2}" class="review_Img">
						</div>
					</c:if>
					<c:if test="${not empty reviewDto.rFileName_3 }">
						<div class="reviewImg">
							<img src="${conPath }/reviewFile/${reviewDto.rFileName_3}" class="review_Img">
						</div>
					</c:if>
					<c:if test="${not empty reviewDto.rFileName_4 }">
						<div class="reviewImg">
							<img src="${conPath }/reviewFile/${reviewDto.rFileName_4}" class="review_Img">
						</div>
					</c:if>
					<c:if test="${not empty reviewDto.rFileName_5 }">
						<div class="reviewImg">
							<img src="${conPath }/reviewFile/${reviewDto.rFileName_5}" class="review_Img">
						</div>
					</c:if>
				</div>
			</c:if>
			<div class="row_group" id="reviewContent_content">
				<pre>${reviewDto.rContent }</pre>
			</div>
			<c:if test="${not empty member }">
				<div class="row_group" id="reviewContent_like">
					<div id="like">
						<img src="${conPath }/img/like.png"><br>
						<span class="likeCnt">${reviewDto.likeCnt }</span>
					</div>
				</div>
			</c:if>
			<div id="btn_area">
				<c:if test="${not empty admin and reviewDto.rDelete==0}">
					<button onclick="location='${conPath}/recoverReview.do?rNum=${param.rNum }&pageNum=${param.pageNum }'">복구</button>
				</c:if>
				<c:if test="${reviewDto.mId eq member.mId }">
					<button onclick="location='${conPath}/modifyReviewView.do?rNum=${param.rNum }&pageNum=${param.pageNum }'">수정</button>
				</c:if>
				<c:if test="${reviewDto.mId eq member.mId or not empty admin}">
					<button onclick="location='${conPath}/deleteReview.do?rNum=${param.rNum }&pageNum=${param.pageNum }'">삭제</button>
				</c:if>
				<button onclick="location='${conPath}/listReview.do'">목록</button>
			</div>
		</div><!-- #reviewContent -->
		<c:if test="${not empty member and member.mGrade==1}">
			<div id="write_comment">
				<div id="write_area">
					<form action="${conPath }/writeCommentReview.do" method="post">
						<input type="hidden" name="mId" value="${member.mId }">
						<input type="hidden" name="rNum" value="${param.rNum }">
						<input type="hidden" name="pageNum" value="${param.pageNum }">
						<div>
							<textarea name="cContent"></textarea>
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
						<c:forEach var="i" begin="1" end="${dto.cIndent }">
							<div class="commentList_indent">
								<c:if test="${i==dto.cIndent }">
									<div class="commentList_arrow">
										<img src="${conPath }/img/comment.png">
									</div>
								</c:if>
								<c:if test="${i!=dto.cIndent }">
									<div class="commentList_space">
										&nbsp; &nbsp;
									</div>
								</c:if>
							</div>
						</c:forEach>
						<div class="commentList_info">
							<span class="mName"><b>${dto.mName }</b></span><br>
							<span class="cIp">${dto.cDate } [${dto.cIp }]</span>	
						</div>
						<div class="commentList_content">
							<pre><span>${dto.cContent }</span></pre>
						</div>
						<c:if test="${not empty member and member.mGrade==1}">
							<div class="write_comment_comment_btn" id="write_comment_comment_btnId${j }">
								<span>댓글</span>
							</div>
						</c:if>
					</div><!-- #comment_content -->
					<div class="write_comment_comment" id="write_comment_commentId${j }">
						<div id="write_area">
							<form action="${conPath }/writeComment_commentReview.do" method="post">
								<input type="hidden" name="mId" value="${member.mId }">
								<input type="hidden" name="rNum" value="${param.rNum }">
								<input type="hidden" name="pageNum" value="${param.pageNum }">
								<input type="hidden" name="cGroup" value="${dto.cGroup }">
								<input type="hidden" name="cStep" value="${dto.cStep }">
								<input type="hidden" name="cIndent" value="${dto.cIndent }">
								<div>
									<textarea name="cContent"></textarea>
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