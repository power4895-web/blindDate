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
            <section class="bg-light py-5">
                <div class="container px-5 my-5">
                    <div class="text-center mb-5">
                        <h1 class="fw-bolder">theMoreUserList <i class="bi bi-people" style="color: #005bd4"></i></h1>
                        <p class="lead fw-normal text-muted mb-0">Friends with a show of affection</p>
                    </div>
                    <div class="row gy-xl-5 justify-content" >
                        <c:forEach var="item" items="${theMoreUserList}" varStatus="dataStatus" >
                            <div class="col-lg-6 col-xl-4">
                                <div class="card mb-5 mb-xl-0">
                                    <div class="card-header">
                                        <button type="button" class="btn-close" style="float: right;" aria-label="Close" onclick="deleteUserIds(${item.id}, this)"></button>
                                    </div>
                                    <div class="card-body p-0">
                                            <%--슬라이드--%>
                                        <div id="${dataStatus.index == 0 ? 'oneCarouselExampleIndicators'
                                        : dataStatus.index == 1 ? 'secondCarouselExampleIndicators'
                                        : dataStatus.index == 2 ? 'thirdCarouselExampleIndicators'
                                        : dataStatus.index == 3 ? 'fourthCarouselExampleIndicators'
                                        : dataStatus.index == 4 ? 'fifthCarouselExampleIndicators'
                                        : dataStatus.index == 5 ? 'sixthCarouselExampleIndicators'
                                        : dataStatus.index == 6 ? 'seventhCarouselExampleIndicators'
                                        : dataStatus.index == 7 ? 'eighthCarouselExampleIndicators'
                                        : dataStatus.index == 8 ? 'ninthCarouselExampleIndicators'
                                        : dataStatus.index == 9 ? 'tenthCarouselExampleIndicators'
                                        : ''}" class="carousel slide" data-bs-ride="false">
                                            <div class="carousel-indicators">
                                                <c:forEach var="file" items="${item.fileList}" varStatus="status">
                                                    <button type="button" data-bs-target="#${dataStatus.index == 0 ? 'oneCarouselExampleIndicators'
                                                    : dataStatus.index == 1 ? 'secondCarouselExampleIndicators'
                                                    : dataStatus.index == 2 ? 'thirdCarouselExampleIndicators'
                                                    : dataStatus.index == 3 ? 'fourthCarouselExampleIndicators'
                                                    : dataStatus.index == 4 ? 'fifthCarouselExampleIndicators'
                                                    : dataStatus.index == 5 ? 'sixthCarouselExampleIndicators'
                                                    : dataStatus.index == 6 ? 'seventhCarouselExampleIndicators'
                                                    : dataStatus.index == 7 ? 'eighthCarouselExampleIndicators'
                                                    : dataStatus.index == 8 ? 'ninthCarouselExampleIndicators'
                                                    : dataStatus.index == 9 ? 'tenthCarouselExampleIndicators'
                                                    : ''}" data-bs-slide-to="${status.index}" class="${status.index == 0 ?  'active' : ''}" aria-current="${status.index == 0 ? true : ''}" aria-label="Slide ${status.count}">
                                                    </button>
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
                                            <button class="carousel-control-prev" type="button" data-bs-target="#${dataStatus.index == 0 ? 'oneCarouselExampleIndicators'
                                            : dataStatus.index == 1 ? 'secondCarouselExampleIndicators'
                                            : dataStatus.index == 2 ? 'thirdCarouselExampleIndicators'
                                            : dataStatus.index == 3 ? 'fourthCarouselExampleIndicators'
                                            : dataStatus.index == 4 ? 'fifthCarouselExampleIndicators'
                                            : dataStatus.index == 5 ? 'sixthCarouselExampleIndicators'
                                            : dataStatus.index == 6 ? 'seventhCarouselExampleIndicators'
                                            : dataStatus.index == 7 ? 'eighthCarouselExampleIndicators'
                                            : dataStatus.index == 8 ? 'ninthCarouselExampleIndicators'
                                            : dataStatus.index == 9 ? 'tenthCarouselExampleIndicators'
                                            : ''}" data-bs-slide="prev">
                                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                                <span class="visually-hidden">Previous</span>
                                            </button>
                                            <button class="carousel-control-next" type="button" data-bs-target="#${dataStatus.index == 0 ? 'oneCarouselExampleIndicators'
                                            : dataStatus.index == 1 ? 'secondCarouselExampleIndicators'
                                            : dataStatus.index == 2 ? 'thirdCarouselExampleIndicators'
                                            : dataStatus.index == 3 ? 'fourthCarouselExampleIndicators'
                                            : dataStatus.index == 4 ? 'fifthCarouselExampleIndicators'
                                            : dataStatus.index == 5 ? 'sixthCarouselExampleIndicators'
                                            : dataStatus.index == 6 ? 'seventhCarouselExampleIndicators'
                                            : dataStatus.index == 7 ? 'eighthCarouselExampleIndicators'
                                            : dataStatus.index == 8 ? 'ninthCarouselExampleIndicators'
                                            : dataStatus.index == 9 ? 'tenthCarouselExampleIndicators'
                                            : ''}" data-bs-slide="next">
                                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                                <span class="visually-hidden">Next</span>
                                            </button>
                                        </div>
                                            <%--슬라이드끝--%>

<%--                                        <div class="mb-3">--%>
<%--                                            <img class="card-img-top" src="${item.imgUrl}" alt="..." />--%>
<%--                                        </div>--%>
                                        <ul class="list-unstyled mb-4">
                                            <div class="small">
                                                <div class="fw-bold">
                                                    <a href="/user/view/${item.id}" style="color: black">${item.nickname}, ${item.age}</a>
                                                </div>
                                                <div class="text-muted">
                                                    <i class="bi bi-geo-alt-fill"></i>${item.address}・${item.distance == 0.0 ? '측정불가' : item.distance}${item.distance == 0.0 ? '' : 'km'},
                                                    <i class="bi bi-rulers"></i>${item.height}cm
                                                    💘${item.purpose}
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

    $(document).ready(function () {
    })

    function deleteUserIds(id, obj) {
        console.log("id", id)
        $.ajax({
            type: 'get',
            url: "/user/deleteUserIds/" + id,
            success: function (data) { // 결과 성공 콜백함수
                console.log("data", data);
                // document.location.href = '/'
            },
            error: function (request, status, error) { // 결과 에러 콜백함수
                console.log("error", error)
            }
        })
        var card = obj.closest('.col-lg-6');
        // 트랜지션을 적용하여 천천히 사라지게 함
        // 트랜지션을 적용하여 카드가 위로 날아가는 애니메이션 효과
        card.style.transition = "transform 0.5s ease-in-out";
        card.style.transform = "translate(100%, -100%) rotate(45deg)";
        // 트랜지션 완료 후에 요소를 완전히 제거
        card.addEventListener('transitionend', function() {
            card.remove();
        });



    }
</script>