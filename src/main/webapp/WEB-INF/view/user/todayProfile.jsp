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
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="/static/js/jquery.form.js"></script>
<script src="/static/js/commonUtil.js"></script>
<sec:authentication var="info" property="principal" />
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Modern Business - Start Bootstrap Template</title>
    <!-- Favicon-->
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
    <!-- Bootstrap icons-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
    <!-- Core theme CSS (includes Bootstrap)-->
    <link href="static/css/styles.css" rel="stylesheet" />
</head>
<body class="d-flex flex-column">
<main class="flex-shrink-0">
    <!-- Navigation-->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container px-5">
            <a class="navbar-brand" href="index.html">MEET UP</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                    <li class="nav-item"><a class="nav-link" href="index.html">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="about.html">About</a></li>
                    <li class="nav-item"><a class="nav-link" href="contact.html">Contact</a></li>
                    <li class="nav-item"><a class="nav-link" href="pricing.html">Pricing</a></li>
                    <li class="nav-item"><a class="nav-link" href="faq.html">FAQ</a></li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" id="navbarDropdownBlog" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">매칭</a>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownBlog">
                            <li><a class="dropdown-item" href="blog-home.html">좋아요이력</a></li>
                            <li><a class="dropdown-item" href="blog-post.html">채팅</a></li>
                        </ul>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" id="navbarDropdownPortfolio" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">MyPage</a>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownPortfolio">
                            <li><a class="dropdown-item" href="portfolio-overview.html">Portfolio Overview</a></li>
                            <li><a class="dropdown-item" href="portfolio-item.html">Portfolio Item</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <!-- Page content-->
    <section class="bg-light py-5">
        <div class="container px-5 my-5">
            <div class="text-center mb-5">
                <h1 class="fw-bolder">Pay as you grow</h1>
                <p class="lead fw-normal text-muted mb-0">With our no hassle pricing plans</p>
            </div>
            <div class="row gx-5 justify-content-center">
                <!-- Pricing card free-->
                <c:forEach var="item" items="${dataList}">
                    <div class="col-lg-6 col-xl-4">
                        <div class="card mb-5 mb-xl-0">
                            <div class="card-body p-5">
                                <div class="small text-uppercase fw-bold text-muted">Free</div>
                                <div class="mb-3">
                                    <img class="card-img-top" src="${item.filepath}${item.systemFilename}" alt="..." />
<%--                                    <img class="card-img-top" src="${`\files\ + item.systemFilename`}" alt="..." />--%>
<%--                                    <img class="card-img-top" src="${item.systemFilename}" alt="..." />--%>
<%--                                    <img class="card-img-top" src="`\files\${item.systemFilename}`" alt="..." />--%>

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
                                        <i class="bi bi-check text-primary"></i>
                                        Monthly status reports
                                    </li>
                                </ul>
                                <div class="d-grid"><a class="btn btn-outline-primary" href="#!">Choose plan</a></div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                <!-- Pricing card pro-->
                <%--                <div class="col-lg-6 col-xl-4">--%>
                <%--                    <div class="card mb-5 mb-xl-0">--%>
                <%--                        <div class="card-body p-5">--%>
                <%--                            <div class="small text-uppercase fw-bold">--%>
                <%--                                <i class="bi bi-star-fill text-warning"></i>--%>
                <%--                                Pro--%>
                <%--                            </div>--%>
                <%--                            <div class="mb-3">--%>
                <%--                                <img class="card-img-top" src="/static/files/민지.jpg" alt="..." />--%>
                <%--                            </div>--%>
                <%--                            <ul class="list-unstyled mb-4">--%>
                <%--                                <li class="mb-2">--%>
                <%--                                    <i class="bi bi-check text-primary"></i>--%>
                <%--                                    <strong>5 users</strong>--%>
                <%--                                </li>--%>
                <%--                                <li class="mb-2">--%>
                <%--                                    <i class="bi bi-check text-primary"></i>--%>
                <%--                                    5GB storage--%>
                <%--                                </li>--%>
                <%--                                <li class="mb-2">--%>
                <%--                                    <i class="bi bi-check text-primary"></i>--%>
                <%--                                    Unlimited public projects--%>
                <%--                                </li>--%>
                <%--                                <li class="mb-2">--%>
                <%--                                    <i class="bi bi-check text-primary"></i>--%>
                <%--                                    Community access--%>
                <%--                                </li>--%>
                <%--                                <li class="mb-2">--%>
                <%--                                    <i class="bi bi-check text-primary"></i>--%>
                <%--                                    Unlimited private projects--%>
                <%--                                </li>--%>
                <%--                                <li class="mb-2">--%>
                <%--                                    <i class="bi bi-check text-primary"></i>--%>
                <%--                                    Dedicated support--%>
                <%--                                </li>--%>
                <%--                                <li class="mb-2">--%>
                <%--                                    <i class="bi bi-check text-primary"></i>--%>
                <%--                                    Free linked domain--%>
                <%--                                </li>--%>
                <%--                                <li class="text-muted">--%>
                <%--                                    <i class="bi bi-x"></i>--%>
                <%--                                    Monthly status reports--%>
                <%--                                </li>--%>
                <%--                            </ul>--%>
                <%--                            <div class="d-grid"><a class="btn btn-outline-primary" href="#!">Choose plan</a></div>--%>
                <%--                        </div>--%>
                <%--                    </div>--%>
                <%--                </div>--%>
            </div>
        </div>
        </div>
    </section>
</main>
<!-- Footer-->
<footer class="bg-dark py-4 mt-auto">
    <div class="container px-5">
        <div class="row align-items-center justify-content-between flex-column flex-sm-row">
            <div class="col-auto"><div class="small m-0 text-white">Copyright &copy; Your Website 2023</div></div>
            <div class="col-auto">
                <a class="link-light small" href="#!">Privacy</a>
                <span class="text-white mx-1">&middot;</span>
                <a class="link-light small" href="#!">Terms</a>
                <span class="text-white mx-1">&middot;</span>
                <a class="link-light small" href="#!">Contact</a>
            </div>
        </div>
    </div>
</footer>

<div>
    <div>

    </div>

</div>


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

    $(document).ready(function(){
        $(document).on("change", "#file", function(e) {
            var files = e.target.files;
            if(files.length > 0) {
                addFiles(e);
            }
            $(this).val("");
        })
    })

    var filesTempArr = [];
    function addFiles(e) {
        var files = e.target.files;
        var filesArr = Array.prototype.slice.call(files);
        var filesArrLen = filesArr.length;
        for( var i=0; i<filesArrLen; i++ ) {
            filesTempArr.push(filesArr[i]);
        }
        console.log("filesTempArr" , filesTempArr)
    }

    function saveFile(id, field) {
        console.log("savefile", filesTempArr.length)
        let formData = new FormData();

        for(let i=0, filesTempArrLen = filesTempArr.length; i < filesTempArrLen; i++) {
            formData.append("file", filesTempArr[i]);
            console.log("formData", formData)
        }
        $.ajax({
            type: 'post',
            url : "/fileUpload/" + field + "/" + id,
            data: formData,
            processData: false,
            contentType: false,
            async: true,
            // dataType : 'json',  //왜 삭제해야하는지는 잘 모르겠어.
            success: function (data) { // 결과 성공 콜백함수
                console.log("data", data);
                // document.location.href = '/'
            },
            error: function (request, status, error) { // 결과 에러 콜백함수
                console.log("error", error)
            }
        });

    }


    function register() {
        var frm = $("#frm").serializeObject();
        console.log("frm.realName : ", frm.realName)
        let params =  {
            "realName" : frm.realName,
            "password" : frm.password,
            "gender" : frm.gender,
            "loginId" : frm.loginId,
            "phoneNumber" : frm.phoneNumber,
            "age" : frm.age,
            "nickname" : frm.nickname,
            "gender" : frm.gender,
            "email" : frm.email,
            "introduce" : frm.introduce
        }
        $.ajax({
            type : 'post',
            url : "/register",
            data : params,
            // dataType : 'json',  //왜 삭제해야하는지는 잘 모르겠어.
            success : function(data) { // 결과 성공 콜백함수
                console.log("data", data);
                saveFile(data, "user");
                document.location.href = '/'
            },
            error : function(request, status, error) { // 결과 에러 콜백함수
                console.log("error", error)
            }
        });
    }

</script>