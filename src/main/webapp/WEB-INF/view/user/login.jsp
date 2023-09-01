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
    <!-- Page content-->
    <section class="py-5">
        <div class="container px-5">
            <!-- Contact form-->
            <div class="bg-light rounded-3 py-5 px-4 px-md-5 mb-5">
                <div class="text-center mb-5">
                    <h1 class="fw-bolder">로그인</h1>
                </div>
                <form action="/loginProc" method="POST">
                    <div class="row gx-5 justify-content-center">
                        <div class="col-lg-8 col-xl-6">
                            <!-- Name input-->
                            <div class="form-floating mb-3">
                                <input class="form-control" id="loginId" name="loginId" value="power4895" type="text" placeholder="Enter your loginId..." data-sb-validations="required" />
                                <label for="loginId">아이디</label>
                                <div class="invalid-feedback" data-sb-feedback="realName:required">A loginId is required.</div>
                            </div>
                            <!-- Name input-->
                            <div class="form-floating mb-3">
                                <input class="form-control" id="password" name="password" value="1234" type="password" placeholder="Enter your name..." data-sb-validations="required" />
                                <label for="password">비밀번호</label>
                                <div class="invalid-feedback" data-sb-feedback="password:required">A password is required.</div>
                            </div>
                            <div class="d-none" id="submitSuccessMessage">
                            </div>
                            <div class="d-none" id="submitErrorMessage"><div class="text-center text-danger mb-3">Error sending message!</div></div>
                            <div class="d-grid">
                                <div class="d-grid"><button class="btn btn-primary btn-lg" >로그인</button></div>
<%--                                <div class="d-grid"><button class="btn btn-primary btn-lg" id="submitButton" onclick="login()" type="submit">로그인</button></div>--%>
                            </div>
                            <br>
                            <a style="color: gray">아이디 찾기</a>
                            <a style="float: right; color: gray">비밀번호 찾기</a>
                            <%--                        <a href="/oauth2/authorization/naver">네이버</a>--%>
                            <a href="/oauth2/authorization/google">구글로그인</a>
                            <p style="text-align: center; color: gray">다른 방식으로 로그인</p>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </section>
</main>
<!-- Bootstrap core JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Core theme JS-->
<script src="/static/js/scripts.js"></script>
<!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
<!-- * *                               SB Forms JS                               * *-->
<!-- * * Activate your form at https://startbootstrap.com/solution/contact-forms * *-->
<!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
<%--<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>--%>
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
                document.location.href = "/"

            }
        });
    }

</script>