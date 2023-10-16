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
    <ul class="list-group">
        <c:forEach var="item" items="${acceptIsYRelationshipList}">
            <li class="list-group-item d-flex justify-content-between align-items-center">
                <div class="d-flex align-items-center mt-1 mb-1">
<%--                    <img class="img-fluid rounded-circle" src="${item.imgUrl}" alt="..." />--%>
                    <img class="img-fluid rounded-circle" src="https://dummyimage.com/50x50/ced4da/6c757d.jpg" alt="..." />
                    <div class="ms-3">
                        <div class="fw-bold">${item.nickname}</div>
                        <div class="fw-bold">${item.sendId}</div>
                        <div class="fw-bold">${item.getId}</div>
                    </div>
                </div>
                <div class="col-lg-9">
                    <div class="card-body">
                        <div class="d-flex">
                            <div class="ms-3">
                                <div class="fw-bold">Commenter Name</div>
                                <button class="btn btn-info" onclick="insertRoom(${item.sendId},${item.getId} )">대화시작하기</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="ms-3">
                    <div class="d-flex w-100 justify-content-end">
                        <span class="badge bg-primary rounded-pill">1</span>
                    </div>
                    <div class="d-flex w-100 justify-content-end">
                        <h5 class="mb-1"></h5>
                        <small>3 days ago</small>
                    </div>
                </div>
            </li>
        </c:forEach>
    </ul>
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
                document.location.href = "/chat2/" + data;
                // 1번
            },
            error : function(request, status, error) { // 결과 에러 콜백함수
                console.log("error", error)
            }
        })
    }

</script>