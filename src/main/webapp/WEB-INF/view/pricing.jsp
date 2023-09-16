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
</body>
</html>
<script>

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

    function login() {
        console.log(">>", $("#loginId").val().trim())
        com.requestAjax({
            type: "POST",
            url : "/loginProc",
            params : {
                "loginId" : $("#loginId").val().trim(),
                "password" : $("#password").val().trim(),
            }
            //call back
        },function(data){
            console.log(data)
            if( data.isLogin == true ){
                document.location.href = "../.."

            }

            // if( data.isLogin == true ){
            //     var referer = document.referrer;
            //     console.log("referer", referer)
            //     document.location.href = (referer == "" || referer.indexOf("login") > -1 || referer.indexOf("registerForm") > -1
            //         || referer.indexOf("userSearch") > -1 || referer.indexOf("changePasswordForm") > -1) ?  "/" : referer;
            // }else{
            //     $("#errorMsg").show();
            // }
        });
    }

</script>