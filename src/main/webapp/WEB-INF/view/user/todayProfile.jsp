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
                <h1 class="fw-bolder">Daily Profilee</h1>
                <p class="lead fw-normal text-muted mb-0">Read the profile carefully and choose between the two</p>
            </div>
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
                                <div class="d-grid">
                                    <c:if test="${item.sendYn == 'N'}">
                                        <a id="item_${status.index}" class="btn btn-outline-primary"  onclick="sendRelationship(${item.id},$(this))" href="#!">
                                            <i class="bi bi-heart"></i>
                                        </a>
                                    </c:if>
                                    <c:if test="${item.sendYn == 'Y'}">
                                        <a id="item_${status.index}" class="btn btn-outline-primary" style="background-color: #0d6efd" href="#!">
                                            <i class="bi bi-heart-fill" style="color: red"></i>
                                        </a>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>

                <%--                        슬라이드--%>
                <%--                        <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">--%>
                <%--                            <div class="carousel-indicators">--%>
                <%--                                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>--%>
                <%--                                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>--%>
                <%--                                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>--%>
                <%--                            </div>--%>
                <%--                            <div class="carousel-inner">--%>
                <%--                                <div class="carousel-item active">--%>
                <%--                                    <img class="d-block w-100" src="https://source.unsplash.com/user/erondu/1600x900" alt="..." />--%>
                <%--                                </div>--%>
                <%--                                <div class="carousel-item">--%>
                <%--                                    <img class="d-block w-100" src="https://source.unsplash.com/collection/190727/1600x900" alt="..." />--%>
                <%--                                </div>--%>
                <%--                                <div class="carousel-item">--%>
                <%--                                    <img class="d-block w-100" src="https://source.unsplash.com/WLUHO9A_xik/1600x900" alt="..." />--%>
                <%--                                </div>--%>
                <%--                            </div>--%>
                <%--                            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">--%>
                <%--                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>--%>
                <%--                                <span class="visually-hidden">Previous</span>--%>
                <%--                            </button>--%>
                <%--                            <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">--%>
                <%--                                <span class="carousel-control-next-icon" aria-hidden="true"></span>--%>
                <%--                                <span class="visually-hidden">Next</span>--%>
                <%--                            </button>--%>
                <%--                        </div>--%>

            </div>
        </div>
        </div>
    </section>
    <a class="btn btn-outline-primary" id="test" style="color:#0d6efd" href="#!">ddd</a>
</main>
<div>
    <div>

    </div>

</div>
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


</script>