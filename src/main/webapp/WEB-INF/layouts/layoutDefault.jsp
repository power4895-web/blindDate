<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%--<jsp:useBean id="today" class="java.util.Date" />--%>
<%--<fmt:formatDate value="${today}" pattern="yyyyMMddhhmm" var="nowDate"/>--%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
</head>

<body>

<!-- wrap -->
<div>

	<!-- header -->
	<div >
<%--		<tiles:insertAttribute name="header" />--%>
	</div>
	<!--// header -->

	<!-- container -->
	<div >
		<tiles:insertAttribute name="body" />
	</div>
	<!--// container -->

	<!-- footer -->
	<div >
	<tiles:insertAttribute name="footer" />
	</div>

</div>
<!--// wrap -->
	
	
</body>
</html>