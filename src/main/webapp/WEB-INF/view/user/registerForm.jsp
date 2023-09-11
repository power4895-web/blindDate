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
</head>
<body class="d-flex flex-column">
<main class="flex-shrink-0">
    <!-- Page content-->
    <section class="py-5">
        <div class="container px-5">
            <!-- Contact form-->
            <div class="bg-light rounded-3 py-5 px-4 px-md-5 mb-5">
                <div class="text-center mb-5">
                    <div class="feature bg-primary bg-gradient text-white rounded-3 mb-3"><i class="bi bi-envelope"></i></div>
                    <h1 class="fw-bolder">회원가입</h1>
                    <p class="lead fw-normal text-muted mb-0">Introduce yourself</p>
                </div>
                <div class="row gx-5 justify-content-center">
                    <div class="col-lg-8 col-xl-6">
                        <form action="/register" name="frm" id="frm" data-sb-form-api-token="API_TOKEN">
                            <!-- Name input-->
                            <div class="form-floating mb-3">
                                <input class="form-control" id="realName" name="realName" type="text" placeholder="Enter your realName..." data-sb-validations="required" />
                                <label for="realName">이름</label>
                                <div class="invalid-feedback" data-sb-feedback="realName:required">A realName is required.</div>
                            </div>
                            <!-- Name input-->
                            <div class="form-floating mb-3">
                                <input class="form-control" id="nickname" name="nickname" type="text" placeholder="Enter your name..." data-sb-validations="required" />
                                <label for="nickname">닉네임</label>
                                <div class="invalid-feedback" data-sb-feedback="nickname:required">A nickname is required.</div>
                            </div>
                            <!-- Name input-->
                            <div class="form-floating mb-3">
                                <input class="form-control" id="password" name="password" type="password" placeholder="Enter your name..." data-sb-validations="required" />
                                <label for="password">비밀번호</label>
                                <div class="invalid-feedback" data-sb-feedback="password:required">A password is required.</div>
                            </div>
                            <!-- Name input-->
                            <div class="form-floating mb-3">
                                <input class="form-control" id="age" name="age" type="text" placeholder="Enter your name..." data-sb-validations="required" />
                                <label for="age">나이</label>
                                <div class="invalid-feedback" data-sb-feedback="age:required">A age is required.</div>
                            </div>
                            <!-- Name input-->
                            <div class="form-floating mb-3">
                                <input class="form-control" id="gender" name="gender" type="text" placeholder="Enter your name..." data-sb-validations="required" />
                                <label for="gender">성별</label>
                                <div class="invalid-feedback" data-sb-feedback="gender:required">A gender is required.</div>
                            </div>
                            <!-- Email address input-->
                            <div class="form-floating mb-3">
                                <input class="form-control" id="email" name="email" type="email" placeholder="name@example.com" data-sb-validations="required,email" />
                                <label for="email">이메일</label>
                                <div class="invalid-feedback" data-sb-feedback="email:required">An email is required.</div>
                                <div class="invalid-feedback" data-sb-feedback="email:email">Email is not valid.</div>
                            </div>
                            <!-- ID address input-->
                            <div class="form-floating mb-3">
                                <input class="form-control" id="loginId" name="loginId" type="text" placeholder="Enter your name..." data-sb-validations="required" />
                                <label for="loginId">아이디</label>
                                <div class="invalid-feedback" data-sb-feedback="loginId:required">A loginId is required.</div>
                            </div>
                            <!-- Phone number input-->
                            <div class="form-floating mb-3">
                                <input class="form-control" id="phoneNumber" name="phoneNumber" type="tel" placeholder="(123) 456-7890" data-sb-validations="required" />
                                <label for="phoneNumber">핸드폰번호</label>
                                <div class="invalid-feedback" data-sb-feedback="phoneNumber:required">A phone number is required.</div>
                            </div>
                            <!-- Message input-->
                            <div class="form-floating mb-3">
                                <textarea class="form-control" id="introduce" name="introduce" type="text" placeholder="Enter your message here..." style="height: 10rem" data-sb-validations="required"></textarea>
                                <label for="introduce">introduce</label>
                                <div class="invalid-feedback" data-sb-feedback="introduce:required">A introduce is required.</div>
                            </div>

                            <!-- Phone number input-->
                            <div class="form-floating mb-3">
                                <input  id="file" name="file" type="file" accept=".jpg, .png, .jpeg, .hwp, .xlsx, .pdf, .docx" multiple="multiple" />
                            </div>

                            <section class="py-5">
                                <c:forEach var="item" begin="1" end="3" step="1">
                                    <div class="container px-5 my-5">
                                        <div class="row gx-5 align-items-center">
                                            <div class="col-lg-6 order-first order-lg-last">
                                                <img class="img-fluid rounded mb-5 mb-lg-0" src="https://dummyimage.com/600x400/343a40/6c757d" alt="..." id="fileList${item}_1" />
                                            </div>
                                            <div class="col-lg-6 order-first order-lg-last">
                                                <img class="img-fluid rounded mb-5 mb-lg-0" src="https://dummyimage.com/600x400/343a40/6c757d" alt="..." id="fileList${item}_2" />
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </section>

                            <div class="d-none" id="submitSuccessMessage">
<%--                                <div class="text-center mb-3">--%>
<%--                                    <div class="fw-bolder">Form submission successful!</div>--%>
<%--                                    To activate this form, sign up at--%>
<%--                                    <br />--%>
<%--                                    <a href="https://startbootstrap.com/solution/contact-forms">https://startbootstrap.com/solution/contact-forms</a>--%>
<%--                                </div>--%>
                            </div>
                            <!-- Submit error message-->
                            <!---->
                            <!-- This is what your users will see when there is-->
                            <!-- an error submitting the form-->
                            <div class="d-none" id="submitErrorMessage"><div class="text-center text-danger mb-3">Error sending message!</div></div>
<%--                            <button class="btn btn-primary "  class="btn btn-primary btn-lg disabled"  id="submitButton" onclick="register()" >가입2</button>--%>
<%--                            <div class="d-grid"><button class="btn btn-primary btn-lg" id="submitButton" onclick="register()" >가입</button></div>--%>
                            <!-- Submit Button-->
                        </form>
                        <div class="d-grid">
                            <div class="d-grid"><button class="btn btn-primary btn-lg" id="submitButton" onclick="register()" type="submit">가입</button></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</main>
<script>


    var fileNum = 0;  //추가하고자 하는 파일개수
    var reviewFileCount = 0;	//등록된 수급자 파일개수
    var fileName = $(".fileName");
    var liSize = 0; //현재 등록된 파일 개수를 담을 변수
    var totalFileSize;  //추가한 파일과 업로드 되어있는 파일개수
    $(document).ready(function(){
        $(document).on("change", "#file", function(e) {

//     	console.log("현재 업로드 되어있는 파일개수", liSize)
            var files = e.target.files;
            if(files.length > 6) {
//     		console.log("한번에 올리실수 있는 파일은 5개까지");
                alert("파일은 6개까지 올릴 수 있습니다.")
                fileNum = 0;
                return;
            }else{
                fileNum += files.length; //선택한 파일 개수    6
//     		console.log("현재 추가한 파일 개수fileNum", fileNum);
//     		console.log("현재 업로드되어있는 파일개수", liSize);

                totalFileSize = liSize + fileNum;
//     		console.log("업로드된 파일과 현재추가한 파일 총 개수", totalFileSize);
                if(totalFileSize > 6){
                    fileNum -= files.length;
//     			console.log("최종적으로 남은 선택한 파일 개수: ", fileNum);
//     			console.log("원래 파일업로드된 파일과 추가한 파일을 더한결과 5개가 넘습니다.")
                    totalFileSize = 6;  //5가 넘었을 경우 토탈카운트 다시 5로 맞춰준다.
                    alert("파일은 6개까지 올릴 수 있습니다.")
                    return;
                }
            }
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

        var filesTempArrLen = filesTempArr.length;
        var reader = new FileReader();
        var img = "";

        for( var i=0; i<filesArrLen; i++ ) {
            var tempFileName = filesArr[i].name;
            filesTempArr.push(filesArr[i]);
            img = URL.createObjectURL(filesArr[i]);
            if(filesTempArr.length == 1) {
                var hello = "fileList" + filesTempArr.length + '_' + 1;
                var hello2 = "deleteBtn" + filesTempArr.length + '_' + 1;
            }
            if(filesTempArr.length == 2) {
                var hello = "fileList" + (filesTempArr.length -1) + '_' + 2;
                var hello2 = "deleteBtn" + (filesTempArr.length -1) + '_' + 2;
            }
            if(filesTempArr.length == 3) {
                var hello = "fileList" + (filesTempArr.length -1) + '_' + 1;
                var hello2 = "deleteBtn" + (filesTempArr.length -1) + '_' + 1;
            }
            if(filesTempArr.length == 4) {
                var hello = "fileList" + (filesTempArr.length -2) + '_' + 2;
                var hello2 = "deleteBtn" + (filesTempArr.length -2) + '_' + 2;
            }
            if(filesTempArr.length == 5) {
                var hello = "fileList" + (filesTempArr.length -2) + '_' + 1;
                var hello2 = "deleteBtn" + (filesTempArr.length -2) + '_' + 1;
            }
            if(filesTempArr.length == 6) {
                var hello = "fileList" + (filesTempArr.length -3) + '_' + 2;
                var hello2 = "deleteBtn" + (filesTempArr.length -3) + '_' + 2;
            }
            console.log("hello : ", hello)
            console.log("hello2 : ", hello2)
            $("#" + hello ).attr("src", img);
            $("#" + hello ).after("<span id='" + hello2 + "'" + "><button type='button' onclick='deleteFile($(this), " + (filesTempArrLen+i) +")' style='margin:auto; display:block;'>삭제</button></span> ");
            // $("#" + hello2 ).append("<button type='button' onclick='deleteFile($(this), " + (filesTempArrLen+i) +")' style='margin:auto; display:block;'>삭제</button>");

        }
        console.log("filesTempArr" , filesTempArr)
    }

    //파일 삭제
    var deleteFile = function (self, orderParam) {
        if(confirm("이미지를 삭제하시겠습니까?") == false) { return false ;}

        console.log("deleteFile")

        for(let i=1; i<7; i++) {
            for(let j=1; j<3; j++) {
                $('#fileList' + i + '_' + j).attr("src", 'https://dummyimage.com/600x400/343a40/6c757d');
                $('#deleteBtn' + i + '_' + j).remove();
            }
        }
        console.log("orderParam", orderParam)
        filesTempArr.splice(orderParam, 1);

        var filesTempArrLen = filesTempArr.length;
        var img = "";

        console.log(">>>>filesTempArrLen" , filesTempArrLen);

        for( var i=0; i<filesTempArrLen; i++ ) {
            img = URL.createObjectURL(filesTempArr[i]);

            if(i == 0 ) {
                var hello = "fileList1_1";
                var hello2 = "deleteBtn1_1";
            }
            if(i == 1) {
                var hello = "fileList1_2";
                var hello2 = "deleteBtn1_2";
            }
            if(i ==  2) {
                var hello = "fileList2_1";
                var hello2 = "deleteBtn2_1";
            }
            if(i == 3) {
                var hello = "fileList2_2";
                var hello2 = "deleteBtn2_2";
            }
            if(i == 4) {
                var hello = "fileList3_1";
                var hello2 = "deleteBtn3_1";
            }
            if(i == 5) {
                var hello = "fileList3_2";
                var hello2 = "deleteBtn3_2";
            }
            console.log("hello : ", hello)
            console.log("hello2 : ", hello2)

            $("#" + hello ).attr("src", img);
            $("#" + hello ).after("<span id='" + hello2 + "'" + "><button type='button' onclick='deleteFile($(this), " + i +")' style='margin:auto; display:block;'>삭제</button></span> ");
        }
        fileNum--;  //현재 파일업로드 하려고 하는 개수
        console.log("fileNum", fileNum);
        totalFileSize--; //총 파일개수
        console.log("총 파일개수 totalFileSize : ", totalFileSize)
    }



    function saveFile(id, field) {
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
                document.location.href = '/'
            },
            error: function (request, status, error) { // 결과 에러 콜백함수
                console.log("error", error)
            }
        });

    }

    function register() {
        if(filesTempArr.length == 0) {
            alert("파일을 한개이상 등록하세요.")
            return;
        }

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
                // document.location.href = '/'
            },
            error : function(request, status, error) { // 결과 에러 콜백함수
                console.log("error", error)
            }

        });
    }



</script>
</body>
</html>
