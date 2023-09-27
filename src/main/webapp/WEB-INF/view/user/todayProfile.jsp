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
                            <div class="card-body p-0">
                                <div class="mb-3">
                                    <img class="card-img-top" src="${item.imgUrl}" alt="..." />
                                </div>
                                <ul class="list-unstyled mb-4">
                                    <div class="small">
                                        <div class="fw-bold"><a href="/user/view/${item.id}">${item.nickname}, ${item.age}</a></div>
                                        <div class="text-muted">${item.job},${item.purpose}</div>
                                    </div>
                                    <li class="mb-2">
                                        <i class="bi bi-check text-primary"></i>
                                        <label>직업: </label>
                                        <label>${item.job}</label>
                                    </li>
                                    <li class="mb-2">
                                        <i class="bi bi-check text-primary"></i>
                                        <label>직장: </label>
                                        <label>${item.workplace}</label>
                                    </li>
                                    <li class="mb-2">
                                        <i class="bi bi-check text-primary"></i>
                                        <label>학력: </label>
                                        <label>${item.academic}</label>
                                    </li>
                                    <li class="mb-2">
                                        <i class="bi bi-check text-primary"></i>
                                        <label>체형: </label>
                                        <label>${item.bodyType}</label>
                                    </li>
                                    <li class="mb-2">
                                        <i class="bi bi-check text-primary"></i>
                                        <label>성격: </label>
                                        <label>${item.personality}</label>
                                    </li>
                                    <li class="mb-2">
                                        <i class="bi bi-check text-primary"></i>
                                        <label>MBTI: </label>
                                        <label>${item.mbti}</label>
                                    </li>
                                    <li class="mb-2">
                                        <i class="bi bi-check text-primary"></i>
                                        <label>흡연: </label>
                                        <label>${item.smokingYn}</label>
                                    </li>
                                    <li class="mb-2">
                                        <i class="bi bi-check text-primary"></i>
                                        <label>음주: </label>
                                        <label>${item.drinkingType}</label>
                                    </li>
                                    <li class="mb-2">
                                        <i class="bi bi-check text-primary"></i>
                                        <label>종교: </label>
                                        <label>${item.religionType}</label>
                                    </li>
                                </ul>
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



</script>