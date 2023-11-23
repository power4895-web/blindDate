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
                        <h1 class="fw-bolder">randomUserList <i class="bi bi-people" style="color: #005bd4"></i></h1>
                        <p class="lead fw-normal text-muted mb-0">Friends with a show of affection</p>
                    </div>
                    <div class="row gy-xl-5 justify-content" >
                        <c:forEach var="item" items="${randomUserList}" varStatus="status" >
                            <div class="col-lg-6 col-xl-4">
                                <div class="card mb-5 mb-xl-0">
                                    <div class="card-header">
                                        <button type="button" class="btn-close" style="float: right;" aria-label="Close" onclick="todayProfileUpdate(${item.id}, this)"></button>
                                    </div>
                                    <div class="card-body p-0">
                                        <div class="mb-3">
                                            <img class="card-img-top" src="${item.imgUrl}" alt="..." />
                                        </div>
                                        <ul class="list-unstyled mb-4">
                                            <div class="small">
                                                <div class="fw-bold">
                                                    <a href="/user/view/${item.id}">${item.nickname}, ${item.age}</a>
                                                </div>
                                                <div class="text-muted">
                                                    <i class="bi bi-geo-alt-fill"></i>${item.addressDoro}
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
        // getNotificationCount()
        // if ($('#flag').val() == 'relationship') {
        //     console.log("relationship")
        //     // 친구해요데이터가져오기
        //     getRelationshipList2("get");
        // } else {
        //     console.log("getEvaluationList")
        //     //호감 활성화
        //     activateTab("evaluation")
        //     //매력 비활성화
        //     deactivateTab("relationship")
        //     //호감데이터가져오기
        //     getEvaluationList("get");
        // }
    })

    function todayProfileUpdate(id, obj) {
        console.log("id", id)

        $.ajax({
            type: 'get',
            url: "/user/todayProfileUpdate/" + id,
            // data : params,
            // dataType : 'json',  //왜 삭제해야하는지는 잘 모르겠어.
            success: function (data) { // 결과 성공 콜백함수
                console.log("data", data);
                // document.location.href = '/'
            },
            error: function (request, status, error) { // 결과 에러 콜백함수
                console.log("error", error)
            }
        })
        var card = obj.closest('.card');
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