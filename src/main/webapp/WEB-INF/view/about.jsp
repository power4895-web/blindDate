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
    <header class="py-5">
        <div class="container px-5">
            <div class="row justify-content-center">
                <div class="col-lg-8 col-xxl-6">
                    <div class="text-center my-5">
                        <h1 class="fw-bolder mb-3">with a neighborhood friend When you want to play fast.</h1>
                        <p class="lead fw-normal text-muted mb-4">If you need someone with me now Register an appointment, or find an appointment you want Have a good time with your local friend!</p>
                        <a class="btn btn-primary btn-lg" href="#scroll-target">Read our story</a>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <!-- About section one-->
    <section class="py-5 bg-light" id="scroll-target">
        <div class="container px-5 my-5">
            <div class="row gx-5 align-items-center">
                <div class="col-lg-6">
                    <img class="img-fluid rounded mb-5 mb-lg-0" src="/static/files/todayprofile_600x400.png" />
                </div>
                <div class="col-lg-6">
                    <h2 class="fw-bolder">
                        Go on a blind date with two people every day.
                    </h2>
                    <p class="lead fw-normal text-muted mb-0">
                        For the writer that I like
                        Let's be friends through Secret Match!!
                    </p>
                </div>
            </div>
        </div>
    </section>
    <!-- About section two-->
    <section class="py-5">
        <div class="container px-5 my-5">
            <div class="row gx-5 align-items-center">
                <div class="col-lg-6 order-first order-lg-last">
                    <img class="img-fluid rounded mb-5 mb-lg-0" src="/static/files/themoreuserlist_600x400.png" />
                </div>
                <div class="col-lg-6">
                    <h2 class="fw-bolder">
                        View your membership profile for an unlimited period of time.
                    </h2>
                    <p class="lead fw-normal text-muted mb-0">
                        Who pays to check their profile these days?
                        Now check your profile for free on Meet up!
                    </p>
                </div>
            </div>
        </div>
    </section>
    <!-- About section three-->
    <section class="py-5 bg-light">
        <div class="container px-5 my-5">
            <div class="row gx-5 align-items-center">
                <div class="col-lg-6">
                    <img class="img-fluid rounded mb-5 mb-lg-0" src="https://dummyimage.com/600x400/343a40/6c757d" alt="..." />
                </div>
                <div class="col-lg-6">
                    <h2 class="fw-bolder">At Secret Square
                        with anonymous friends
                        Feel free to communicate</h2>
                    <p class="lead fw-normal text-muted mb-0">
                        An anonymous, more thrilling conversation
                        For the writer that I like
                        Let's be friends through Secret Match!
                    </p>
                </div>
            </div>
        </div>
    </section>
    <!-- Team members section-->
    <section class="py-5 bg-light">
        <div class="container px-5 my-5">
            <div class="text-center">
                <h2 class="fw-bolder">Our team</h2>
                <p class="lead fw-normal text-muted mb-5">Dedicated to quality and your success</p>
            </div>
            <div class="row gx-5 row-cols-1 row-cols-sm-2 row-cols-xl-4 justify-content-center">
                <div class="col mb-5 mb-5 mb-xl-0">
                    <div class="text-center">
                        <img class="img-fluid rounded-circle mb-4 px-4" src="/static/files/150x150 고선우 증명사진.jpg" alt="..." />
                        <h5 class="fw-bolder">Ko seon woo</h5>
                        <div class="fst-italic text-muted">Founder &amp; CEO</div>
                    </div>
                </div>
                <div class="col mb-5 mb-5 mb-xl-0">
                    <div class="text-center">
                        <img class="img-fluid rounded-circle mb-4 px-4" src="/static/files/150x150 고선우 셀카.jpg" alt="..." />
                        <h5 class="fw-bolder">GoGetIt</h5>
                        <div class="fst-italic text-muted">CFO</div>
                    </div>
                </div>
                <div class="col mb-5 mb-5 mb-sm-0">
                    <div class="text-center">
                        <img class="img-fluid rounded-circle mb-4 px-4" src="/static/files/150x150 고선우 셀카2.jpg" alt="..." />
                        <h5 class="fw-bolder">SGA</h5>
                        <div class="fst-italic text-muted">Operations Manager</div>
                    </div>
                </div>
                <div class="col mb-5">
                    <div class="text-center">
                        <img class="img-fluid rounded-circle mb-4 px-4" src="/static/files/150x150 고선우 셀카3.jpg" alt="..." />
                        <h5 class="fw-bolder">DLO</h5>
                        <div class="fst-italic text-muted">CTO</div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</main>
</body>
</html>
<script>

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