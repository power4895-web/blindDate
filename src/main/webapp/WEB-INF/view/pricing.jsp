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
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=42f0eba0161fc3396885c9e3336cdeee&libraries=services" type="text/javascript"></script>
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
    <!-- Pricing section-->
    <section class="bg-light py-5">
        <div class="container px-5 my-5">
            <div class="text-center mb-5">
                <h1 class="fw-bolder">Pay as you grow</h1>
                <p class="lead fw-normal text-muted mb-0">With our no hassle pricing plans</p>
            </div>
            <div class="row gx-5 justify-content-center">
                <!-- Pricing card free-->
                <div class="col-lg-6 col-xl-4">
                    <div class="card mb-5 mb-xl-0">
                        <div class="card-body p-5">
                            <div class="small text-uppercase fw-bold text-muted">Free</div>
                            <div class="mb-3">
                                <span class="display-4 fw-bold">$0</span>
                                <span class="text-muted">/ mo.</span>
                            </div>
                            <ul class="list-unstyled mb-4">
                                <li class="mb-2">
                                    <i class="bi bi-check text-primary"></i>
                                    <strong>1 users</strong>
                                </li>
                                <li class="mb-2">
                                    <i class="bi bi-check text-primary"></i>
                                    5GB storage
                                </li>
                                <li class="mb-2">
                                    <i class="bi bi-check text-primary"></i>
                                    Unlimited public projects
                                </li>
                                <li class="mb-2">
                                    <i class="bi bi-check text-primary"></i>
                                    Community access
                                </li>
                                <li class="mb-2 text-muted">
                                    <i class="bi bi-x"></i>
                                    Unlimited private projects
                                </li>
                                <li class="mb-2 text-muted">
                                    <i class="bi bi-x"></i>
                                    Dedicated support
                                </li>
                                <li class="mb-2 text-muted">
                                    <i class="bi bi-x"></i>
                                    Free linked domain
                                </li>
                                <li class="text-muted">
                                    <i class="bi bi-x"></i>
                                    Monthly status reports
                                </li>
                            </ul>
                            <div class="d-grid"><a class="btn btn-outline-primary" href="#!">Choose plan</a></div>
                        </div>
                    </div>
                </div>
                <!-- Pricing card pro-->
                <div class="col-lg-6 col-xl-4">
                    <div class="card mb-5 mb-xl-0">
                        <div class="card-body p-5">
                            <div class="small text-uppercase fw-bold">
                                <i class="bi bi-star-fill text-warning"></i>
                                1month
                            </div>
                            <div class="mb-3">
                                <span class="display-4 fw-bold">$9</span>
                                <span class="text-muted">/ mo.</span>
                            </div>
                            <ul class="list-unstyled mb-4">
                                <li class="mb-2">
                                    <i class="bi bi-check text-primary"></i>
                                    <strong>5 users</strong>
                                </li>
                                <li class="mb-2">
                                    <i class="bi bi-check text-primary"></i>
                                    5GB storage
                                </li>
                                <li class="mb-2">
                                    <i class="bi bi-check text-primary"></i>
                                    Unlimited public projects
                                </li>
                                <li class="mb-2">
                                    <i class="bi bi-check text-primary"></i>
                                    Community access
                                </li>
                                <li class="mb-2">
                                    <i class="bi bi-check text-primary"></i>
                                    Unlimited private projects
                                </li>
                                <li class="mb-2">
                                    <i class="bi bi-check text-primary"></i>
                                    Dedicated support
                                </li>
                                <li class="mb-2">
                                    <i class="bi bi-check text-primary"></i>
                                    Free linked domain
                                </li>
                                <li class="text-muted">
                                    <i class="bi bi-x"></i>
                                    Monthly status reports
                                </li>
                            </ul>
                            <div class="d-grid"><a class="btn btn-primary" href="#!">Choose plan</a></div>
                        </div>
                    </div>
                </div>
                <!-- Pricing card enterprise-->
                <div class="col-lg-6 col-xl-4">
                    <div class="card">
                        <div class="card-body p-5">
                            <div class="small text-uppercase fw-bold text-muted">6month</div>
                            <div class="mb-3">
                                <span class="display-4 fw-bold">$49</span>
                                <span class="text-muted">/ mo.</span>
                            </div>
                            <ul class="list-unstyled mb-4">
                                <li class="mb-2">
                                    <i class="bi bi-check text-primary"></i>
                                    <strong>Unlimited users</strong>
                                </li>
                                <li class="mb-2">
                                    <i class="bi bi-check text-primary"></i>
                                    5GB storage
                                </li>
                                <li class="mb-2">
                                    <i class="bi bi-check text-primary"></i>
                                    Unlimited public projects
                                </li>
                                <li class="mb-2">
                                    <i class="bi bi-check text-primary"></i>
                                    Community access
                                </li>
                                <li class="mb-2">
                                    <i class="bi bi-check text-primary"></i>
                                    Unlimited private projects
                                </li>
                                <li class="mb-2">
                                    <i class="bi bi-check text-primary"></i>
                                    Dedicated support
                                </li>
                                <li class="mb-2">
                                    <i class="bi bi-check text-primary"></i>
                                    <strong>Unlimited</strong>
                                    linked domains
                                </li>
                                <li class="text-muted">
                                    <i class="bi bi-check text-primary"></i>
                                    Monthly status reports
                                </li>
                            </ul>
                            <div class="d-grid"><a class="btn btn-outline-primary" href="#!">Choose plan</a></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <button onclick="test()">test</button>
    </section>
</main>
<script>
    $( window ).on( "scroll", function() {
        var scrollPosition = $(window).scrollTop();

        var documentHeight = $(document).height();

        var windowHeight = $(window).height();
        console.log("scrollPosition", scrollPosition)
        console.log("documentHeight", documentHeight)
        console.log("windowHeight", windowHeight)
        if (scrollPosition + windowHeight >= documentHeight) {
            console.log(">>>>>>>>>>>>>>>>>!");
        }
    } );
    function test() {
        const params = {
            "loginId" : 'hello',
            "name" : "them",
        }
        console.log(typeof params);
        console.log(typeof JSON.stringify(params));

        com.requestAjax({
            type: "POST",
            url : "/pricing2",
            // contentType: 'application/json',
            // params : {
            //     "loginId" : 'hello',
            //     "name" : "them",
            // }
            data: params,
        },function(data){
            console.log("data" , data);
        });
    }

    function getLALOInfo () {
        const placeAddress = "경기도 성남시 분당구"; //원하는 주소를 body값에 받거나 변수로 입력하여준다.
        const url = 'https://dapi.kakao.com/v2/local/search/address.json?query=' + encodeURI(placeAddress);

        console.log("url", url)
        $.ajax({
            method: 'get',
            url : url,
            headers: {
                "Access-Control-Allow-Origin": "*",
                key : 'Authorization',
                value : 'ea770b65073c17f4aff659c751c6df85'
            },
            success : function(data) { // 결과 성공 콜백함수
                console.log("data", data);
            },
            error : function(request, status, error) { // 결과 에러 콜백함수
                console.log("error", error)
            }
        });
    }

    function googleapisView() {
        var address = encodeURIComponent('광주광역시 광산구 첨단내촌로 1');
        var geocode = "http://maps.googleapis.com/maps/api/geocode/json?address="+address+"&sensor=true";
        $.ajax({
            url: geocode,
            type: 'POST',
            success: function(myJSONResult){
                console.log("myJSONResult", myJSONResult)
                if(myJSONResult.status == 'OK') {
                    var tag = "";
                    var i;
                    for (i = 0; i < myJSONResult.results.length; i++) {
                        tag += "주소 : " +myJSONResult.results[i].formatted_address+" <br />";
                        tag += "위도 : " +myJSONResult.results[i].geometry.location.lat+" <br />";
                        tag += "경도 : " +myJSONResult.results[i].geometry.location.lng+" <br />";
                    }
                    document.getElementById("message").innerHTML = tag;
                } else if(myJSONResult.status == 'ZERO_RESULTS') {
                    alert("지오코딩이 성공했지만 반환된 결과가 없음을 나타냅니다.\n\n이는 지오코딩이 존재하지 않는 address 또는 원격 지역의 latlng을 전달받는 경우 발생할 수 있습니다.")
                } else if(myJSONResult.status == 'OVER_QUERY_LIMIT') {
                    alert("할당량이 초과되었습니다.");
                } else if(myJSONResult.status == 'REQUEST_DENIED') {
                    alert("요청이 거부되었습니다.\n\n대부분의 경우 sensor 매개변수가 없기 때문입니다.");
                } else if(myJSONResult.status == 'INVALID_REQUEST') {
                    alert("일반적으로 쿼리(address 또는 latlng)가 누락되었음을 나타냅니다.");
                }
            }
        });
    }
    function distance(lat1, lon1, lat2, lon2) {
        const R = 6371; // 지구 반지름 (단위: km)
        const dLat = deg2rad(lat2 - lat1);
        const dLon = deg2rad(lon2 - lon1);
        const a = Math.sin(dLat/2) * Math.sin(dLat/2) +
            Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) *
            Math.sin(dLon/2) * Math.sin(dLon/2);
        const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
        const distance = R * c; // 두 지점 간의 거리 (단위: km)
        return distance;
    }

    function deg2rad(deg) {
        return deg * (Math.PI/180);
    }
    function test () {

        const seoulLat = 37.503380461986666;
        const seoulLon = 126.76615421706116;
        const busanLat = 37.53194431314597;
        const busanLon = 126.91416233208527;
        const dist = distance(seoulLat, seoulLon, busanLat, busanLon);
        console.log("dies", dist)

        const geocoder = new kakao.maps.services.Geocoder();
        geocoder.addressSearch("서울 영등포구 국회대로 지하 758 (국회의사당역)", (result, status) => {
            if (status === kakao.maps.services.Status.OK) {
                console.log('위도 : ' + result[0].y);
                console.log('경도 : ' + result[0].x);
            }
        })
    }
</script>
</body>
</html>
