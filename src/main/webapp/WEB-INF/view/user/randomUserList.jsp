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

//알림읽기
    async function updateNotification(flag) {
        console.log("updateNotification start")
        const result = await $.ajax({
            type: 'get',
            url: "/notifications/update/" + flag,
            success: function (data) { // 결과 성공 콜백함수
                console.log("notiCount", data)
            },
            error: function (request, status, error) { // 결과 에러 콜백함수
                console.log("error", error)
            }
        })
        console.log("result", result);
    }

    //보낸표현버튼 > default realationship
    function sendExpressionBtn() {
        getRelationshipList2("send");
        activateTab("relationship"); // 친구해요 활성화
        deactivateTab("evaluation"); // 호감 비활성화
        deactivateTab("totalFriend"); // 전체 비활성화
    }

    //받은표현버튼 > default realationship
    function getExpressionBtn() {
        getRelationshipList2("get");
        activateTab("relationship"); // 친구해요 활성화
        deactivateTab("evaluation"); // 호감 비활성화
        deactivateTab("totalFriend"); // 전체 비활성화
    }

    //전체 태그
    function totalTag() {

        //태그 활성화인데 한번더 눌렀을 때 데이터 안가져오고 부트스트랩으로 인해 활성화 풀리는거 다시 활성화시킴
        var activeTag = $('#myTag button.active').attr('id');
        console.log('현재 활성화된 태그:', activeTag);
        if(activeTag == undefined) {
            activateTab("totalFriend")
            return;
        }

        var activeTab = $('#myTab li button.active').attr('id');
        console.log('현재 활성화된 탭:', activeTab);
        deactivateTab("relationship"); // 호감 비활성화
        deactivateTab("evaluation"); // 호감 비활성화

        if(activeTab == 'sendExpresstionBtnId') {
            console.log("보낸표현_전체")
            getTotalFriendList("send")
        }
        if(activeTab == 'getExpresstionBtnId') {
            console.log("받은표현_전체")
            getTotalFriendList("get")
        }
    }

    //친구해요 태그
    async function letFriendshipTag() {
        var activeTab = $('#myTab li button.active').attr('id');
        console.log('현재 활성화된 탭:', activeTab);
        var activeTag = $('#myTag button.active').attr('id');
        console.log('현재 활성화된 태그:', activeTag);
        if(activeTag == undefined) {
            activateTab("relationship")
            // return;
        }

        deactivateTab("totalFriend"); // 전체 비활성화
        deactivateTab("evaluation"); // 호감 비활성화

        if(activeTab == 'sendExpresstionBtnId') {
            console.log("보낸표현_친구해요")
            getRelationshipList2("send")
        }
        if(activeTab == 'getExpresstionBtnId') {
            console.log("받은표현_친구해요")
            $('#relationshipCount').text('')
            $('#evaluationCount').text('')
            getRelationshipList2("get")
        }
    }
    //매력 태그
    function evaluationTag() {
        var activeTab = $('#myTab li button.active').attr('id');
        console.log('현재 활성화된 탭:', activeTab);
        var activeTag = $('#myTag button.active').attr('id');
        console.log('현재 활성화된 태그:', activeTag);
        if(activeTag == undefined) {
            activateTab("evaluation")
            return;
        }
        deactivateTab("totalFriend"); // 전체 비활성화
        deactivateTab("relationship"); // 친구해요 비활성화

        if(activeTab == 'sendExpresstionBtnId') {
            console.log("보낸표현_호감")
            getEvaluationList("send")
        }
        if(activeTab == 'getExpresstionBtnId') {
            console.log("받은표현_호감")
            $('#evaluationCount').text('')
            $('#relationshipCount').text('')
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


    //친구해요 service 호출
    async function getRelationshipList2(type) {
        console.log("getRelationshipList2")
        return new Promise(function(resolve, reject){ // promise 정의
            $.ajax({
                type : 'get',
                url : "/relationship/relationshipList/" + type,
                async: true, //비동기 여부
                timeout: 10000, //타임 아웃 설정 (1000 = 1초)
                dataType: "TEXT", //응답받을 데이터 타입 (XML,JSON,TEXT,HTML,JSONP)
                contentType: "application/json; charset=utf-8", //헤더의 Content-Type을 설정
                success : function(data) { // 결과 성공 콜백함수
                    resolve(data);
                    if(type == "send") {
                        $('#sendExpresstionProfile').empty();
                        $('#getExpressionProfile').empty();
                        $('#sendExpresstionProfile').html(data);
                    }
                    if(type == "get") {
                        $('#sendExpresstionProfile').empty();
                        $('#getExpressionProfile').empty();
                        $('#getExpressionProfile').html(data);
                        // 친구해요 알림개수 표시하기
                        updateNotification("relationship");
                    }
                },
                error: function (request, status, error) { // 결과 에러 콜백함수
                    console.log("error", error)
                    reject(error);
                }
            });
        });
    };

    //호감 service
    function getEvaluationList(type) {
        console.log("type", type)
        $.ajax({
            type : 'get',
            url : "/evaluation/evaluationList/" + type,
            success : function(data) { // 결과 성공 콜백함수
                if(type == "send") {
                    $('#sendExpresstionProfile').empty();
                    $('#getExpressionProfile').empty();
                    $('#sendExpresstionProfile').html(data);
                }
                if(type == "get") {
                    $('#sendExpresstionProfile').empty();
                    $('#getExpressionProfile').empty();
                    $('#sendExpresstionProfile').empty();
                    $('#getExpressionProfile').html(data);
                    //호감알림개수 표시하기
                    // getNotificationCount();

                    //다 읽어주기
                    updateNotification("evaluation");
                }
            },
            error : function(request, status, error) { // 결과 에러 콜백함수
                console.log("error", error)
            }
        });
    }
    //전체 service
    async function getTotalFriendList(type) {
        console.log("type", type)
        $.ajax({
            type : 'get',
            url : "/relationship/totalFriendList/" + type,
            success : function(data) { // 결과 성공 콜백함수
                if(type == "send") {
                    $('#sendExpresstionProfile').empty();
                    $('#getExpressionProfile').empty();
                    $('#sendExpresstionProfile').html(data);
                }
                if(type == "get") {
                    $('#sendExpresstionProfile').empty();
                    $('#getExpressionProfile').empty();
                    $('#sendExpresstionProfile').empty();
                    $('#getExpressionProfile').html(data);
                }
            },
            error : function(request, status, error) { // 결과 에러 콜백함수
                console.log("error", error)
            }
        });
    }


    // 알람개수
    // let totalNCount = 0; //mypage,친구리스트 알람개수
    //현재시점 알람개수 가져와서 매핑
    function getNotificationCount() {
        console.log("getNotificationCount")
        $.ajax({
            type: 'get',
            url: "/notification/count",
            success: function (data) { // 결과 성공 콜백함수
                console.log("notiCount", data)
                console.log("relationshipCount", data.relationshipCount)
                console.log("evaluationCount", data.evaluationCount)
                if(data.relationshipCount != 0) {
                    $('#relationshipCount').text(data.relationshipCount)
                }
                if(data.evaluationCount != 0) {
                    $('#evaluationCount').text(data.evaluationCount)
                }
            },
            error: function (request, status, error) { // 결과 에러 콜백함수
                console.log("error", error)
            }
        })
    }


    //친구해요 service 호출
    function getNotificationCount2() {
        console.log("getNotificationCount2")
        return new Promise(function(resolve, reject){ // promise 정의
            $.ajax({
                type : 'get',
                url: "/notification/count",
                async: true, //비동기 여부
                timeout: 10000, //타임 아웃 설정 (1000 = 1초)
                dataType: "INT", //응답받을 데이터 타입 (XML,JSON,TEXT,HTML,JSONP)
                contentType: "application/json; charset=utf-8", //헤더의 Content-Type을 설정
                success : function(data) { // 결과 성공 콜백함수
                    resolve(data);
                    console.log("data", data)
                    if(data.relationshipCount != 0) {
                        $('#relationshipCount').text(data.relationshipCount)
                    }
                    if(data.evaluationCount != 0) {
                        $('#evaluationCount').text(data.evaluationCount)
                    }

                },
                error: function (request, status, error) { // 결과 에러 콜백함수
                    console.log("error", error)
                    reject(error);
                }
            });
        });
    };


</script>