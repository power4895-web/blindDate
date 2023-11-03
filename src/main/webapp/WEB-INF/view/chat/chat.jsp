<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript" src="/static/js/jquery-2.2.4.js"></script>
<script type="text/javascript" src="/static/js/commonUtil.js"></script>
    <head>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="/static/css/chat-room.css">
        <link rel="stylesheet" href="/static/css/general.css">
    </head>

        <div id="chat-body">
            <input type="hidden" id="sessionId" value="">
            <input type="hidden" id="roomId" value="${roomId}">
            <input type="hidden" id="myNickname" value="${userInfo.nickname}" name="myNickname">
            <input type="hidden" id="yourNickname" value="${yourNickname}" name="yourNickname">
            <input type="hidden" value="${imgUrl}" id="imgUrl" > <%--상대방 이미지--%>
            <input type="hidden" value="${yourInfo.id}" id="yourId" >
            <input type="hidden" id="chatList" value="${chatList}" name="chatList">
            <input type="hidden" value="${chatLastList.createDate}" id="chatLastCreateDate" >
            <input type="hidden" value="${chatLastList.sessionId}" id="lastSessionId" >
            <input type="hidden" value="${userInfo.id}" id="userId" >
            <!-- 설정바(최소화, 닫기 버튼 등) -->
            <div class="setting_bar">
                <i class="bi bi-list"></i>
                <i class="bi bi-search"></i>
                <i class="bi bi-arrow-bar-right"></i>
<%--                <i class="bi bi-alarm"></i>--%>
    <%--            <i class="icon-window-minimize" alt="최소화버튼" title="최소화">s</i>--%>
    <%--            <i class="icon-window-maximize" alt="최대화버튼" title="최대화">s</i>--%>
    <%--            <i class="icon-cancel" alt="닫기버튼" title="닫기"></i>--%>
            </div>

            <!-- 알림, 메뉴 기능 -->
<%--            <div class="main-menu">--%>
<%--                <i class="bi bi-alarm"></i>--%>
<%--                <i class="icon-ellipsis" title="메뉴">메뉴</i>--%>
<%--            </div>--%>

            <!-- 프로필 사진, 프로필명 -->
            <header>
                <div class="header-col">
                    <i class="bi bi-arrow-left"  style="margin-right: 10px; cursor: pointer"></i>
                    <p class="profile-name">${yourInfo.nickname}</p>
                </div>
                <div class="col-md-8 offset-md-2" style="display: none" id="chatSearchId">
                    <div class="input-group mb-sm-2 m" >
                        <input type="text" class="form-control" placeholder="검색어를 입력해주세요" aria-label="Recipient's username" aria-describedby="inputGroup-sizing-sm" id="chatSearchContent">
                        <span class="input-group-text" id="basic-addon2" onclick="findAllChat();">찾기</span>
                    </div>
                </div>
            </header>
            <main>
                <!-- 고정된 공지사항 영역 -->
                <%--        <div class="notice-bar">--%>
                <%--            <i class="icon-bullhorn"></i>--%>
                <%--            <span>멘트를 고정해놓는 곳입니다.</span>--%>
                <%--            <i class="icon-down-open-big"></i>--%>
                <%--        </div>--%>
                <!-- 채팅 내용 시작 -->
                <div class="chat-content">
                    <!-- 채팅 내용 -->

                    <div class="main-chat" id="chating">
                        <c:if test="${yourInfo.imgUrl != null}">
                            <div class="profile-col">
                                <img class="profile-img" src="${yourInfo.imgUrl}">
                            </div>
                            <div class="profile-col">
                                <span class="profile-name ">안녕하세요. <br>저는 ${yourInfo.age}이고 ${yourInfo.addressDoro}에 살아요.</span>
                            </div><br><br>
                        </c:if>

                        <c:if test="${chatList != null}">
                            <c:forEach var="item" items="${chatList}" varStatus="status">
                                <!-- 메시지 시작 날짜 -->
                                <c:if test="${item.showCreateDate != null}">
                                    <div class="date-line">
                                        <fmt:formatDate  value="${item.showCreateDate}" pattern="yyyy년 MM월 dd일 E요일" />
                                    </div>
                                </c:if>

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
                                                <span class="balloon" style="position: relative; margin-left: 60px;">${item.content}</span>
                                            </div>
                                        </c:if>
                                        <c:if test="${chatList[status.index].toId != chatList[status.index -1].toId}">
                                            <%--이전에 받은 사람과 지금 받는사람이 다르다. > 내가 받고, 민지가 받은것이다 imgUrl있다.--%>
                                            <img class="profile-img" src="${imgUrl}" alt="익명">
                                            <div class="friend-chat-col">
                                                <span class="profile-name">${yourNickname}</span>
                                                <span class="balloon">${item.content}</span>
                                            </div>
                                        </c:if>
                                        <c:if test="${date1 != date2 && chatList[status.index].toId == chatList[status.index -1].toId}">
                                            <%--시간이 다르게 민지가 2번보낸것이다--%>
                                            <img class="profile-img" src="${imgUrl}" alt="익명">
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
                        <c:if test="${yourInfo.imgUrl == null}">
                            <div class="profile-col">
                                <span class="profile-name">상대방이 방을 나갔습니다.</span>
                            </div><br><br>
                        </c:if>
                        <!-- 채팅 입력창 -->
                    </div>

                    <div class="fade-lastChatBtn" >
                        <i class="bi bi-arrow-down-circle" style="background-color: white;font-size: 1.5rem;"></i>
                    </div>

                    <div class="fade-searchBtn" style="display: none">
                        <i class="bi bi-arrow-up-circle-fill"></i>
                        <i class="bi bi-arrow-down-circle-fill"></i>
                    </div>

                    <div class="insert-content">
                        <form name="chatform" id="chatform" >
                            <textarea name="chat-insert" id="chatInsert" ${yourInfo.id == null ? 'disabled' : ''}></textarea>
                            <button class="chat-submit" onclick="send()" id="sendBtn" ${yourInfo.id == null ? 'disabled' : ''}>
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                     class="bi bi-send-fill" viewBox="0 0 16 16">
                                    <path d="M15.964.686a.5.5 0 0 0-.65-.65L.767 5.855H.766l-.452.18a.5.5 0 0 0-.082.887l.41.26.001.002 4.995 3.178 3.178 4.995.002.002.26.41a.5.5 0 0 0 .886-.083l6-15Zm-1.833 1.89L6.637 10.07l-.215-.338a.5.5 0 0 0-.154-.154l-.338-.215 7.494-7.494 1.178-.471-.47 1.178Z"/>
                                </svg>
                            </button>
                        </form>
                        <!-- 채팅 입력 관련 기능(파일 첨부, 캡쳐 등) -->
                        <div class="insert-menu">
                            <i class="icon-smile">😀</i>
                            <i class="icon-attach">➕</i>
                            <i class="icon-phone">📞</i>
                            <i class="icon-calendar-empty">📆</i>
                            <i class="icon-camera">📷</i>
                        </div>
                    </div>
                </div>
            </main>
        </div>
<script type="text/javascript">
    let oldSesstionId = null;
    let fromId = null;
    let toId = null;
    let lastFromId = null;
    let lastToId = null;

    let chatLastTimeString = null;
    let chatLastCreateTimeString = null;
    let userId = $('#userId').val();
    let sendResult = false;
    const week = ['일', '월', '화', '수', '목', '금', '토'];

    let inputElement = $('#chatSearchContent');//검색엔터

    $(document).ready(function () {

        if($('#yourId').val() == '') {
            alert("상대방이 방을 나갔습니다. 메세지를 할 수 없습니다.")
        }

        // 검색엔터
        searchEnter();

        // $('.fade-searchBtn').css("opacity", "0");//가장마지막아래 버튼 안보이게

        //스크롤 가장 아래로 이동
        // $('.chat-content').scrollTop($('.chat-content')[0].scrollHeight);
        window.scrollTo(0, document.body.scrollHeight);

        //스크롤 이벤트 발생
        $(window).scroll(function() {
            //발생시 가장아래로 가는 버튼 보이게
            $('.fade-lastChatBtn').css("opacity", "1");
            var documentHeight = $(document).height();
            var windowHeight = $(window).innerHeight();
            var scrollPosition = $(window).scrollTop();
            var test = Math.ceil(scrollPosition + windowHeight);

            // console.log("windowHeight : ", windowHeight);
            // console.log("scrollPosition : ", scrollPosition);
            // console.log("windowHeight + scrollPosition : ", windowHeight + scrollPosition);
            // console.log("test : ", test);
            // console.log("documentHeight : ", documentHeight);

            // 스크롤 위치가 맨 아래에 도달했을 때 이벤트를 발생
            if (test >= documentHeight) {
                // 맨 아래로 스크롤될 때 실행할 이벤트를 여기에 추가
                console.log("맨 아래로 스크롤되었습니다.");
                //맨 아래 갔을 때 안보이게
                $('.fade-lastChatBtn').css("opacity", "0");
            }
        });


        //뒤로가기
        back();

        //lastsession아이디 세팅
        if($('#lastSessionId').val() != '') {
            oldSesstionId = $('#lastSessionId').val();
        }
        //라스트채팅날짜 세팅
        if($('#chatLastCreateDate').val() != '') {
            var dateTime = com.fromDateToString($('#chatLastCreateDate').val());
            var oldHours = dateTime.hour; // 시간
            var oldMinute = dateTime.minute; // 분

            if(oldTime == null) {
                oldTime = oldMinute + ':' + oldMinute
            }
            chatLastCreateTimeString = dateTime.year + dateTime.month + dateTime.day;
        }
        // console.log("과거 채팅 시간 24시간 형식: ", oldTime);

        //읽음처리
        updateChat();

        // 하단 스크롤 이동 버튼

        $('.fade-lastChatBtn').click(function(e){
            window.scrollTo(0, document.body.scrollHeight);
        });

        //돋보기 버튼 검색
        chatSearchBtn();
        //위검색
        upSearchBtn();
        //아래검색
        downSearchBtn();
        quitRoom();


        //form안날라가게(카카오 css때문에 어쩔수 없이 form을 사용해야함
        const chatform = document.chatform
        chatform.addEventListener("submit", (event) => {
            // 동작(이벤트)을 실행하지 못하게 막는 메서드입니다.
            event.preventDefault();
        });

        //상대방 이미지가 있으면 소캣연결
        if($('#yourId').val() != '') {
            chatName()
        }
    })


    var ws;

    function wsOpen() {
        // console.log("wsOpen")
        // console.log("wsOpen", location.host)
        // console.log("roomId", $("#roomId").val())
        ws = new WebSocket("ws://" + location.host + "/chating/" + $("#roomId").val());
        wsEvt();
    }

    let oldTime = null;
    function wsEvt() {
        // console.log("wsEvt")
        ws.onopen = function (data) {
            // console.log("소켓이 열리면 동작")
            // console.log("data", data)
            //소켓이 열리면 동작
        }

        ws.onmessage = async function (data) {
            // console.log("data", data)
            // console.log("data.data", data.data)
            //메시지를 받으면 동작
            var msg = data.data;
            var d = JSON.parse(msg); //보낼 땐 문자열로 보냈고, 받을 땐 json오브젝트를 자바스크립트 오브젝트로 변환
            // console.log("d", d)
            // console.log("d.readYn", d.readYn)
            // console.log("d.type", d.type)
            // console.log("d.msg", d.msg)
            // console.log("메세지를 보낸 사람의 세션 아이디: ", d.sessionId);
            // console.log("현재 채팅페이지의 세션 아이디: ", $("#sessionId").val());
            // console.log("마지막 채팅자의 세션 아이디: ", $("#lastSessionId").val());
            // console.log("oldSesstionId: ", oldSesstionId);
            if (d.type == "getId") {
                var si = d.sessionId != null ? d.sessionId : "";
                if (si != '') {
                    $("#sessionId").val(si);
                }
            } else if (d.type == "message") {

                let yourNickname = $('#yourNickname').val(); //사용
                let imgUrl = $('#imgUrl').val(); //사용
                let today = new Date();

                let nowDateTime= today.getFullYear() + today.getMonth() + 1 + today.getDate();
                let nowDateTimeString = today.getFullYear() + "년 " + (today.getMonth() + 1) + "월 " + today.getDate() + "일 " + week[today.getDay()] + "요일";
                console.log("현재 채팅보내는 년, 월, 일", nowDateTime);
                console.log("마지막 채팅보내는 년, 월, 일", chatLastCreateTimeString);

                if(chatLastCreateTimeString != nowDateTime) {

                    $("#chating").append(
                        `<div class='friend-chat'>
                                <div class="date-line">
                                    \${nowDateTimeString}
                                </div>
                             </div>`
                    );

                    console.log("마지막 채팅시간과 현재날짜의 하루 이상이 지났기 때문에 날짜 보여줘야 한다.")
                }

                var twentyFourHours = today.getHours();
                var ampm = twentyFourHours >= 12 ? '오후' : '오전';

                twelveHours = twentyFourHours % 12; //12시간 형식으로
                twelveHours = twelveHours != 0 ? twelveHours : 12; // 0 시간일 때 12로 표시
                let minutes = ('0' + today.getMinutes()).slice(-2);


                let now24TimeString = twentyFourHours + ':' + minutes; //24:00
                let now12TimeString = twelveHours + ':' + minutes; //12:00
                // console.log("현재 채팅하는 12형식 시간 : ", now12TimeString);
                d.readYn = d.readYn == "N" ? 1 : "";

                await getLastChatTime($('#roomId').val());

                console.log("lastFromId", lastFromId)
                console.log("userId", userId)
                console.log("fromId", fromId)
                console.log("toId", toId)
                console.log("now24TimeString", now24TimeString)
                console.log("chatLastTimeString : ", chatLastTimeString)



                if(sendResult == true) {
                    console.log("============================================보낸다.========================================")
                    if(lastFromId != null) {
                        console.log("이전에 보낸 채팅이력이 있다.")
                        if(fromId == lastFromId) {
                            console.log("내가 나에게 연속으로 채팅")
                            if(now24TimeString == chatLastTimeString) {
                                $("#chating").append(
                                    `<div class='me-chat'>
                                            <div class=me-chat-col>
                                                <span class=balloon>\${d.msg}</span>
                                            </div>
                                            <p class=readYn >\${d.readYn}</p>
                                        </div>`
                                )
                            } else {
                                $("#chating").append(
                                    `<div class='me-chat'>
                                            <div class=me-chat-col>
                                                <span class=balloon>\${d.msg}</span>
                                            </div>
                                            <p class=readYn >\${d.readYn}</p>
                                            <time datetime="07:32:00+09:00">
                                                \${now24TimeString == chatLastTimeString ? '' :ampm +  " " + now12TimeString}
                                            </time>
                                        </div>`
                                )
                            }
                        } else {
                            console.log("상대방이 보낸 다음 내가 보낸 것 ")
                            $("#chating").append(
                                `<div class='me-chat'>
                                        <div class=me-chat-col>
                                            <span class=balloon>\${d.msg}</span>
                                        </div>
                                        <p class=readYn >\${d.readYn}</p>
                                        <time datetime="07:32:00+09:00">
                                            \${ampm +  " " + now24TimeString}
                                        </time>
                                 </div>`
                            )
                        }
                    } else {
                        console.log("채팅을 처음 보낸다.")
                        if(userId == fromId && oldTime == now24TimeString) {
                            console.log("내가 나에게 보낸다.")
                            $("#chating").append(
                                `<div class='me-chat'>
                                        <div class=me-chat-col>
                                            <span class=balloon>\${d.msg}</span>
                                        </div>
                                        <p class=readYn >\${d.readYn}</p>
                                    </div>`
                            )
                        }
                        if(userId == fromId && oldTime != now24TimeString) {
                            console.log("내가 나에게 보낸다.")
                            $("#chating").append(
                                `<div class='me-chat'>
                                        <div class=me-chat-col>
                                            <span class=balloon>\${d.msg}</span>
                                        </div>
                                        <p class=readYn >\${d.readYn}</p>
                                        <time datetime="07:32:00+09:00">
                                            \${now24TimeString == chatLastTimeString ? '' :ampm +  " " + now12TimeString}
                                        </time>
                                    </div>`
                            )
                        }
                    }

                } else {
                    //채팅을 받는 입장
                    console.log("============================================받는다========================================")

                    //시간이 같을 때
                    console.log("lastFromId : ",lastFromId)
                    console.log("fromId : ",fromId)
                    console.log("userId : ",userId)
                    console.log("chatLastTimeString : ",chatLastTimeString)
                    console.log("now24TimeString : ",now24TimeString)
                    console.log("oldTime : ",oldTime)
                    if(lastFromId != fromId && oldTime == now24TimeString) {
                        console.log("이전에 내가 보냈고, 상대방으로부터 받았는데 시간이 같을 때")
                        $("#chating").append(
                            `<div class='friend-chat'>
                                    <img class="profile-img" src="\${imgUrl}" alt="쀼프로필사진">
                                    <div class="friend-chat-col">
                                        <span class="profile-name">\${yourNickname}</span>
                                        <span class="balloon">\${d.msg}</span>
                                    </div>
                                    <time datetime="07:32:00+09:00">
                                        \${ampm +  " " + now12TimeString}
                                    </time>
                             </div>`
                        );
                    }
                    if(lastFromId != fromId && oldTime != now24TimeString) {
                        console.log("이전에 내가 보냈고, 상대방으로부터 받았는데 시간이 다를 때")
                        $("#chating").append(
                            `<div class='friend-chat'>
                                <img class="profile-img" src="\${imgUrl}" alt="쀼프로필사진">
                                <div class="friend-chat-col">
                                    <span class="profile-name">\${yourNickname}</span>
                                    <span class="balloon">\${d.msg}</span>
                                </div>
                                <time datetime="07:32:00+09:00">
                                    \${ampm +  " " + now12TimeString}
                                </time>
                             </div>`
                        );
                    }
                    if(lastFromId == fromId && oldTime == now24TimeString) {
                        console.log("상대방이 여러번 보내는데 같은 시간")
                        $("#chating").append(
                            `<div class='friend-chat'>
                                    <div class="friend-chat-col">
                                        <span class="balloon" style="position: relative; margin-left: 60px;">\${d.msg}</span>
                                    </div>
                                    <time datetime="07:32:00+09:00">
                                        \${now24TimeString == chatLastTimeString ? '' :ampm +  " " + now12TimeString}
                                    </time>
                             </div>`
                        );
                    }
                    if(lastFromId == fromId && oldTime != now24TimeString) {
                        console.log("상대방이 여러번 보내는데 시간이 다른 시간")
                        $("#chating").append(
                            `<div class='friend-chat'>
                                <img class="profile-img" src="\${imgUrl}" alt="쀼프로필사진">
                                <div class="friend-chat-col">
                                    <span class="profile-name">\${yourNickname}</span>
                                    <span class="balloon">\${d.msg}</span>
                                </div>
                                <time datetime="07:32:00+09:00">
                                    \${ampm +  " " + now12TimeString}
                                </time>
                             </div>`
                        );
                    }
                }

                oldTime = now24TimeString  //비교를 위해 과거 시간 저장 24시간 형식
                oldSesstionId = d.sessionId

            } else if(d.type == "online") {
                console.log("online", "읽음처리 다 없애기")
                $('.readYn').remove();
            } else {
                console.warn("unknown type!")
            }
            // 송신, 또는 수신시 맨 아래로 이동
            window.scrollTo(0, document.body.scrollHeight);
            sendResult = false
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
        // $("#yourMsg").show();
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

    async function send() {
        if($("#chatInsert").val().trim() == '') {
            return;
        }
        var option = {
            type: "message",
            roomId: $("#roomId").val(),
            sessionId: $("#sessionId").val(),
            nickname: $("#myNickname").val(),
            msg: $("#chatInsert").val()
        }
        var params = {
            'content': option.msg,
            'roomId': option.roomId,
            'sessionId': option.sessionId,
        }
        await chatInsertAjax(params);

        console.log("option : ", option)
        ws.send(JSON.stringify(option))  //자바에서 handleTextMessage실행, 문자열로 보내야 서버에서 메세지를 받음
        $('#chatInsert').val("");
    }


    function chatInsertAjax(params) {
        console.log("chatInsertAjax");
        // console.log("params", params);
        return new Promise(function(resolve, reject){ // promise 정의
            $.ajax({
                type : 'post',
                url: "/chat/insert",
                async: true, //비동기 여부
                data: params,
                timeout: 10000, //타임 아웃 설정 (1000 = 1초)
                dataType: "JSON", //응답받을 데이터 타입 (XML,JSON,TEXT,HTML,JSONP)
                contentType: `application/x-www-form-urlencoded`,  //디폴트
                // contentType: "application/json; charset=utf-8", //헤더의 Content-Type을 설정
                success : function(data) { // 결과 성공 콜백함수
                    resolve(data);
                    // console.log("chat_data_ ", data.id)
                    // console.log("chat_data_ ", data.createDate)
                    fromId = data.fromId;
                    toId = data.toId;
                    sendResult = true;
                },
                error: function (request, status, error) { // 결과 에러 콜백함수
                    console.log("error", error)
                    reject(error);
                }
            });
        });
    };

    async function getLastChatTime(roomId) {
        console.log("getLastChatTime")
        return new Promise(function(resolve, reject){ // promise 정의
            $.ajax({
                type : 'get',
                url : "/lastChatTime/" + roomId,
                async: true, //비동기 여부
                timeout: 10000, //타임 아웃 설정 (1000 = 1초)
                dataType: "JSON", //응답받을 데이터 타입 (XML,JSON,TEXT,HTML,JSONP)
                contentType: "application/json; charset=utf-8", //헤더의 Content-Type을 설정
                success : function(data) { // 결과 성공 콜백함수
                    resolve(data);
                    console.log("getLastChatTime : ", data)
                    if(data != null) {
                        lastFromId = data.lastFromId;
                        fromId = data.fromId;
                        lastToId = data.toId;
                        let lastLastCreateDate = new Date(data.lastCreateDate);
                        let lastCreateDate = new Date(data.createDate);
                        let minutes = (lastLastCreateDate.getMinutes() < 10) ? '0' + lastLastCreateDate.getMinutes() : lastLastCreateDate.getMinutes();
                        chatLastTimeString = lastLastCreateDate.getHours() + ':' + minutes;

                        chatLastCreateTimeString = lastCreateDate.getFullYear() + lastCreateDate.getMonth() + 1 + lastCreateDate.getDate();
                        console.log("chatLastCreateTimeString", chatLastCreateTimeString);
                    }
                },
                error: function (request, status, error) { // 결과 에러 콜백함수
                    console.log("error", error)
                    reject(error);
                }
            });
        });
    };
    var elements = document.querySelectorAll('.balloon');
    var currentIndex = elements.length - 1;
    var currentIndex2 = 0;
    var oldCurrentIndex = 0;    //이전index번호
    var searchString = "";  //현재검색어
    var oldSearchString  = "";  //이전검색어


    //찾기 검색버튼
    function findAllChat() {
        currentIndex = elements.length - 1;

        // 사용자가 입력한 검색어 가져오기
        searchString = $('#chatSearchContent').val();

        if(searchString.trim() == '' ) {
            alert('검색어를 입력해주세요.')
            return;
        }

        if(oldSearchString == searchString) {
            alert('검색어가 같습니다. oldCurrentIndex-1을 해줍니다.')
            oldCurrentIndex = oldCurrentIndex-1
        } else {
            alert('검색어가 다릅니다. 처음으로 되돌립니다.')
            //다시 find할 때 색깔 원래대로
            chatContentReset();
        }




        //검색대상 전체 하이라이트 입히기
        for (var i = currentIndex2; i < elements.length; i++) {
            var text = elements[i].textContent;
            if (text.includes(searchString)) {
                elements[i].style.backgroundColor = 'yellow';
            }
        }

        // 검색한 단어를 가진 요소 찾기(아래에서 위로)
        showNextMatch();
        oldSearchString = searchString;
    }

    let upDownResult = null;
    //위로 검색
    function showNextMatch() {
        // 찾은 요소들을 보여주고 스크롤, 노란색으로 표시
        console.log("=================위에 버튼========================")

        if(upDownResult == false && currentIndex != elements.length - 1) {
            console.log("이전에 down을 누른 상태 > 그러므로 -2를 해줘야")
            currentIndex = currentIndex-2;
        } else {
            console.log("이전에 down 누른 상태 > 그러므로 -1을 할 필요없다.")
        }
        console.log("upDownResult",upDownResult);
        if(upDownResult == false && currentIndex == elements.length - 1) {
            console.log("이전에 down을 누른 상태이면서 가장 아래부분인상태, 그러므로 -1을 해줘야")
            currentIndex = currentIndex-1;
        }

        console.log("currentIndex : ", currentIndex)

        for (var i = currentIndex; i >= 0; i--) {
            var text = elements[i].textContent;
            console.log(">>text", text);
            if (text.includes(searchString)) {
                // console.log("찾고자 하는 검색어 : ", text)
                // console.log("i : ", i)
                // console.log("oldCurrentIndex : ", oldCurrentIndex)
                //header때문에 안보이기 때문에 좀 더 높게 보이게끔, 0,1,2는 맨위로, 나머지는 -3을 해서 더 위로
                if(i == 0 || i == 1 || i == 2 ) {
                    window.scrollTo(0, 0); //가장위로
                } else {
                    elements[i-3].scrollIntoView({ behavior: 'auto' });
                }

                elements[i].classList.add("shaking");
                elements[oldCurrentIndex].classList.remove("shaking");

                currentIndex = i - 1;
                oldCurrentIndex = i;
                console.log("===============이벤트 끝================")
                console.log("currentIndex", currentIndex)
                console.log("oldCurrentIndex", oldCurrentIndex)
                upDownResult = true;
                return;
            } else {
                upDownResult = '';
            }
        }
        if(upDownResult == '') {
            alert("검색어가 존재하지 않습니다.")
            //모든 흔들기효과를 지웁니다.
            elements.forEach(function(element) {
                element.classList.remove('shake-effect'); // "shake-effect" 클래스를 제거
            });
        }


    }
    //아래로 하이라이트와 흔들기
    function showPreviousMatch() {
        console.log("===============아래버튼===================")
        console.log("currentIndex", currentIndex)

        if(currentIndex == oldCurrentIndex) {
            console.log("가장 아래에서 아래를 눌렀기 때문에 검색할게 없다.")
            return;
        }

        // 찾은 요소들을 보여주고 스크롤, 노란색으로 표시
        if(upDownResult == true && currentIndex != elements.length - 1) {
            console.log("이전에 up을 누른 상태 > 그러므로 +2를 해줘야")
            currentIndex = currentIndex + 2;
        } else {
            console.log("이전에 down 누른 상태 > 그러므로 +1을 할 필요없다.")
        }
        console.log("currentIndex : ", currentIndex)

        if(upDownResult == true && currentIndex < 0) {
            //가장 맨 위에서 아래를 눌렀을 경우,
            console.log("가장 맨 위에서 아래를 눌렀을 경우")
            currentIndex = 0;
        }


        for (var i = currentIndex; i >= 0; i++) {
            console.log(">>>>>>>>>>>>>>i", i)
            console.log(">>>>>>>>>>>>>>elements[i]", elements[i])
            if(elements[i] != undefined) {
                var text = elements[i].textContent;
                if (text.includes(searchString)) {
                    console.log("text", text)
                    console.log("i", i)
                    console.log("oldCurrentIndex : ", oldCurrentIndex)

                    if(i == 0 || i == 1 || i == 2 ) {
                        window.scrollTo(0, 0); //가장위로
                    } else {
                        elements[i-3].scrollIntoView({ behavior: 'auto' });
                    }


                    // if(i == elements.length - 1 || i == elements.length - 2 || i == elements.length - 3 ) {
                    //     window.scrollTo(0, document.body.scrollHeight);
                    // } else {
                    //     alert(1)
                    //     elements[i-3].scrollIntoView({ behavior: 'auto' });
                    // }

                    elements[i].classList.add("shaking");
                    elements[oldCurrentIndex].classList.remove("shaking");

                    if(i == elements.length - 1) {
                        console.log("가장 맨 아래이다.")
                        // oldCurrentIndex = i-1;
                        // currentIndex = i - 1;
                        oldCurrentIndex = i;
                    } else {
                        currentIndex = i + 1;
                        oldCurrentIndex = i;
                    }

                    console.log("===============이벤트 끝================")
                    console.log("currentIndex", currentIndex)
                    console.log("oldCurrentIndex", oldCurrentIndex)
                    upDownResult = false;
                    return;
                }
            } else {
                console.log("검색할게 더이상 없다.")
                return;
            }

        }
    }

    // 뒤로가기 버튼
    function back() {
        $(".bi-arrow-left").on("click", function () {
            if ($(".fade-searchBtn").css("display") == "none") {
                // alert("요소는 현재 숨겨져 있습니다.");
                history.back();

            } else {
                // alert("요소는 현재 보여집니다.");
                $('.fade-searchBtn').hide();
                $('#chatSearchId').hide();
                $('.insert-content').show();

                chatContentReset();



            }
        })
    }

    //돋보기검색
    function chatSearchBtn() {
        $('.bi-search').click(function(e){
            $('#chatSearchId').show();
            $('.fade-searchBtn').show();
            $('.insert-content').hide();
            $('#chatSearchContent').focus();
        });
    }
    //낙가기
    function quitRoom() {
        let params = {
            id : $('#roomId').val(),
            userId : $('#userId').val(),
            yourId : $('#yourId').val() != '' ? $('#yourId').val() : 0
        }
        $('.bi-arrow-bar-right').click(function(e){
            $.ajax({
                type: 'post',
                url: "/room/quit",
                data: params,
                success: function (data) { // 결과 성공 콜백함수
                    console.log("data", data)
                    if(data) {
                        history.back();
                    }
                },
                error: function (request, status, error) { // 결과 에러 콜백함수
                    console.log("error", error)
                }
            })
        });
    }

    //위검색
    function upSearchBtn() {
        $('.bi-arrow-up-circle-fill').click(function(e){
            showNextMatch();
        });
    }
    //아래검색
    function downSearchBtn() {
        $('.bi-arrow-down-circle-fill').click(function(e){
            showPreviousMatch();
        });
    }
    //흔들기제거, 색상 deafult
    function chatContentReset() {
        let className;
        for (var i = currentIndex2; i < elements.length; i++) {
            className = elements[i].closest("div").className;
            if(className == 'me-chat-col') {
                elements[i].style.backgroundColor = 'rgb(94, 122, 100)';
            }
            if(className == 'friend-chat-col') {
                elements[i].style.backgroundColor = 'rgb(228, 233, 230)';
            }
        }
        elements.forEach(function(element) {
            element.classList.remove('shaking'); // "shake-effect" 클래스를 제거
        });
    }

    //검색엔터
    function searchEnter() {
        // <input> 요소에 대한 keydown 이벤트 핸들러 등록
        inputElement.on('keydown', function(event) {
            if (event.which === 13) { // 13은 Enter 키의 key code입니다.
                // Enter 키를 눌렀을 때 실행할 코드 또는 이벤트를 여기에 작성
                findAllChat();
            }
        });
    }


</script>
<style>
    @keyframes shake {
        0% { transform: translateX(0); }
        25% { transform: translateX(-5px) rotate(5deg); }
        50% { transform: translateX(5px) rotate(-5deg); }
        75% { transform: translateX(-5px) rotate(5deg); }
        100% { transform: translateX(0); }
    }

    .shaking {
        animation: shake 0.5s infinite;
        display: inline-block; /* 요소가 인라인 블록으로 표시되도록 설정 */
    }
</style>