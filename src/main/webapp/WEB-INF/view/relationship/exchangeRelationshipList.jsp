<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Modern Business - Start Bootstrap Template</title>
</head>
<body class="d-flex flex-column">
<main class="flex-shrink-0">
<c:forEach var="item" items="${exchangeRelationshipList}">
    <div class="list-group">
        <%--방이 존재하면 리스트 선택시 채팅방으로 , 없으면 아무일도 안일어난다--%>
        <c:if test="${item.roomYn == 'Y'}">
            <a href="#" class="list-group-item list-group-item-action" aria-current="true" onclick="insertRoom(${item.getId},${item.sendId} )">
        </c:if>
        <c:if test="${item.roomYn == 'N'}">
            <a href="#" class="list-group-item list-group-item-action" aria-current="true">
        </c:if>
            <span class="badge bg-primary rounded-pill">${item.readIsNotCount != 0 ? item.readIsNotCount : ''}</span>
            <div class="d-flex w-100 justify-content-between">
                <img class="img-fluid rounded-circle " src="${item.imgUrl}" alt="..." />
                <c:if test="${item.roomYn == 'Y'}">
                    <small >${item.lastMessage}</small>
                </c:if>
                <c:if test="${item.roomYn == 'N'}">
                    <button class="btn btn-info" onclick="insertRoom(${item.getId},${item.sendId} )">대화시작하기</button>
                </c:if>
                <c:set var="ymd" value="<%=new java.util.Date()%>" />
                <c:set var="dateDifference" value="${ymd.time - item.lastChatCreateDate.time}" />
                <c:choose>
                    <c:when test="${dateDifference ge 172800000}"> <!-- 2일 이상 차이 -->
                        <c:set var="result" value="2일 전" />
                    </c:when>
                    <c:when test="${dateDifference ge 259200000}"> <!-- 3일 이상 차이 -->
                        <c:set var="result" value="3일 전" />
                    </c:when>
                    <c:otherwise>
                        <c:set var="result" value="현재 또는 1일 이내" />
                    </c:otherwise>
                </c:choose>
                <small>${result}</small>
            </div>
            <strong class="mb-1">${item.nickname}</strong>
        </a>
    </div>
</c:forEach>
</main>
</body>
</html>
<script>

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

</script>