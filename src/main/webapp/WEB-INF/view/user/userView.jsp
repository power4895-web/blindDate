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
                <h1 class="fw-bolder">userView</h1>
                <p class="lead fw-normal text-muted mb-0">Look at the profile</p>
            </div>




                <div class="col-lg-6 mx-auto ">
<%--                <div class="col-lg-6 col-xl-10 justify-content-center">--%>
                    <div class="card mb-5 mb-xl-0 ">
                        <div class="card-body p-1 text-start">
                            <div class="mb-3">
                                <img class="card-img-top" src="${userInfo.imgUrl}" alt="..." />
                            </div>
                            <ul class="list-unstyled mb-4">
                                <div class="small ">
                                    <div class="fw-bold">${userInfo.nickname}, ${userInfo.age}</div>
                                    <div class="text-muted">${userInfo.addressDoro},${userInfo.purpose}</div>
                                </div><br>
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
                                <li class="mb-2">
                                    <i class="bi bi-check text-primary"></i>
                                    <label>흡연: </label>
                                    <label>${userInfo.smokingYn}</label>
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
                        <c:if test="${evaluationInfo != null}">
                            <span class="d-block p-2 text-bg-light text-start">${evaluationInfo.score}점으로 평가하였습니다.</span>
                        </c:if>
                        <c:if test="${evaluationInfo == null}">
                            점수입력
                        </c:if>
                        <c:if test="${relationshipInfo != null}">
                            <span class="d-block p-2 text-bg-info text-start">친구해요를 보냈어요</span>
                        </c:if>
                        <c:if test="${relationshipInfo == null}">
                            <a id="item_${status.index}" class="btn btn-outline-primary"  onclick="sendRelationship(${userInfo.id},$(this))" href="#!">
                                친구해요<i class="bi bi-heart"></i>
                            </a>
                        </c:if>
                    </div>
                </div>
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

</script>