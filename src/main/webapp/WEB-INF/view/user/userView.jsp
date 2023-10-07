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
<link rel="stylesheet" href="/static/css/star-rating-svg.css">
<script src="/static/js/jquery.star-rating-svg.js"></script>

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
    <input type="hidden" value="${relationshipInfo}" id="relationshipInfo">
    <input type="hidden" value="${evaluationInfo}" id="evaluationInfo">
    <input type="hidden" value="${userInfo.id}" id="userId">
    <section class="bg-light py-5">
        <div class="container px-5 my-5">
            <div class="text-center mb-5">
                <h1 class="fw-bolder">userView</h1>
                <p class="lead fw-normal text-muted mb-0">Look at the profile</p>
            </div>
            <div class="col-lg-6 mx-auto ">
                    <div class="card mb-5 mb-xl-0 ">
                    <%--p-0이 카드안의 패딩 조절--%>
                    <div class="card-body p-0 text-start">
                        <div class="mb-3">
                            <%--슬라이드--%>
                            <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="false">
                                <div class="carousel-indicators">
                                    <c:forEach var="item" items="${fileList}" varStatus="status">
                                        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="${status.index}" class="${status.index == 0 ?  'active' : ''}" aria-current="${status.index == 0 ? true : ''}" aria-label="Slide ${status.count}"></button>
                                    </c:forEach>
                                </div>
                                <div class="carousel-inner">
                                    <c:forEach var="item" items="${fileList}" varStatus="status">
                                        <div class="carousel-item ${status.index == 0 ?  'active' : ''}">
                                            <img class="d-block w-100" src="${item.filepath}${item.imageName}" alt="..." />
                                        </div>
                                    </c:forEach>
                                </div>
                                <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                    <span class="visually-hidden">Previous</span>
                                </button>
                                <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                    <span class="visually-hidden">Next</span>
                                </button>
                            </div>
                            <%--슬라이드끝--%>
                        </div>
                        <ul class="list-unstyled mb-4">
                            <div class="small ">
                                <div class="fw-bold">${userInfo.nickname}, ${userInfo.age}</div>
                                <div class="text-muted">
                                    <i class="bi bi-geo-alt-fill"></i>${userInfo.addressDoro}
                                    <i class="bi bi-rulers"></i>${userInfo.height}cm
                                    💘${userInfo.purpose}
                                </div>
                            </div><br>

                            <div class="h4 pb-2 mb-4 border-bottom"></div>
                            소개글
                            <i class="bi bi-chat-dots"></i>
                            <li class="mb-2">
                                <i class="bi bi-check text-primary"></i>
                                <label>${userInfo.introduce}</label>
                            </li>

                            <div class="h4 pb-2 mb-4 border-bottom"></div>
                            기본정보😄
                            <li class="mb-2">
                                <i class="bi bi-check text-primary"></i>
                                <label>직업: </label>
                                <label>${userInfo.job}</label>
                            </li>
                            <li class="mb-2">
                                <i class="bi bi-check text-primary"></i>
                                <label>직장: </label>
                                <label>${userInfo.workplace}</label>
                            </li>
                            <li class="mb-2">
                                <i class="bi bi-check text-primary"></i>
                                <label>학력: </label>
                                <label>${userInfo.academic}</label>
                            </li>
                            <li class="mb-2">
                                <i class="bi bi-check text-primary"></i>
                                <label>체형: </label>
                                <label>${userInfo.bodyType}</label>
                            </li>
                            <li class="mb-2">
                                <i class="bi bi-check text-primary"></i>
                                <label>성격: </label>
                                <label>${userInfo.personality}</label>
                            </li>
                            <li class="mb-2">
                                <i class="bi bi-check text-primary"></i>
                                <label>MBTI: </label>
                                <label>${userInfo.mbti}</label>
                            </li>

                            <div class="h4 pb-2 mb-4 border-bottom"></div>
                            라이프스타일🏖
                            <li class="mb-2">
                                <i class="bi bi-check text-primary"></i>
                                <label>흡연: </label>
                                <label>${userInfo.smokingYn == 'Y' ? '흡연' : '비흡연'}</label>
                            </li>
                            <li class="mb-2">
                                <i class="bi bi-check text-primary"></i>
                                <label>음주: </label>
                                <label>${userInfo.drinkingType}</label>
                            </li>
                            <li class="mb-2">
                                <i class="bi bi-check text-primary"></i>
                                <label>종교: </label>
                                <label>${userInfo.religionType}</label>
                            </li>
                        </ul>
                    </div>
                    <%--평가유무--%>
                        <div id="notEvaluate" class="text-center">
                            <div class="d-block p-2 text-bg-light" >${userInfo.realName} 님의 매력점수는?</div>
                            <div class="ratings jq-stars" data-rating="0"></div>
                        </div>
                        <div id="didEvaluate">
                            <span class="d-block p-2 text-bg-light text-start" >${userInfo.realName} 님의 매력을 ⭐${evaluationInfo.score}로 평가하였습니다.</span>
                        </div>
                    <%--친구해요 유무--%>
                    <div class="h4 pb-2 mb-4 border-bottom"></div>
                    <div class="p-2 text-bg-info text-start" id="didRelationship">
                        친구해요를 보냈어요<i class="bi bi-heart-fill" style="color: red"></i>
                    </div>
                    <button class="btn btn-outline-primary" id="notRelationship" onclick="sendRelationship(${userInfo.id},$(this))">
                        친구해요<i class="bi bi-heart"></i>
                    </button>
                    <%--회원추천--%>
                    <div id="similarCharm">
                        <div class="h4 pb-2 mb-4 border-bottom"></div>
                        매력지수가 비슷한 이성 보러가기 ⭐
                    </div>
                </div>
            </div>
        </div>
    </section>
</main>
</body>
</html>
<script>
    $(document).ready(function(){
        if($('#evaluationInfo').val() != '') {
            console.log("평가했다")
            $('#notEvaluate').hide()
        } else {
            console.log("평가x")
            $('#didEvaluate').hide()
            $('#test').hide()
        }
        if($('#relationshipInfo').val() != '') {
            console.log("이미친구신청")
            $('#notRelationship').hide()
        } else {
            console.log("친구x")
            $('#didRelationship').hide()
        }

        $(".ratings").starRating({
            totalStars: 5,
            starSize: 20,
            emptyColor: 'gray',
            hoverColor: 'gold',
            activeColor: 'gold',
            ratedColor:'gold',
            disableAfterRate:false,
            forceRoundUp:true,
            callback:function(currentRating){
                let params = {
                    receiveId : $('#userId').val(),
                    score : currentRating
                }
                $.ajax({
                    type : 'post',
                    url : "/evaluation/sendingEvaluation",
                    data : params,
                    success : function(data) { // 결과 성공 콜백함수
                        console.log("data", data)
                        if(data == true) {
                            $('#didEvaluate').show()
                            $('#notEvaluate').hide()
                        } else {
                            alert("이미 평가를 보냈거나 실패했습니다.")
                        }
                    },
                    error : function(request, status, error) { // 결과 에러 콜백함수
                        console.log("error", error)
                    }
                });


                // if(currentRating == 1){
                //     $('#showRatings').text($('#ratings').val() + "점 최악이에요");
                // }else if(currentRating == 2){
                //     $('#showRatings').text($('#ratings').val() + "점 별로에요");
                // }else if(currentRating == 3){
                //     $('#showRatings').text($('#ratings').val() + "점 보통이에요");
                // }else if(currentRating == 4){
                //     $('#showRatings').text($('#ratings').val() + "점 좋아요");
                // }else{
                //     $('#showRatings').text($('#ratings').val() + "점 최고에요");
                // }
            }
        });

    })

    function sendRelationship(id, obj) {
        let params = {
            getId : id
        }
        $.ajax({
            type : 'post',
            url : "/relationship/sendingRelationship",
            data : params,
            success : function(data) { // 결과 성공 콜백함수
                console.log("data", data)
                if(data == true) {
                    $('#didRelationship').show()
                    $('#notRelationship').hide()
                    $.ajax({
                        type : 'get',
                        url : "/notifications/send-data/" + id + "/" + "친구해요",
                        success : function(data) { // 결과 성공 콜백함수
                            console.log("data", data)
                        },
                        error : function(request, status, error) { // 결과 에러 콜백함수
                            console.log("error", error)
                        }
                    });

                } else {
                    alert("이미 친구해요를 보냈거나 실패했습니다")
                }
            },
            error : function(request, status, error) { // 결과 에러 콜백함수
                console.log("error", error)
            }
        });
    }

</script>