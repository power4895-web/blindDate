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

            <%--탭그리기 : 보낸표현,받은표현--%>
            <ul class="nav nav-pills mb-3 justify-content-center" id="myTab" role="tablist" style="float :none;">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="pills-home-tab" onclick="sendExpression()" data-bs-toggle="pill" data-bs-target="#pills-home" type="button" role="tab" aria-controls="pills-home" aria-selected="true">보낸표현</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="pills-profile-tab" onclick="getExpression()" data-bs-toggle="pill" data-bs-target="#pills-profile" type="button" role="tab" aria-controls="pills-profile" aria-selected="false">받은표현</button>
                </li>
            </ul>
            <%--친구해요 호감 해시태그--%>
            <div class="d-grid gap-2  d-md-flex justify-content-md-start">
                <button type="button" id="totalFriend" class="btn btn-outline-secondary" aria-pressed="true" data-bs-toggle="button" onclick="totalFriendList()">전체</button>
                <button type="button" id="relationship" class="btn btn-outline-success active" aria-pressed="true" data-bs-toggle="button" onclick="letFriendship()">친구해요</button>
                <button type="button" id="evaluation" class="btn btn-outline-info" data-bs-toggle="button" onclick="evaluation()">매력</button>
            </div>

            <%--탭 내용 시작--%>
            <div class="tab-content" id="pills-tabContent">
                <%--첫번 째--%>
                <div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab" tabindex="0">
                    <div class="row gy-xl-5 justify-content" id="profileOne">
                    </div>
                </div>
                <%--두번 째--%>
                <div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab" tabindex="0">
                        <div class="row gy-xl-5 justify-content" id="profileTwo">
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
        getRelationshipList("send");

        //현재 활성화된 탭 확인
        $('#myTab button').on('click', function (e) {
            e.preventDefault()
            $(this).tab('show');
        });
    })



    //보낸표현버튼 > default realationship
    function sendExpression() {
        getRelationshipList("send");
        activateTab("relationship"); // 친구해요 활성화
        deactivateTab("evaluation"); // 호감 비활성화

    }

    //받은표현버튼 > default realationship
    function getExpression() {
        getRelationshipList("get");
        activateTab("relationship"); // 친구해요 활성화
        deactivateTab("evaluation"); // 호감 비활성화
    }

    //친구해요, 매력 태그
    function totalFriendList() {
        var activeTab = $('#myTab li button.active').attr('id');

        console.log('현재 활성화된 탭:', activeTab);

        deactivateTab("evaluation"); // 호감 비활성화

        if(activeTab == 'pills-home-tab') {
            console.log("보낸표현_친구해요")
            getRelationshipList("send")
        }
        if(activeTab == 'pills-profile-tab') {
            console.log("받은표현_친구해요")

            getRelationshipList("get")
        }
    }
    //친구해요 태그
    function letFriendship() {
        var activeTab = $('#myTab li button.active').attr('id');

        console.log('현재 활성화된 탭:', activeTab);

        deactivateTab("evaluation"); // 호감 비활성화

        if(activeTab == 'pills-home-tab') {
            console.log("보낸표현_친구해요")
            getRelationshipList("send")
        }
        if(activeTab == 'pills-profile-tab') {
            console.log("받은표현_친구해요")

            getRelationshipList("get")
        }
    }
    //호감 태그
    function evaluation() {
        var activeTab = $('#myTab li button.active').attr('id');
        console.log('현재 활성화된 탭:', activeTab);

        //친구해요 active 해제
        deactivateTab("relationship"); // 친구해요 비활성화


        if(activeTab == 'pills-home-tab') {
            console.log("보낸표현_호감")
            getEvaluationList("send")
        }
        if(activeTab == 'pills-profile-tab') {
            console.log("받은표현_호감")
            getEvaluationList("get")
        }
    }

    //현재 선택하지 않은 태그 비활성화 시키기
    function activateTab(tabId) {
        // button 아이디 변수로
        const tab = $('#'+ tabId )[0];
        tab.classList.add("active"); // active 클래스 추가
        tab.setAttribute("aria-selected", "true"); // aria-selected 속성 업데이트
    }
    //현재 선택하지 않은 태그 비활성화 시키기
    function deactivateTab(tabId) {
        const tab = $('#'+ tabId )[0];
        tab.classList.remove("active"); // active 클래스 제거
        tab.setAttribute("aria-selected", "false"); // aria-selected 속성 업데이트
    }

    //친구해요 서버호출
    async function getRelationshipList(type) {
        console.log("type", type)
        $.ajax({
            type : 'get',
            url : "/relationship/relationshipList/" + type,
            // data : params,
            success : function(data) { // 결과 성공 콜백함수
                if(type == "send") {
                    $('#profileOne').empty();
                    $('#profileTwo').empty();
                    $('#profileOne').html(data);
                }
                if(type == "get") {
                    $('#profileOne').empty();
                    $('#profileTwo').empty();
                    $('#profileTwo').html(data);
                }
            },
            error : function(request, status, error) { // 결과 에러 콜백함수
                console.log("error", error)
            }
        });
    }
    //호감 service
    async function getEvaluationList(type) {
        console.log("type", type)
        $.ajax({
            type : 'get',
            url : "/evaluation/evaluationList/" + type,
            success : function(data) { // 결과 성공 콜백함수
                if(type == "send") {
                    $('#profileOne').empty();
                    $('#profileTwo').empty();
                    $('#profileOne').html(data);
                }
                if(type == "get") {
                    $('#profileOne').empty();
                    $('#profileTwo').empty();
                    $('#profileOne').empty();
                    $('#profileTwo').html(data);
                }
            },
            error : function(request, status, error) { // 결과 에러 콜백함수
                console.log("error", error)
            }
        });
    }


</script>