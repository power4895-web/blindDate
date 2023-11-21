<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
    <head>
        <meta charset="utf-8" />
        <title>Modern Business - Start Bootstrap Template</title>
    </head>
    <body class="d-flex flex-column">
        <main class="flex-shrink-0">
            <section class="bg-light py-5">
                <div class="container px-5 my-5">
                    <div class="text-center mb-5">
                        <div class="mb-1">
                            <h1 class="fw-bolder">chatList👫</h1>
                            <p class="lead fw-normal text-muted mb-0">Friends with a show of affection</p>
                        </div>
                    </div>
                    <div class="row gx-5 justify-content-center">
                        <c:forEach var="item" items="${exchangeRelationshipList}">
                            <div class="list-group">
                                    <%--방이 존재하면 리스트 선택시 채팅방으로 , 없으면 아무일도 안일어난다--%>
                                <a href="#" class="list-group-item list-group-item-action" aria-current="true">
                                    <span class="badge bg-primary rounded-pill">${item.readIsNotCount != 0 ? item.readIsNotCount : ''}</span>
                                    <div class="d-flex w-100 justify-content-between">
                                        <img class="img-fluid rounded-circle " src="${item.imgUrl}" alt="..." onclick="userView(${item.sendId})"/>
                                        <c:if test="${item.roomYn == 'Y'}">
                                            <small class="contentButton" data-get="${item.getId}" data-send="${item.sendId}">${item.lastMessage}</small>
                                        </c:if>

                                            <%--나간사람이 없고 룸아이디가 개설되지 않았을 때 (item.quitYn == 'Y' 면 상대방이 나간 상태)--%>
                                        <c:if test="${item.roomYn == 'N' && item.quitYn == 'N'}">
                                            <button class="btn btn-info" onclick="insertRoom(${item.getId},${item.sendId} )">대화시작하기</button>
                                        </c:if>

                                        <c:if test="${item.lastChatCreate != 0}">
                                            <small >${item.lastChatCreate}일전</small>
                                        </c:if>
                                        <c:if test="${item.hourValue != 0 && item.lastChatCreate == 0}">
                                            <small>${item.hourValue}시간 전</small>
                                        </c:if>
                                        <c:if test="${item.hourValue == 0 && item.minuteValue != 0}">
                                            <small>${item.minuteValue}분전</small>
                                        </c:if>
                                        <c:if test="${item.hourValue == 0 && item.minuteValue == 0 && item.secondValue != 0}">
                                            <small>${item.secondValue}초전</small>
                                        </c:if>
                                        <c:if test="${item.lastChatCreate == 0 && item.hourValue == 0 && item.minuteValue == 0 && item.secondValue == 0}">
                                            <small></small>
                                        </c:if>
                                    </div>
                                    <strong class="mb-1">${item.nickname}</strong>
                                </a>
                            </div>
                        </c:forEach>
                        <c:if test="${exchangeRelationshipList.size() == 0}">
                            <div class="list-group">
                                    <%--방이 존재하면 리스트 선택시 채팅방으로 , 없으면 아무일도 안일어난다--%>
                                <a href="#" class="list-group-item list-group-item-action" aria-current="true">
                                    <div class="d-flex w-100 justify-content-center">
                                        채팅이력이 없습니다. 친구해요를 먼저 보내세요.
                                    </div>
                                </a>
                        </c:if>
                        <c:if test="${exchangeRelationshipList.size() < 4}">
                            </div><br><br><br><br><br><br><br><br><br><br><br>
                        </c:if>
                    </div>
                </div>
            </section>
        </main>
    </body>
</html>
<script>

    $(document).ready(function () {

        //컨텐츠 class값으로 이벤트발생
        $(".contentButton").on("click", function () {
            var getId = $(this).data("get");
            var sendId = $(this).data("send");
            handleEvent(getId, sendId);
        })
        function handleEvent(getId, sendId) {
            insertRoom(getId,sendId)
        }
    })

    function insertRoom(roomBossId, roomStaffId) {


        console.log("roomBossId", roomBossId)
        console.log("roomStaffId", roomStaffId)
        const params = {
            roomBossId : roomBossId,
            roomStaffId : roomStaffId,
        }

        console.log("params", params)
        $.ajax({
            type : 'post',
            url : "/room/insert",
            data : params,
            success : function(data) { // 결과 성공 콜백함수
                console.log("data", data)
                document.location.href = "/chat/" + data;
                // 1번
            },
            error : function(request, status, error) { // 결과 에러 콜백함수
                console.log("error", error)
            }
        })
    }
    function userView(id){
        document.location.href = '/user/view/' + id;
    }

</script>