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
<body>
<div id="container" class="container">
    <h1>${roomName}의 채팅방</h1>
    <input type="text" id="sessionId" value="">
    <input type="text" id="roomId" value="${roomId}">
    <input type="text" id="myNickname" value="${userInfo.nickname}" name="myNickname">
    <input type="text" id="yourNickname" value="${yourNickname}" name="yourNickname">
    <input type="text" id="chatList" value="${chatList}" name="chatList">
    <input type="text" value="${imgUrl}" id="imgUrl" >


    <%--    <div id="chating" class="chating">--%>
    <div class="wrap" id="chating">
        <c:if test="${chatList != null}">
            <c:forEach var="item" items="${chatList}" varStatus="status">
                <fmt:formatDate  var="date1" value="${chatList[status.index].createDate}" type="DATE" pattern="a h:mm"/>
                <fmt:formatDate  var="date2" value="${chatList[status.index-1].createDate}" type="DATE" pattern="a h:mm"/>
                <c:if test="${userInfo.id == item.fromId}">
                    <%--나--%>
                    <div class="chat ch2">
                        <div class="textbox">${item.content}</div>
                        <div class="myTextboxDate">
                            <c:if test="${date1 != date2}">
<%--                                다르다:--%>
                                <fmt:formatDate  value="${item.createDate}" pattern="a h:mm" />
                            </c:if>
                            <c:if test="${date1 == date2 && chatList[status.index].fromId != chatList[status.index -1].fromId}">
<%--                               같지만 아이디가 다르다--%>
                                <fmt:formatDate  value="${item.createDate}" pattern="a h:mm" />
                            </c:if>
                        </div>
                    </div>
                </c:if>
                <c:if test="${userInfo.id == item.toId}">
                    <div class="chat ch1">
                        <c:if test="${chatList[status.index].toId == chatList[status.index -1].toId && date1 == date2}">
<%--                            이전과 지금 시간이 같고, 이전에 받은 사람과 지금 받는사람이 같다. > 민지가 2번보낸것이다. 이럴땐 imgurl없다.--%>
                            <div class="textbox2">
                                    ${item.content}
                            </div>
                        </c:if>
                        <c:if test="${chatList[status.index].toId != chatList[status.index -1].toId}">
<%--                            이전에 받은 사람과 지금 받는사람이 다르다. > 내가 받고, 민지가 받은것이다 imgUrl있다.--%>
                            <div class="icon"><img class="img-fluid rounded-circle" src="${imgUrl}" alt="..." />
                            </div>
                            <p>${yourNickname}</p>
                            <div class="textbox">
                                    ${item.content}
                            </div>
                        </c:if>
                        <c:if test="${date1 != date2 && chatList[status.index].toId == chatList[status.index -1].toId}">
<%--                            시간이 다르게 민지가 2번보낸것이다--%>
                            <div class="icon"><img class="img-fluid rounded-circle" src="${imgUrl}" alt="..." /></div>
                            ${yourNickname}
                            <div class="textbox">
                                    ${item.content}
                            </div>
                        </c:if>


<%--                        <div class="icon"><img class="img-fluid rounded-circle" src="${imgUrl}" alt="..." /></div>--%>
<%--                            ${yourNickname}--%>


                        <div class="yourTextboxDate">
                            <c:if test="${date1 != date2}">
<%--                                다르다:--%>
                                <fmt:formatDate  value="${item.createDate}" pattern="a h:mm" />
                            </c:if>
                            <c:if test="${date1 == date2 && chatList[status.index].fromId != chatList[status.index -1].fromId}">
<%--                                같지만 아이디가 다르다--%>
                                <fmt:formatDate  value="${item.createDate}" pattern="a h:mm" />
                            </c:if>
<%--                            <fmt:formatDate value="${item.createDate}" pattern="a h:mm"/>--%>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </c:if>
    </div>

    <div>
        <table class="inputTable">
            <tr>
                <th><input id="chatting" placeholder="보내실 메시지를 입력하세요."></th>
                <th>
                    <button class="btn btn-dark" onclick="send()" id="sendBtn">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                             class="bi bi-send-fill" viewBox="0 0 16 16">
                            <path d="M15.964.686a.5.5 0 0 0-.65-.65L.767 5.855H.766l-.452.18a.5.5 0 0 0-.082.887l.41.26.001.002 4.995 3.178 3.178 4.995.002.002.26.41a.5.5 0 0 0 .886-.083l6-15Zm-1.833 1.89L6.637 10.07l-.215-.338a.5.5 0 0 0-.154-.154l-.338-.215 7.494-7.494 1.178-.471-.47 1.178Z"/>
                        </svg>
                    </button>
                </th>
            </tr>
        </table>
    </div>
</div>


</body>
<script type="text/javascript">

    $(document).ready(function () {
        console.log(">>", $('.myTextboxDate').val());

        chatName()
        getChatList();
    })

    function getChatList() {
        $("#roomId").val();
        let params = {
            roomId: $("#roomId").val()
        }
        $.ajax({
            type: 'post',
            url: "/chat/list",
            data: params,
            success: function (data) { // 결과 성공 콜백함수
                // console.log("data", data)
            },
            error: function (request, status, error) { // 결과 에러 콜백함수
                console.log("error", error)
            }
        })
    }


    var ws;

    function wsOpen() {
        console.log("wsOpen")
        console.log("wsOpen", location.host)
        console.log("roomId", $("#roomId").val())
        ws = new WebSocket("ws://" + location.host + "/chating/" + $("#roomId").val());
        wsEvt();
    }

    function wsEvt() {
        console.log("wsEvt")
        ws.onopen = function (data) {
            console.log("소켓이 열리면 동작")
            //소켓이 열리면 동작
        }

        ws.onmessage = function (data) {
            console.log("data", data)
            console.log("data.data", data.data)
            //메시지를 받으면 동작
            var msg = data.data;
            var d = JSON.parse(msg); //보낼 땐 문자열로 보냈고, 받을 땐 json오브젝트를 자바스크립트 오브젝트로 변환
            console.log("d", d)
            console.log("d.type", d.type)
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

                console.log(timeString);

                if (d.sessionId == $("#sessionId").val()) {
                    $("#chating").append(
                        `<div class='chat ch2'>
                                <div class=textbox>\${d.msg}</div>
                                    <div class=myTextboxDate>
                                        \${timeString}
                                    </div>
                         </div>
                         `
                    );
                } else {
                    $("#chating").append(
                        `<div class='chat ch1'>
                                <div class=icon><img class=img-fluid rounded-circle src=\${imgUrl} alt="..." /></div>
                                \${yourNickname}
                                <div class=textbox>\${d.msg}
                                    <div class=yourTextboxDate>
                                        \${timeString}
                                    </div>
                                </div>
                         </div>
                        `
                    );
                }
            } else {
                console.warn("unknown type!")
            }
        }

        document.addEventListener("keypress", function (e) {
            if (e.keyCode == 13) { //enter press
                send();
            }
        });
    }

    function chatName() {
        wsOpen();
        $("#yourMsg").show();
    }

    function send() {
        console.log("send")
        var option = {
            type: "message",
            roomId: $("#roomId").val(),
            sessionId: $("#sessionId").val(),
            nickname: $("#myNickname").val(),
            msg: $("#chatting").val()
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
                // document.location.href = "/chat2/" + data;
                // 1번
            },
            error: function (request, status, error) { // 결과 에러 콜백함수
                console.log("error", error)
            }
        })

        console.log("option : ", option)
        ws.send(JSON.stringify(option))  //자바에서 handleTextMessage실행, 문자열로 보내야 서버에서 메세지를 받음
        $('#chatting').val("");
    }
</script>
</html>
<style>
    * {
        margin: 0;
        padding: 0;
    }

    .container {
        width: 1000px;
        margin: 0 auto;
        padding: 25px
    }

    .container h1 {
        text-align: left;
        padding: 5px 5px 5px 15px;
        color: #FFBB00;
        border-left: 3px solid #FFBB00;
        margin-bottom: 20px;
    }

    input {
        width: 330px;
        height: 25px;
    }
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
        position: relative;
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
        position: relative;
        margin-left: -12px;
        margin-top: 45px;
        background-color: #ddd;
    }
    /*.wrap .ch1 .textbox::before {*/
    /*    left: -12px;*/
    /*    top: -15px;*/
    /*    content: "↖";*/
    /*    font-weight: bolder;*/
    /*    color: #ddd;*/
    /*}*/

    .wrap .ch1 .textbox2 {
        /*padding: 10px;*/
        position: absolute;
        font-size: 13px;
        border-radius: 10px;
        background-color: #ddd;
        margin-left: 84px;
        margin-top: -23px;
    }


    .wrap .ch1 .yourTextboxDate {
        /*margin-left: 241px;*/
        margin-top: 87px;
        position: relative;
        font-size: 12px;
        color: #5b5555;
        padding-left: 14px;
    }
    .wrap .ch1 .textbox .yourTextboxDate::before {
        left: -12px;
        top: -15px;
        content: "↖";
        font-weight: bolder;
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
        /*right: -15px;*/
        /*content: "";*/
        /*content: "▶";*/
        /*color: #F9EB54;*/
    }
    .myTextboxDate {
        /*margin-right: 173px;*/
        margin-top: 42px;
        /*position: absolute;*/
        font-size: 12px;
        color: #5b5555;
    }
</style>