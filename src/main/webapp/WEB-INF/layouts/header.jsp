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
                                <a class="nav-link dropdown-toggle " type="button" id="navbarDropdownBlog" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    Mypage
                                    <span class="badge text-bg-danger" id="totalNCount"></span>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownBlog">
                                    <li><a class="dropdown-item" href="/user/todayProfile">오늘의 프로필</a></li>
                                    <li>
                                        <a class="dropdown-item position-relative" href="/user/friendList">
                                            친구리스트
                                            <span class="badge text-bg-danger" id="friendshipListCount"></span>
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
        console.log("header start")
        console.log("Notification.permission", Notification.permission)
        if($('#info').val() != null) {
            sendNotification();

        }//if end
    })//ready end


    let totalNCount= 0; //mypage,친구리스트 알람개수
    //현재시점 알람개수 가져와서 매핑
    function getNotificationCount() {
        $.ajax({
            type : 'get',
            url : "/notification/count",
            success : function(data) { // 결과 성공 콜백함수
                console.log("notiCount", data)
                if(data.totalNCount != 0) {
                    totalNCount = data.totalNCount
                    $('#totalNCount').text(totalNCount)
                    $('#friendshipListCount').text(totalNCount)
                } else {
                    $('#totalNCount').text('')
                    $('#friendshipListCount').text('')
                }
            },
            error : function(request, status, error) { // 결과 에러 콜백함수
                console.log("error", error)
            }
      })
    }

    //구독하기
    // 최초 구독할 때 한번 호출
    function sendNotification() {
        //구독커넥션 연결
        const eventSource = new EventSource('http://localhost:8080/notifications/subscribe/' + $('#info').val());
        eventSource.addEventListener('sse', event => {
            //서버에서 send()를 하면 이부분부터 로직이 수행된다.
            //현재시점 알람가져오기
            getNotificationCount();  //totalNCount의 변수 할당
            console.log(">>>>>>>>>>>>>>>>>>>event : ",event);
            if(event.data == '호감') {
                alertNotification("이성이 높은 점수를 줬습니다.");
            }
            if(event.data == '친구해요') {
                alertNotification("이성이 친구신청을 했습니다.");
            }
            if(event.data == '승낙해요') {
                alertNotification("이성이 친구신청을 승낙했습니다.");
            }
        });//eventSource.addEventListener end
    }

    //알림 띄우기
    function alertNotification (message) {
        console.log(">>>>>>>>>>>>>>>>>>>승낙 >> mypage 채팅에 알람표시");
        if(Notification.permission !== "granted") {
            alert("새로운 메세지가 있습니다. 실시간으로 알람을 받고 싶은 경우 브라우저에서 알림을 활성화 시켜주세요.")
            Notification.requestPermission().then((permission) => {
                console.log("permission", permission)
                // handlePermission(permission);
                // 사용자가 허용하면 알림 띄우기
                if (permission === "granted") {
                    var notification = new Notification("알림 메세지를 받습니다.");
                }
            });
        }
        //친구하기 또는 호감을 했기 때문에 알람개수 늘려주기
        if(totalNCount != 0) {
            console.log("totalNCount", totalNCount)
            $('#totalNCount').text(totalNCount + 1)
            $('#friendshipListCount').text(totalNCount + 1)
        }

        let granted = false;
        if (Notification.permission === 'granted') {
            granted = true;
        }
        console.log("granted", granted)
        // 알림 보여주기
        if (granted) {
            const notification = new Notification('알림!!!', {
                body: message
            });
            setTimeout(() => {
                notification.close();
            }, 10 * 1000);
            notification.addEventListener('click', () => {
                window.open("http://localhost:8080/user/friendList/", '_blank');
            });
        }
    }
</script>