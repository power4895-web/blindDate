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
    <input type="hidden" value="${relationshipInfo}" id="relationshipInfo">
    <input type="hidden" value="${evaluationInfo}" id="evaluationInfo">
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
                                <img class="card-img-top" src="${userInfo.imgUrl}" alt="..." />
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
                        <div id="didEvaluate">
                            <span class="d-block p-2 text-bg-light text-start" >${userInfo.realName} 님의 매력을 ⭐${evaluationInfo.score}로 평가하였습니다.</span>
                        </div>
                        <div id="notEvaluate">
                            <div class="h4 pb-2 mb-4 border-bottom"></div>
                            점수입력
                        </div>

                        <%--친구해요 유무--%>
                        <div class="h4 pb-2 mb-4 border-bottom"></div>
                        <div class="p-2 text-bg-info text-start" id="didRelationship">
                            친구해요를 보냈어요<i class="bi bi-heart-fill" style="color: red"></i>
                        </div>
                        <button class="btn btn-outline-primary" id="notRelationship" onclick="sendRelationship(${userInfo.id},$(this))">
                            <div class="h4 pb-2 mb-4 border-bottom"></div>친구해요<i class="bi bi-heart"></i>
                        </button>

                        <%--회원추천--%>
                        <div id="similarCharm">
                            <div class="h4 pb-2 mb-4 border-bottom"></div>
                            매력지수가 비슷한 이성 ⭐
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