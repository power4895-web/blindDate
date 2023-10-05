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
                <h1 class="fw-bolder">Daily Profile</h1>
                <p class="lead fw-normal text-muted mb-0">Read the profile carefully and choose between the two</p>
            </div>
            <div class="row gx-5 justify-content-center">
                <c:forEach var="item" items="${dataList}" varStatus="dataStatus">
                    <div class="col-lg-6 col-xl-4">
                        <div class="card mb-5 mb-xl-0">
                            <div class="card-body p-0">
                                <%--슬라이드--%>
                                <div id="${dataStatus.index == 0 ? 'oneCarouselExampleIndicators' : 'secondCarouselExampleIndicators'}" class="carousel slide" data-bs-ride="false">
                                    <div class="carousel-indicators">
                                        <c:forEach var="file" items="${item.fileList}" varStatus="status">
                                            <button type="button" data-bs-target="#${dataStatus.index == 0 ? 'oneCarouselExampleIndicators' : 'secondCarouselExampleIndicators'}" data-bs-slide-to="${status.index}" class="${status.index == 0 ?  'active' : ''}" aria-current="${status.index == 0 ? true : ''}" aria-label="Slide ${status.count}"></button>
                                        </c:forEach>
                                    </div>
                                    <div class="carousel-inner">
                                        <c:forEach var="file" items="${item.fileList}" varStatus="status">
                                            <div class="carousel-item ${status.index == 0 ?  'active' : ''}">
                                                <div class="mb-3">
                                                    <img class="card-img-top" src="${file.filepath}${file.imageName}" alt="..." />
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                    <button class="carousel-control-prev" type="button" data-bs-target="#${dataStatus.index == 0 ? 'oneCarouselExampleIndicators' : 'secondCarouselExampleIndicators'}" data-bs-slide="prev">
                                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                        <span class="visually-hidden">Previous</span>
                                    </button>
                                    <button class="carousel-control-next" type="button" data-bs-target="#${dataStatus.index == 0 ? 'oneCarouselExampleIndicators' : 'secondCarouselExampleIndicators'}" data-bs-slide="next">
                                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                        <span class="visually-hidden">Next</span>
                                    </button>
                                </div>
                                <%--슬라이드끝--%>
                                <ul class="list-unstyled mb-4">
                                    <div class="small">
                                        <div class="fw-bold"><a href="/user/view/${item.id}">${item.nickname}, ${item.age}</a></div>
                                        <div class="text-muted">
                                                <i class="bi bi-geo-alt-fill"></i>
                                                ${item.distance == 0.0 ? '측정불가' : item.distance}${item.distance == 0.0 ? '' : 'km'},
                                                ${item.job}
                                        </div>
                                    </div>
                                </ul>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </section>
</main>
</body>
</html>
<script>

$(document).ready(function(){

})



</script>