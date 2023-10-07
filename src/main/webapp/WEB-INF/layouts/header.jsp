<%--
  Created by IntelliJ IDEA.
  User: anjdu
  Date: 2023-08-24
  Time: 오전 11:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<sec:authentication var="info" property="principal" />
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="/static/js/jquery.form.js"></script>
<script src="/static/js/commonUtil.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="/static/js/scripts.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=42f0eba0161fc3396885c9e3336cdeee&libraries=services" type="text/javascript"></script>
<html>
<head>
    <meta charset="utf-8" />
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
    <link href="/static/css/styles.css" rel="stylesheet" />

</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />


<body class="d-flex flex-column h-100">

    <main class="flex-shrink-0">
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container px-5">
                <a class="navbar-brand" href="/">MEET UP</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                        <li class="nav-item"><a class="nav-link" href="/">Home</a></li>
                        <li class="nav-item"><a class="nav-link" href="/about">About</a></li>
                        <li class="nav-item"><a class="nav-link" href="/contact">Contact</a></li>
                        <li class="nav-item"><a class="nav-link" href="/pricing">Pricing</a></li>
                        <li class="nav-item"><a class="nav-link" href="/faq">FAQ</a></li>
                        <sec:authorize access="isAuthenticated()">
                            <input type="hidden" value="${info.user.id}" id="info">
                            <li class="nav-item dropdown">
                            <span class="position-absolute top-0 start-100 translate-middle p-2 bg-danger border border-light rounded-circle">
                                <span class="visually-hidden">New alerts</span>
                            </span>
                                <a class="nav-link dropdown-toggle" id="navbarDropdownBlog" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    Mypage
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownBlog">
                                    <li><a class="dropdown-item" href="/user/todayProfile">오늘의 프로필</a></li>
                                    <li>
                                        <a class="dropdown-item position-relative" href="/user/friendList">
                                            친구리스트
                                            <span class="position-absolute top-50 start-50 translate-middle p-1 bg-danger border border-light rounded-circle">
                                                <span class="visually-hidden">New alerts</span>
                                            </span>
                                        </a>
                                    </li>
                                    <li><a class="dropdown-item" href="blog-post.html">채팅</a></li>
                                    <li><a class="dropdown-item" href="/user/updateForm/${info.user.id}">내정보수정</a></li>
                                    <li><a class="dropdown-item" href="blog-post.html">스케줄</a></li>
                                </ul>
                            </li>
                            <li class="nav-item"><a class="nav-link" >${info.user.nickname}님 안녕하세요</a></li>
                            <li class="nav-item"><a class="nav-link " href="/logout">로그아웃<i class="bi bi-arrow-bar-right"></i></a></li>
                        </sec:authorize>
                    </ul>
                </div>
            </div>
        </nav>
    </main>
</body>
</html>
<script>
    $(document).ready(function (){
        if($('#info').val() != null) {
            const eventSource = new EventSource('http://localhost:8080/notifications/subscribe/' + $('#info').val());
            eventSource.addEventListener('sse', event => {
                console.log(">>>>>>>>>>>>>>>>>>>event : ",event);
                console.log(">>>>>>>>>>>>>>>>>>>data : ",event.data);
                if(event.data == '승낙') {
                    console.log(">>>>>>>>>>>>>>>>>>>승낙 >> mypage 채팅에 알람표시");
                }
                if(event.data == '친구해요') {
                    navbarDropdownBlog
                    console.log(">>>>>>>>>>>>>>>>>>>친구해요 :  mypage 친구리스트에 알람표시 ");
                }
            });
        }
    })
</script>