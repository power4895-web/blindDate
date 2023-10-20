<%--
  Created by IntelliJ IDEA.
  User: anjdu
  Date: 2023-06-20
  Time: 오후 12:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%--<script src="https://code.jquery.com/jquery-1.12.4.js"></script>--%>
<%--<script src="/static/js/jquery.form.js"></script>--%>
<script type="text/javascript" src="/static/js/jquery-2.2.4.js"></script>
<script type="text/javascript" src="/static/js/commonUtil.js"></script>
<%--수정합니다2234--%>
<html>
<head>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <meta charset="UTF-8">
    <title>Chating</title>
</head>
<!DOCTYPE html>
<html lang="ko" data-dark="false">
<head>
    <meta charset="utf-8">
    <title>Kakao Talk Chat Room</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
    <meta http-equiv="X-UA-Compatible" content="IE-edge">
    <meta name="description" content="Kakao Talk Clone Chat Page">
    <meta name="robotos" content="noindex, nofollow">
    <link rel="stylesheet" href="/static/css/chat-room.css">
    <link rel="stylesheet" href="/static/css/general.css">
<%--    <link rel="stylesheet" href="fontello/css/fontello.css">--%>
<%--    <link rel="preconnect" href="https://fonts.gstatic.com">--%>
<%--    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap">--%>
</head>
<body>
<div id="chat_container">
    <div id="chat-body">
        <input type="text" id="sessionId" value="">
        <input type="hidden" id="roomId" value="${roomId}">
        <input type="hidden" id="myNickname" value="${userInfo.nickname}" name="myNickname">
        <input type="hidden" id="yourNickname" value="${yourNickname}" name="yourNickname">
        <input type="hidden" id="chatList" value="${chatList}" name="chatList">
        <input type="hidden" value="${imgUrl}" id="imgUrl" >


        <!-- 설정바(최소화, 닫기 버튼 등) -->
        <div class="setting_bar">
            <i class="icon-window-minimize" alt="최소화버튼" title="최소화"></i>
            <i class="icon-window-maximize" alt="최대화버튼" title="최대화"></i>
            <i class="icon-cancel" alt="닫기버튼" title="닫기"></i>
        </div>
        <!-- 알림, 메뉴 기능 -->
        <div class="main-menu">
            <i class="icon-bell" title="알림"></i>
            <i class="icon-ellipsis" title="메뉴"></i>
        </div>
        <!-- 프로필 사진, 프로필명 -->
        <%--    <header>--%>
        <%--        <img class="profile-img" src="./pic/default.png" alt="쀼프로필사진">--%>
        <%--        <div class="profile-col">--%>
        <%--            <span class="profile-name">쀼사원</span>--%>
        <%--            <div class="sub-menu">--%>
        <%--                <i class="icon-box" title="채팅방 서랍"></i>--%>
        <%--                <i class="icon-search" title="검색"></i>--%>
        <%--            </div>--%>
        <%--        </div>--%>
        <%--    </header>--%>
        <main>
            <!-- 고정된 공지사항 영역 -->
            <%--        <div class="notice-bar">--%>
            <%--            <i class="icon-bullhorn"></i>--%>
            <%--            <span>멘트를 고정해놓는 곳입니다.</span>--%>
            <%--            <i class="icon-down-open-big"></i>--%>
            <%--        </div>--%>
            <!-- 채팅 내용 시작 -->
            <div class="chat-content">
                <!-- 메시지 시작 날짜 -->
                <%--            <div class="date-line">--%>
                <%--                <time datetime="2021-03-29">2021년 3월 29일 월요일</time>--%>
                <%--            </div>--%>
                <!-- 채팅 내용 -->
                <div class="main-chat" id="chating">
                    <c:if test="${chatList != null}">
                    <c:forEach var="item" items="${chatList}" varStatus="status">
                        <fmt:formatDate  var="date1" value="${chatList[status.index].createDate}" type="DATE" pattern="a h:mm"/>
                        <fmt:formatDate  var="date2" value="${chatList[status.index-1].createDate}" type="DATE" pattern="a h:mm"/>
                    <c:if test="${userInfo.id == item.fromId}">
                        <%--나--%>
                    <div class="me-chat">
                        <div class="me-chat-col">
                            <span class="balloon">${item.content}</span>
                        </div>
                        <p class="readYn">${item.readYn == 'N' ? '1' : ''}</p>
                        <c:if test="${date1 != date2}">
                            <%--                                다르다:--%>
                            <time datetime="07:32:00+09:00"><fmt:formatDate  value="${item.createDate}" pattern="a h:mm" /></time>
                        </c:if>
                        <c:if test="${date1 == date2 && chatList[status.index].fromId != chatList[status.index -1].fromId}">
                            <%--                               같지만 아이디가 다르다--%>
                            <time datetime="07:32:00+09:00"><fmt:formatDate  value="${item.createDate}" pattern="a h:mm" /></time>
                        </c:if>
                    </div>
                    </c:if>
                    <c:if test="${userInfo.id == item.toId}">
                        <%--상대방--%>
                    <div class="friend-chat">
                        <c:if test="${chatList[status.index].toId == chatList[status.index -1].toId && date1 == date2}">
                            <%--이전과 지금 시간이 같고, 이전에 받은 사람과 지금 받는사람이 같다. > 민지가 2번보낸것이다. 이럴땐 imgurl없다.--%>
                            <div class="friend-chat-col" >
                                    <%--                                        <span class="profile-name">${yourNickname}</span>--%>
                                <span class="balloon" style="position: relative; margin-left: 60px;">${item.content}</span>
                            </div>
                        </c:if>
                        <c:if test="${chatList[status.index].toId != chatList[status.index -1].toId}">
                            <%--이전에 받은 사람과 지금 받는사람이 다르다. > 내가 받고, 민지가 받은것이다 imgUrl있다.--%>
                            <img class="profile-img" src="${imgUrl}" alt="쀼프로필사진">
                            <div class="friend-chat-col">
                                <span class="profile-name">${yourNickname}</span>
                                <span class="balloon">${item.content}</span>
                            </div>
                        </c:if>
                        <c:if test="${date1 != date2 && chatList[status.index].toId == chatList[status.index -1].toId}">
                            <%--시간이 다르게 민지가 2번보낸것이다--%>
                            <img class="profile-img" src="${imgUrl}" alt="쀼프로필사진">
                            <div class="friend-chat-col">
                                <span class="profile-name">${yourNickname}</span>
                                <span class="balloon">${item.content}</span>
                            </div>
                        </c:if>
                        <c:if test="${date1 != date2}">
                            <%--                                다르다:--%>
                            <time datetime="07:30:00+09:00">
                                <fmt:formatDate  value="${item.createDate}" pattern="a h:mm" />
                            </time>
                        </c:if>
                        <c:if test="${date1 == date2 && chatList[status.index].fromId != chatList[status.index -1].fromId}">
                            <%--                                같지만 아이디가 다르다--%>
                            <time datetime="07:30:00+09:00">
                                <fmt:formatDate  value="${item.createDate}" pattern="a h:mm" />
                            </time>
                        </c:if>
                    </div>
                    </c:if>
                    </c:forEach>
                    </c:if>
                    <!-- 채팅 입력창 -->
                    <div class="insert-content">
                        <form name="chatform" id="chatform">
                            <textarea name="chat-insert" id="chatInsert"></textarea>
                            <button class="chat-submit" onclick="send()" id="sendBtn">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                     class="bi bi-send-fill" viewBox="0 0 16 16">
                                    <path d="M15.964.686a.5.5 0 0 0-.65-.65L.767 5.855H.766l-.452.18a.5.5 0 0 0-.082.887l.41.26.001.002 4.995 3.178 3.178 4.995.002.002.26.41a.5.5 0 0 0 .886-.083l6-15Zm-1.833 1.89L6.637 10.07l-.215-.338a.5.5 0 0 0-.154-.154l-.338-.215 7.494-7.494 1.178-.471-.47 1.178Z"/>
                                </svg>
                            </button>
                            <%--                <input class="chat-submit" value="" onclick="send()" id="sendBtn">--%>

                            </input>
                        </form>
                        <!-- 채팅 입력 관련 기능(파일 첨부, 캡쳐 등) -->
                        <div class="insert-menu">
                            <i class="icon-smile"></i>
                            <i class="icon-attach"></i>
                            <i class="icon-phone"></i>
                            <i class="icon-calendar-empty"></i>
                            <i class="icon-camera"></i>
                        </div>
                    </div>
        </main>
    </div>
</div>


</body>
</html>
<script type="text/javascript">

    $(document).ready(function () {

        updateChat();
        //가장 맨 아래로 스크롤 내리기
        $('#chat_container').scrollTop($('#chat_container')[0].scrollHeight);


        // 하단 스크롤 이동 버튼
        // $('.scroll_bottom_btn').click(function(e){
        //     $('#chat_container').scrollTop($('#chat_container')[0].scrollHeight);
            // 애니메이션 효과를 주고 싶다면
            // $('#chat_container').animate({
            //  	scrollTop: $('#chat_container')[0].scrollHeight
            // }, 400);
        // });


        console.log(">>", $('.myTextboxDate').val());
        const chatform = document.chatform
        chatform.addEventListener("submit", (event) => {
            // 동작(이벤트)을 실행하지 못하게 막는 메서드입니다.
            event.preventDefault();

            console.log(event.target);
        });
        chatName()
    })


    var ws;

    function wsOpen() {
        console.log("wsOpen")
        console.log("wsOpen", location.host)
        console.log("roomId", $("#roomId").val())
        ws = new WebSocket("ws://" + location.host + "/chating/" + $("#roomId").val());
        wsEvt();
    }

    let oldTime = null;
    let oldSesstionId = null;
    function wsEvt() {
        console.log("wsEvt")
        ws.onopen = function (data) {
            console.log("소켓이 열리면 동작")
            console.log("data", data)
            //소켓이 열리면 동작
        }

        ws.onmessage = function (data) {
            console.log("data", data)
            console.log("data.data", data.data)
            //메시지를 받으면 동작
            var msg = data.data;
            var d = JSON.parse(msg); //보낼 땐 문자열로 보냈고, 받을 땐 json오브젝트를 자바스크립트 오브젝트로 변환
            console.log("d", d)
            console.log("d.readYn", d.readYn)
            console.log("d.type", d.type)
            console.log("d.msg", d.msg)
            if (d.type == "getId") {
                var si = d.sessionId != null ? d.sessionId : "";
                if (si != '') {
                    $("#sessionId").val(si);
                }
            } else if (d.type == "message") {
                let yourNickname = $('#yourNickname').val();
                let imgUrl = $('#imgUrl').val();

                let today = new Date();
                let hours = ('0' + today.getHours()).slice(-2);
                let minutes = ('0' + today.getMinutes()).slice(-2);
                let timeString = hours + ':' + minutes;
                console.log("timeString", timeString);
                console.log("oldTime", oldTime);

                d.readYn = d.readYn == "N" ? 1 : "";

                console.log("d.readYn",d.readYn)

                if (d.sessionId == $("#sessionId").val()) {
                    console.log("내가 쓴 채팅")
                    $("#chating").append(
                        `<div class='me-chat'>
                                <div class=me-chat-col>
                                    <span class=balloon>\${d.msg}</span>
                                </div>
                                <p class=readYn >\${d.readYn}<p>
                                <time datetime="07:32:00+09:00">
                                    \${timeString == oldTime ? '' : timeString}
                                </time>
                         </div>`
                    );
                } else {
                    console.log("상대방 쓴 채팅")
                    if(oldSesstionId == d.sessionId && timeString == oldTime) {
                        console.log("시간이 같게 민지가 두번보낸것")
                        $("#chating").append(
                            `<div class='friend-chat'>
                                <div class="friend-chat-col">
                                    <span class="balloon" style="position: relative; margin-left: 60px;">\${d.msg}</span>
                                </div>
                            </div>`
                        );
                    }
                    if(oldSesstionId != d.sessionId ) {
                        console.log("내가 받고, 민지가 받은것이다 imgUrl있다.")
                        $("#chating").append(
                            `<div class='friend-chat'>
                                <img class="profile-img" src="\${imgUrl}" alt="쀼프로필사진">
                                <div class="friend-chat-col">
                                    <span class="profile-name">\${yourNickname}</span>
                                    <span class="balloon">\${d.msg}</span>
                                </div>
                                <time datetime="07:32:00+09:00">
                                    \${timeString}
                                </time>
                             </div>`
                        );
                    }
                    if(oldSesstionId == d.sessionId && timeString != oldTime) {
                        console.log("시간이 다르게 민지가 2번보낸것이다.")
                        $("#chating").append(
                            `<div class='friend-chat'>
                                <img class="profile-img" src="\${imgUrl}" alt="쀼프로필사진">
                                <div class="friend-chat-col">
                                    <span class="profile-name">\${yourNickname}</span>
                                    <span class="balloon">\${d.msg}</span>
                                </div>
                             </div>`
                        );
                    }
                }
                oldTime = timeString
                oldSesstionId = d.sessionId

            } else if(d.type == "online") {
                console.log("online", "읽음처리 다 없애기")
                $('.readYn').remove();
            } else {
                console.warn("unknown type!")
            }
            // 송신, 또는 수신시 맨 아래로 이동
            $('#chat_container').scrollTop($('#chat_container')[0].scrollHeight);
        }

        //메세지 전송 엔터
        document.addEventListener("keypress", function (e) {
            // console.log("e", e)
            // console.log("chatInsert", $('#chatInsert').val())
            if (e.code == 'Enter') { //enter press
                if($('#chatInsert').val() == '') {
                    e.preventDefault(); // 기본 동작을 막음 (새 줄 추가 방지)
                    $('#chatInsert').val(''); // <textarea> 내용을 초기화
                    return;
                } else {
                    send();
                    e.preventDefault(); // 기본 동작을 막음 (새 줄 추가 방지)
                    $('#chatInsert').val(''); // <textarea> 내용을 초기화
                }
            }
        });
    }

    function chatName() {
        wsOpen();
        $("#yourMsg").show();
    }
    //채팅방 들어온 아이디 읽지 않은거 모두 읽은걸로 업데이트
    function updateChat() {
        const params = {
            'roomId' : $('#roomdId').val()
        }
        $.ajax({
            type: 'post',
            url: "/chat/update/",
            data: params,
            success: function (data) { // 결과 성공 콜백함수
                console.log("data", data)
            },
            error: function (request, status, error) { // 결과 에러 콜백함수
                console.log("error", error)
            }
        })
    }

    function send() {
        var option = {
            type: "message",
            roomId: $("#roomId").val(),
            sessionId: $("#sessionId").val(),
            nickname: $("#myNickname").val(),
            msg: $("#chatInsert").val()
        }
        var params = {
            content: option.msg,
            roomId: option.roomId,
        }
        $.ajax({
            type: 'post',
            url: "/chat/insert",
            data: params,
            success: function (data) { // 결과 성공 콜백함수
                console.log("data", data)
            },
            error: function (request, status, error) { // 결과 에러 콜백함수
                console.log("error", error)
            }
        })

        console.log("option : ", option)
        ws.send(JSON.stringify(option))  //자바에서 handleTextMessage실행, 문자열로 보내야 서버에서 메세지를 받음
        $('#chatInsert').val("");
    }
</script>
</html>
<style>
    * {
        padding: 0;
        margin: 0;
        box-sizing: border-box;
    }

    a {
        text-decoration: none;
    }

    .wrap {
        padding: 40px 0;
        background-color: #A8C0D6;
    }

    .wrap .chat {
        display: flex;
        align-items: flex-start;
        padding: 20px;
    }

    .wrap .chat .icon {
        position: relative;
        overflow: hidden;
        width: 50px;
        height: 50px;
        border-radius: 50%;
        background-color: #eee;
    }

    .wrap .chat .icon i {
        position: absolute;
        top: 10px;
        left: 50%;
        font-size: 2.5rem;
        color: #aaa;
        transform: translateX(-50%);
    }

    .wrap .chat .textbox {
        position: relative;
        display: inline-block;
        max-width: calc(100% - 70px);
        padding: 10px;
        margin-top: 7px;
        font-size: 13px;
        border-radius: 10px;
    }

    .wrap .chat .textbox::before {
        position: absolute;
        display: block;
        top: 0;
        font-size: 1.5rem;
    }

    .wrap .ch1 .textbox {
        margin-left: 20px;
        background-color: #ddd;
    }

    .wrap .ch1 .textbox::before {
        left: -15px;
        content: "◀";
        color: #ddd;
    }

    .wrap .ch2 {
        flex-direction: row-reverse;
    }

    .wrap .ch2 .textbox {
        margin-right: 20px;
        background-color: #F9EB54;
    }

    .wrap .ch2 .textbox::before {
        right: -15px;
        content: "▶";
        color: #F9EB54;
    }
</style>