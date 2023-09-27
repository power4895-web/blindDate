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
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-through-heart-fill" viewBox="0 0 16 16">
                                            <path fill-rule="evenodd" d="M2.854 15.854A.5.5 0 0 1 2 15.5V14H.5a.5.5 0 0 1-.354-.854l1.5-1.5A.5.5 0 0 1 2 11.5h1.793l3.103-3.104a.5.5 0 1 1 .708.708L4.5 12.207V14a.5.5 0 0 1-.146.354l-1.5 1.5ZM16 3.5a.5.5 0 0 1-.854.354L14 2.707l-1.006 1.006c.236.248.44.531.6.845.562 1.096.585 2.517-.213 4.092-.793 1.563-2.395 3.288-5.105 5.08L8 13.912l-.276-.182A23.825 23.825 0 0 1 5.8 12.323L8.31 9.81a1.5 1.5 0 0 0-2.122-2.122L3.657 10.22a8.827 8.827 0 0 1-1.039-1.57c-.798-1.576-.775-2.997-.213-4.093C3.426 2.565 6.18 1.809 8 3.233c1.25-.98 2.944-.928 4.212-.152L13.292 2 12.147.854A.5.5 0 0 1 12.5 0h3a.5.5 0 0 1 .5.5v3Z"/>
                                        </svg>${userInfo.purpose}
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
                                기본정보
                                <i class="bi bi-emoji-smile"></i>
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
                                라이프스타일
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-balloon-fill" viewBox="0 0 16 16">
                                    <path fill-rule="evenodd" d="M8.48 10.901C11.211 10.227 13 7.837 13 5A5 5 0 0 0 3 5c0 2.837 1.789 5.227 4.52 5.901l-.244.487a.25.25 0 1 0 .448.224l.04-.08c.009.17.024.315.051.45.068.344.208.622.448 1.102l.013.028c.212.422.182.85.05 1.246-.135.402-.366.751-.534 1.003a.25.25 0 0 0 .416.278l.004-.007c.166-.248.431-.646.588-1.115.16-.479.212-1.051-.076-1.629-.258-.515-.365-.732-.419-1.004a2.376 2.376 0 0 1-.037-.289l.008.017a.25.25 0 1 0 .448-.224l-.244-.487ZM4.352 3.356a4.004 4.004 0 0 1 3.15-2.325C7.774.997 8 1.224 8 1.5c0 .276-.226.496-.498.542-.95.162-1.749.78-2.173 1.617a.595.595 0 0 1-.52.341c-.346 0-.599-.329-.457-.644Z"/>
                                </svg>
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
                            <span class="d-block p-2 text-bg-light text-start" >${userInfo.realName} 님의 매력을 <i class="bi bi-star-fill" style="color: orange"></i>${evaluationInfo.score}로 평가하였습니다.</span>
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
                            매력지수가 비슷한 이성 <i class="bi bi-star-fill" style="color: orange"></i>
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