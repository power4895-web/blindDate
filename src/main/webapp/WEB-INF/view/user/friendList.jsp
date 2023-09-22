<%--
  Created by IntelliJ IDEA.
  User: anjdu
  Date: 2023-08-01
  Time: 오후 3:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<sec:authentication var="info" property="principal" />
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
    <!-- Page content-->
    <section class="bg-light py-5">
        <div class="container px-5 my-5">
            <div class="text-center mb-5">
                <h1 class="fw-bolder">FriendList</h1>
                <p class="lead fw-normal text-muted mb-0">Friends with a show of affection</p>
            </div>

            <%--탭그리기--%>
            <ul class="nav nav-tabs justify-content-center" id="myTab" role="tablist" style="float :none;">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="pills-home-tab" onclick="sendExpression()" data-bs-toggle="pill" data-bs-target="#pills-home" type="button" role="tab" aria-controls="pills-home" aria-selected="true">보낸표현</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="pills-profile-tab" onclick="getExpression()" data-bs-toggle="pill" data-bs-target="#pills-profile" type="button" role="tab" aria-controls="pills-profile" aria-selected="false">받은표현</button>
                </li>
            </ul>

            <%--해시태그--%>
            <div class="d-grid gap-2 d-md-flex justify-content-md-center">
                <button type="button" class="btn btn-outline-success active" aria-pressed="true" data-bs-toggle="button" onclick="getFriendList()">친구해요</button>
                <button type="button" class="btn btn-outline-info" data-bs-toggle="button" onclick="getGrade()">호감</button>
            </div>


            <%--탭 내용 시작--%>
            <div class="tab-content" id="pills-tabContent">
                <%--첫번 째--%>
                <div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab" tabindex="0">
                    <div class="row gy-xl-5 justify-content">
                        <c:forEach var="item" items="${dataList}" varStatus="status">
                            <div class="col-lg-6 col-xl-4">
                                <div class="card mb-5 mb-xl-0">
                                    <div class="card-body p-5">
                                        <div class="mb-3">
                                            <img class="card-img-top" src="${item.imgUrl}" alt="..." />
                                        </div>
                                        <ul class="list-unstyled mb-4">
                                            <div class="small">
                                                <div class="fw-bold">${item.nickname}, ${item.age}</div>
                                                <div class="text-muted">${item.job},${item.purpose}</div>
                                            </div>
                                            <li class="mb-2">
                                                <i class="bi bi-check text-primary"></i>
                                                <strong>1 users</strong>
                                            </li>
                                            <li class="mb-2">
                                                <i class="bi bi-check text-primary"></i>
                                                5GB storage
                                            </li>
                                            <li class="mb-2">
                                                <i class="bi bi-check text-primary"></i>
                                                Unlimited public projects
                                            </li>
                                            <li class="mb-2">
                                                <i class="bi bi-check text-primary"></i>
                                                Community access
                                            </li>
                                            <li class="mb-2">
                                                <i class="bi bi-check text-primary"></i>
                                                Unlimited private projects
                                            </li>
                                            <li class="mb-2">
                                                <i class="bi bi-check text-primary"></i>
                                                Dedicated support
                                            </li>
                                            <li class="mb-2">
                                                <i class="bi bi-check text-primary"></i>
                                                Free linked domain
                                            </li>
                                            <li class="text-muted">
                                                <i class="bi bi-check text-primary"></i>
                                                Monthly status reports
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <%--두번 째--%>
                <div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab" tabindex="0">
                    <div class="row gx-5 justify-content-center">
                        <c:forEach var="item" items="${dataList}" varStatus="status">
                            <div class="col-lg-6 col-xl-4">
                                <div class="card mb-5 mb-xl-0">
                                    <div class="card-body p-5">
                                        <div class="mb-3">
                                            <img class="card-img-top" src="${item.imgUrl}" alt="..." />
                                        </div>
                                        <ul class="list-unstyled mb-4">
                                            <div class="small">
                                                <div class="fw-bold">${item.nickname}, ${item.age}</div>
                                                <div class="text-muted">${item.job},${item.purpose}</div>
                                            </div>
                                            <li class="mb-2">
                                                <i class="bi bi-check text-primary"></i>
                                                <strong>1 users</strong>
                                            </li>
                                            <li class="mb-2">
                                                <i class="bi bi-check text-primary"></i>
                                                5GB storage
                                            </li>
                                            <li class="mb-2">
                                                <i class="bi bi-check text-primary"></i>
                                                Unlimited public projects
                                            </li>
                                            <li class="mb-2">
                                                <i class="bi bi-check text-primary"></i>
                                                Community access
                                            </li>
                                            <li class="mb-2">
                                                <i class="bi bi-check text-primary"></i>
                                                Unlimited private projects
                                            </li>
                                            <li class="mb-2">
                                                <i class="bi bi-check text-primary"></i>
                                                Dedicated support
                                            </li>
                                            <li class="mb-2">
                                                <i class="bi bi-check text-primary"></i>
                                                Free linked domain
                                            </li>
                                            <li class="text-muted">
                                                <i class="bi bi-check text-primary"></i>
                                                Monthly status reports
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
            <%--탭 내용 끝--%>
        </div>
    </section>
</main>
</body>
</html>
<script>

    $(document).ready(function(){

    })


    function sendRelationship(id, obj) {
        let params = {
            getId : id
        }
        $.ajax({
            type : 'post',
            url : "/user/sendingRelationship",
            data : params,
            success : function(data) { // 결과 성공 콜백함수
                console.log("data", data)
                if(data == true) {
                    //이벤트제거
                    obj.attr('onclick', '').unbind('click');

                    //하트채우기, red로 변경
                    obj.children('i').attr('class','bi bi-heart-fill');
                    obj.children('i').css('color', 'red');
                    obj.css('backgroundColor', '#0d6efd');
                }

            },
            error : function(request, status, error) { // 결과 에러 콜백함수
                console.log("error", error)
            }
        });
    }


    function getFriendship() {
    }
    function getRelationship() {
    }

</script>