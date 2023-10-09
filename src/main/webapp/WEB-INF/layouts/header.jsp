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
                <button onclick="test()">test</button>
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
                                <a class="nav-link dropdown-toggle " type="button" id="navbarDropdownBlog" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    Mypage
                                    <span class="badge text-bg-danger" id="totalNCount"></span>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownBlog">
                                    <li><a class="dropdown-item" href="/user/todayProfile">오늘의 프로필</a></li>
                                    <li>
                                        <a class="dropdown-item position-relative" href="/user/friendList">
                                            친구리스트
                                            <span class="badge text-bg-danger" id="relationshipCount"></span>
                                        </a>
                                    </li>
                                    <li><a class="dropdown-item" href="blog-post.html">채팅</a></li>
                                    <li><a class="dropdown-item" href="/user/updateForm/${info.user.id}">내정보수정</a></li>
                                    <li><a class="dropdown-item" href="blog-post.html">스케줄</a></li>
                                </ul>
                            </li>
                            <li>&nbsp;&nbsp;</li>
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
        console.log("info", $('#info').val())

        if (!("Notification" in window)) {
            // 브라우저가 알림을 지원하는지 확인
            alert("This browser does not support desktop notification");
        } else if (Notification.permission === "granted") {
            // 알림 권한이 이미 부여되었는지 확인합니다.
            // 그렇다면 알림을 생성합니다.
            alert("granted")
            const notification = new Notification("Hi there!");
            // …
        } else if (Notification.permission === "denied") {
            alert("!!denied")
            // 사용자에게 권한을 요청해야 합니다.
            Notification.requestPermission().then((permission) => {
                // 사용자가 수락하면 알림을 생성합니다.
                console.log("permission : ", permission);
                if (permission === "granted") {
                    const notification = new Notification("Hi there!");
                    // …
                }
            });
        }

        return;



        if($('#info').val() != null) {
            // getNotificationCount();


            const eventSource = new EventSource('http://localhost:8080/notifications/subscribe/' + $('#info').val());
            eventSource.addEventListener('sse', event => {

                console.log(">>>>>>>>>>>>>>>>>>>event : ",event);
                console.log(">>>>>>>>>>>>>>>>>>>data : ",event.data);

                if(event.data == '승낙') {
                    console.log(">>>>>>>>>>>>>>>>>>>승낙 >> mypage 채팅에 알람표시");
                }
                if(event.data == '친구해요') {
                    var permission = Notification.requestPermission();
                    console.log(">>>",permission)


                    console.log(">>>>>>>>>>>>>>>>>>>친구해요 :  mypage 친구리스트에 알람표시 ");
                    $('#totalNCount').text(totalNCount + 1)
                    $('#relationshipCount').text(relationshipCount + 1)

                    // 브라우저 알림
                    // 브라우저 알림 허용 권한
                    let granted = false;
                    if (Notification.permission === 'granted') {
                        granted = true;
                    }
                    if (Notification.permission ==! 'granted') {
                        console.log("새로운 메세지가 왔습니다. 하지만 현재 알림허용이 되어있지 않습니다. 알림을 받고 싶다면 캐시를 지우고 새로고침하여 알림을 확인해보세요.");
                        return;
                    }
                    console.log("granted", granted)
                    // 알림 보여주기
                    if (granted) {
                        const notification = new Notification('알림!!!', {
                            body: "누군가가 친구신청을 했습니다."
                        });
                        setTimeout(() => {
                            notification.close();
                        }, 10 * 1000);
                        notification.addEventListener('click', () => {
                            window.open("localhost:8080/user/view/" + 2, '_blank');
                        });
                    }
                }
            });//eventSource.addEventListener end
        }//if end
    })//ready end

    let relationshipCount= 0;
    let totalNCount= 0;

    function getNotificationCount() {
        $.ajax({
            type : 'get',
            url : "/notification/count",
            success : function(data) { // 결과 성공 콜백함수
                console.log("data", data)
                if(data.relationshipCount != 0) {
                    relationshipCount = data.relationshipCount
                    $('#relationshipCount').text(data.relationshipCount)
                }
                if(data.totalNCount != 0) {
                    totalNCount = data.totalNCount
                    $('#totalNCount').text(data.totalNCount)
                }
            },
            error : function(request, status, error) { // 결과 에러 콜백함수
                console.log("error", error)
            }
      })
    }

    function test(){
        var permission = Notification.requestPermission();
        console.log(">>>",permission)
    }
</script>