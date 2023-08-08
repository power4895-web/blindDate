<%--
  Created by IntelliJ IDEA.
  User: anjdu
  Date: 2023-06-20
  Time: 오후 12:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<script src="https://code.jquery.com/jquery-1.12.4.js"></script>--%>
<%--<script src="/static/js/jquery.form.js"></script>--%>
<script type="text/javascript" src="/static/js/jquery-2.2.4.js"></script>
<script type="text/javascript" src="/static/js/commonUtil.js"></script>
<%--수정합니다223--%>
<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <meta charset="UTF-8">
    <title>Chating</title>
    <style>
        *{
            margin:0;
            padding:0;
        }
        .container{
            width: 500px;
            margin: 0 auto;
            padding: 25px
        }
        .container h1{
            text-align: left;
            padding: 5px 5px 5px 15px;
            color: #FFBB00;
            border-left: 3px solid #FFBB00;
            margin-bottom: 20px;
        }
        .chating{
            background-color: #000;
            width: 500px;
            height: 500px;
            overflow: auto;
        }
        .chating .me{
            color: #F6F6F6;
            text-align: right;
        }
        .chating .others{
            color: #FFE400;
            text-align: left;
        }
        input{
            width: 330px;
            height: 25px;
        }
        #yourMsg{
            display: none;
        }
    </style>
</head>

<script type="text/javascript">
    var ws;

    function wsOpen(){
        console.log("wsOpen")
        ws = new WebSocket("ws://" + location.host + "/chating/"+$("#roomNumber").val());
        wsEvt();
    }

    function wsEvt() {
        console.log("wsEvt")
        ws.onopen = function(data){
            console.log("소켓이 열리면 동작")
            //소켓이 열리면 동작
        }

        ws.onmessage = function(data) {
            console.log("data", data)
            console.log("data.data", data.data)
            //메시지를 받으면 동작
            var msg = data.data;
            console.log("msg", msg);
            if(msg != null && msg.trim() != ''){
                var d = JSON.parse(msg);
                console.log("d", d)
                console.log("d.type", d.type)
                if(d.type == "getId"){
                    var si = d.sessionId != null ? d.sessionId : "";
                    if(si != ''){
                        $("#sessionId").val(si);
                    }
                }else if(d.type == "message"){
                    if(d.sessionId == $("#sessionId").val()){
                        $("#chating").append("<p class='me'>나 :" + d.msg + "</p>");
                    }else{
                        $("#chating").append("<p class='others'>" + d.userName + " :" + d.msg + "</p>");
                    }

                }else{
                    console.warn("unknown type!")
                }
            }
        }

        document.addEventListener("keypress", function(e){
            if(e.keyCode == 13){ //enter press
                send();
            }
        });
    }

    function chatName(){
        console.log("chatName")
        var userName = $("#userName").val();
        if(userName == null || userName.trim() == ""){
            alert("사용자 이름을 입력해주세요.");
            $("#userName").focus();
        }else{
            wsOpen();
            $("#yourName").hide();
            $("#yourMsg").show();
        }
    }

    function send() {
        console.log("send")
        var option ={
            type: "message",
            roomNumber: $("#roomNumber").val(),
            sessionId : $("#sessionId").val(),
            userName : $("#userName").val(),
            msg : $("#chatting").val()
        }
        ws.send(JSON.stringify(option))  //자바에서 handleTextMessage실행, 문자열로 보내야 서버에서 메세지를 받음
        $('#chatting').val("");
    }
</script>
<body>
<div id="container" class="container">
    <h1>${roomName}의 채팅방</h1>
    <input type="text" id="sessionId" value="">
    <input type="text" id="roomNumber" value="${roomNumber}">

    <div id="chating" class="chating">
    </div>

    <div id="yourName">
        <table class="inputTable">
            <tr>
                <th>사용자명</th>
                <th><input type="text" name="userName" id="userName"></th>
                <th><button onclick="chatName()" id="startBtn">이름 등록</button></th>
            </tr>
        </table>
    </div>
    <div id="yourMsg">
        <table class="inputTable">
            <tr>
                <th>메시지</th>
                <th><input id="chatting" placeholder="보내실 메시지를 입력하세요."></th>
                <th><button onclick="send()" id="sendBtn">보내기</button></th>
            </tr>
        </table>
    </div>
</div>
</body>
</html>

