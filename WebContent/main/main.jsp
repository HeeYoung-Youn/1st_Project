<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<c:set var="conPath" value="${pageContext.request.contextPath }"/>
<c:if test="${not empty loginSuccessMsg }">
	<script>
		alert('${loginSuccessMsg}');
	</script>
</c:if>
<c:if test="${not empty loginFailMsg }">
	<script>
		alert('${loginFailMsg}');
		history.back();
	</script>
</c:if>
<c:if test="${not empty logoutSuccessMsg }">
	<script>
		alert('${logoutSuccessMsg}');
	</script>
</c:if>
<c:if test="${not empty modifyResult }">
	<script>
		alert('${modifyResult}');
	</script>
</c:if>
<c:if test="${not empty quitSuccessMsg }">
	<script>
		alert('${quitSuccessMsg}');
	</script>
</c:if>
<c:if test="${not empty quitFailMsg }">
	<script>
		alert('${quitFailMsg}');
		history.back();
	</script>
</c:if>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>PHONE_REV</title>
	<link href="${conPath }/css/style.css" rel="stylesheet">
	<link href="${conPath }/css/main.css" rel="stylesheet">
	<script type="text/javascript" src="${conPath }/js/modernizr.custom.28468.js"></script>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="${conPath }/js/jquery.flexslider.js"></script>
	<script>
		$(function(){
			$('#mslider').flexslider({
				animation : 'slide', 
				prevText : ' ', 
				nextText : ' ',
			});
		});
	</script>
</head>
<body>
	<jsp:include page="header.jsp"/>
	<div id="content">
        <div id="slider">
            <div id="mslider" class="flexslider">
                <ul class="slides">
                	<li><img src="${conPath }/img/slide_2.png" alt="배경2"></li>
                	<li><img src="${conPath }/img/slide_3.png" alt="배경3"></li>
                	<li><img src="${conPath }/img/slide_4.png" alt="배경4"></li>
                	<li><img src="${conPath }/img/slide_5.jpg" alt="배경5"></li>
                	<li><img src="${conPath }/img/slide_1.png" alt="배경1"></li>
                </ul>
            </div>
        </div>
        <div class="none"></div>
        <div id="section2">
            <table>
                <tr>
                    <c:forEach var="i" begin="0" end="3">
                    	<td>
                    		<a href="${conPath }/contentReview.do?rNum=${rNumList[i] }">
	                    		<c:if test="${fn:length(fileNameList[i])>0 }">
	                    			<img src="${conPath }/reviewFile/${fileNameList[i] }" width="290" height="230">
	                    		</c:if>
	                    		<c:if test="${fn:length(fileNameList[i])==0 }">
	                    			<img src="http://placehold.it/290x230" alt="article_sample" />
	                    		</c:if>
	                    	</a>
                    	</td>
                    </c:forEach>
                </tr>
                <tr>
                    <c:forEach var="i" begin="4" end="7">
                    	<td>
                    		<a href="${conPath }/contentReview.do?rNum=${rNumList[i] }">
	                    		<c:if test="${fn:length(fileNameList[i])>0 }">
	                    			<img src="${conPath }/reviewFile/${fileNameList[i] }" width="290" height="230">
	                    		</c:if>
	                    		<c:if test="${fn:length(fileNameList[i])==0 }">
	                    			<img src="http://placehold.it/290x230" alt="article_sample" />
	                    		</c:if>
	                    	</a>
                    	</td>
                    </c:forEach>
                </tr>
            </table>
        </div>
    </div>
    <jsp:include page="footer.jsp"/>
</body>
</html>