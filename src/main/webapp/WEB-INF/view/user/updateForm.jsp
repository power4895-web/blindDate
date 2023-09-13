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
                    <h1 class="fw-bolder">내 정보 변경</h1>
                </div>
                <div class="row gx-5 justify-content-center">
                    <div class="col-lg-8 col-xl-6">
                        <form action="/register" name="frm" id="frm" data-sb-form-api-token="API_TOKEN">
                            <input type="hidden" id="id" name="id" value="${userInfo.id}">
                            <!-- Name input-->
                            <div class="form-floating mb-3">
                                <input class="form-control" id="realName" name="realName" value="${userInfo.realName}" type="text" placeholder="Enter your realName..." data-sb-validations="required" />
                                <label for="realName">이름</label>
                                <div class="invalid-feedback" data-sb-feedback="realName:required">A realName is required.</div>
                            </div>
                            <!-- Name input-->
                            <div class="form-floating mb-3">
                                <input class="form-control" id="nickname" name="nickname" value="${userInfo.nickname}" type="text" placeholder="Enter your name..." data-sb-validations="required" />
                                <label for="nickname">닉네임</label>
                                <div class="invalid-feedback" data-sb-feedback="nickname:required">A nickname is required.</div>
                            </div>
                            <!-- Name input-->
                            <div class="form-floating mb-3">
                                <input class="form-control" id="password" name="password" value="${userInfo.password}" type="password" placeholder="Enter your name..." data-sb-validations="required" />
                                <label for="password">비밀번호</label>
                                <div class="invalid-feedback" data-sb-feedback="password:required">A password is required.</div>
                            </div>
                            <!-- Name input-->
                            <div class="form-floating mb-3">
                                <input class="form-control" id="age" name="age" value="${userInfo.age}" type="text" placeholder="Enter your name..." data-sb-validations="required" />
                                <label for="age">나이</label>
                                <div class="invalid-feedback" data-sb-feedback="age:required">A age is required.</div>
                            </div>
                            <!-- Name input-->
                            <div class="form-floating mb-3">
                                <input class="form-control" id="gender" name="gender" value="${userInfo.gender}" type="text" placeholder="Enter your name..." data-sb-validations="required" />
                                <label for="gender">성별</label>
                                <div class="invalid-feedback" data-sb-feedback="gender:required">A gender is required.</div>
                            </div>
                            <!-- Email address input-->
                            <div class="form-floating mb-3">
                                <input class="form-control" id="email" name="email" value="${userInfo.email}" type="email" placeholder="name@example.com" data-sb-validations="required,email" />
                                <label for="email">이메일
                                    <button style="float: right" onclick="emailCheck()">인증번호 발송</button>
                                </label>
                                <div class="invalid-feedback" data-sb-feedback="email:required">An email is required.</div>
                                <div class="invalid-feedback" data-sb-feedback="email:email">Email is not valid.</div>
                            </div>
                            <!-- ID address input-->
                            <div class="form-floating mb-3">
                                <input class="form-control" id="loginId" name="loginId" value="${userInfo.loginId}" type="text" placeholder="Enter your name..." data-sb-validations="required" />
                                <label for="loginId">아이디</label>
                                <div class="invalid-feedback" data-sb-feedback="loginId:required">A loginId is required.</div>
                            </div>
                            <!-- Phone number input-->
                            <div class="form-floating mb-3">
                                <input class="form-control" id="phoneNumber" name="phoneNumber" value="${userInfo.phoneNumber}" type="tel" placeholder="(123) 456-7890" data-sb-validations="required" />
                                <label for="phoneNumber">핸드폰번호</label>
                                <div class="invalid-feedback" data-sb-feedback="phoneNumber:required">A phone number is required.</div>
                            </div>
                            <!-- Message input-->
                            <div class="form-floating mb-3">
                                <textarea class="form-control" id="introduce" name="introduce" type="text" placeholder="Enter your message here..." style="height: 10rem" data-sb-validations="required">${userInfo.introduce}</textarea>
                                <label for="introduce">introduce</label>
                                <div class="invalid-feedback" data-sb-feedback="introduce:required">A introduce is required.</div>
                            </div>

                            <!-- Phone number input-->
                            <div class="form-floating mb-3">
                                <input  id="file" name="file" type="file" accept=".jpg, .png, .jpeg, .hwp, .xlsx, .pdf, .docx" multiple="multiple" />
                            </div>


                            <section class="py-5" >
                                <c:forEach var="item" begin="1" end="3" step="1">
                                    <div class="container px-5 my-5" id="totalRemove">
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
                            </div>
                            <div class="d-none" id="submitErrorMessage"><div class="text-center text-danger mb-3">Error sending message!</div></div>
                        </form>
                        <div class="d-grid">
                            <div class="d-grid"><button class="btn btn-primary btn-lg" id="submitButton" onclick="update()" type="submit">수정</button></div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </section>

</main>
<!-- Footer-->
</body>
</html>
<script>

    var totalTempFileCount = 0;  //추가하고자 하는 총 파일개수
    var reviewFileCount = 0;	//등록된 수급자 파일개수
    var fileName = $(".fileName");
    var liSize = 0; //현재 등록된 파일 개수를 담을 변수
    var totalFileSize;  //추가한 파일과 업로드 되어있는 파일개수
    var realDataSize;  //추가한 파일과 업로드 되어있는 파일개수

    var realFile; //현재업로드된 파일리스트
    var realFileCount; //현재업로드된 파일리스트

    $(document).ready(function(){
        getFileList();
        $(document).on("change", "#file", function(e) {
            console.log("현재 DB파일개수", realFileCount)
            var files = e.target.files;
            if(files.length > 6) {
                console.log("한번에 올리실수 있는 파일은 5개까지");
                alert("파일은 6개까지 올릴 수 있습니다.")
                totalTempFileCount = 0;
                return;
            }else{
                totalTempFileCount += files.length; //선택한 파일 개수    6
                console.log("현재 추가한 파일 개수 totalTempFileCount : ", totalTempFileCount);

                totalFileSize = realFileCount + totalTempFileCount;
                console.log("업로드된 파일과 현재추가한 파일 총 개수", totalFileSize);
                if(totalFileSize > 6){
                    totalTempFileCount -= files.length;
                    console.log("최종적으로 남은 선택한 파일 개수: ", totalTempFileCount);
//     			console.log("원래 파일업로드된 파일과 추가한 /파일을 더한결과 5개가 넘습니다.")
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
        var filesArrLen = filesArr.length; //현재 임시로 올려놓은 파일개수

        var filesTempArrLen = filesTempArr.length;
        var img = "";

        for( var i=0; i<filesArrLen; i++ ) {
            filesTempArr.push(filesArr[i]);

            console.log("realFileCount DB파일개수 : ", realFileCount)
            console.log("filesTempArr.length 업로드 하려는 파일개수 : ", filesTempArr.length)

            var dataPlusTempFile = realFileCount + filesTempArr.length
            console.log("dataPlusTempFile :DB파일과 현재 업로드하려는 파일 개수: " , dataPlusTempFile)
            img = URL.createObjectURL(filesArr[i]);
            if(dataPlusTempFile == 1) {
                var hello = "fileList" + dataPlusTempFile + '_' + 1;
                var hello2 = "deleteBtn" + dataPlusTempFile + '_' + 1;
            }
            if(dataPlusTempFile == 2) {
                var hello = "fileList" + (dataPlusTempFile -1) + '_' + 2;
                var hello2 = "deleteBtn" + (dataPlusTempFile -1) + '_' + 2;
            }
            if(dataPlusTempFile == 3) {
                var hello = "fileList" + (dataPlusTempFile -1) + '_' + 1;
                var hello2 = "deleteBtn" + (dataPlusTempFile -1) + '_' + 1;
            }
            if(dataPlusTempFile == 4) {
                var hello = "fileList" + (dataPlusTempFile -2) + '_' + 2;
                var hello2 = "deleteBtn" + (dataPlusTempFile -2) + '_' + 2;
            }
            if(dataPlusTempFile == 5) {
                var hello = "fileList" + (dataPlusTempFile -2) + '_' + 1;
                var hello2 = "deleteBtn" + (dataPlusTempFile -2) + '_' + 1;
            }
            if(dataPlusTempFile == 6) {
                var hello = "fileList" + (dataPlusTempFile -3) + '_' + 2;
                var hello2 = "deleteBtn" + (dataPlusTempFile -3) + '_' + 2;
            }
            $("#" + hello ).attr("src", img);
            $("#" + hello ).after("<span id='" + hello2 + "'" + "><button type='button' class='btn btn-link' onclick='deleteFile($(this), " + (filesTempArrLen+i) +")' style='margin:auto; display:block;'>임시삭제</button></span> ");

        }
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
                document.location.href = '/'
            },
            error: function (request, status, error) { // 결과 에러 콜백함수
                console.log("error", error)
            }
        });

    }


    function update() {
        if(totalFileSize == 0) {
            alert("프로필 사진을 최소 한장 등록해주세요");
            return;
        }

        var frm = $("#frm").serializeObject();
        let params =  {
            "id" : frm.id,
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
            url : "/update",
            data : params,
            // dataType : 'json',  //왜 삭제해야하는지는 잘 모르겠어.
            success : function(data) { // 결과 성공 콜백함수
                if(data == true) {
                    if(filesTempArr.length >0) {
                        saveFile($('#id').val(), "user");
                    } else {
                        document.location.href = '/'
                    }
                }
            },
            error : function(request, status, error) { // 결과 에러 콜백함수
                console.log("error", error)
            }
        });
    }

    //파일 삭제
    function deleteFile (self, orderParam) {
        if(confirm("이미지를 삭제하시겠습니까?") == false) { return false ;}

        //삭제하는 버튼의 div안에 img를 디폴트로 만들어준다.
        $( '.btn-link:button' ).parent().parent('div').children('img').attr("src", "https://dummyimage.com/600x400/343a40/6c757d");
        //버튼의 상위 div를 없앤다(버튼없앤다)
        $( '.btn-link:button' ).parent().empty();

        //해당 임시파일 삭제
        filesTempArr.splice(orderParam, 1);

        var img = "";
        var emptyFileCount = 6 - realFileCount;  //6-3
        console.log("세팅되어야 할 개수: tempAwaitFileListCount : ", emptyFileCount)

        var emptyFileCountPlusOne = realFileCount + 1; // 3 + 1
        console.log("DB파일 이후의 순서이기 때문에 DB+1을 해줌 , emptyFileCountPlusOne : ", emptyFileCountPlusOne)
        for( var i=0; i<emptyFileCount; i++ ) {
            if(filesTempArr[i] == null) {
                img = 'https://dummyimage.com/600x400/343a40/6c757d'
            } else {
                img = URL.createObjectURL(filesTempArr[i]);
            }
            //임시파일리스트 세팅
            switch (emptyFileCountPlusOne) {
                case 1:
                    var hello = "fileList1_1";
                    var hello2 = "deleteBtn1_1";
                    $("#" + hello).attr("src", img);
                    if(filesTempArr[i] != null) {
                        $("#" + hello).after("<span id='" + hello2 + "'" + "><button type='button' class='btn btn-link' onclick='deleteFile($(this), " + i + ")' style='margin:auto; display:block;'>임시삭제</button></span> ");
                    }
                    break;
                case 2:
                    var hello = "fileList1_2";
                    var hello2 = "deleteBtn1_2";
                    $("#" + hello).attr("src", img);

                    if(filesTempArr[i] != null) {
                        $("#" + hello).after("<span id='" + hello2 + "'" + "><button type='button' class='btn btn-link' onclick='deleteFile($(this), " + i + ")' style='margin:auto; display:block;'>임시삭제</button></span> ");
                    }
                    break;
                case 3:
                    var hello = "fileList2_1";
                    var hello2 = "deleteBtn2_1";
                    $("#" + hello).attr("src", img);
                    if(filesTempArr[i] != null) {
                        $("#" + hello).after("<span id='" + hello2 + "'" + "><button type='button' class='btn btn-link' onclick='deleteFile($(this), " + i + ")' style='margin:auto; display:block;'>임시삭제</button></span> ");
                    }
                    break;
                case 4:
                    var hello = "fileList2_2";
                    var hello2 = "deleteBtn2_2";
                    $("#" + hello).attr("src", img);
                    filesTempArr[i]
                    if(filesTempArr[i] != null) {
                        console.log("임시파일 있음")
                        $("#" + hello).after("<span id='" + hello2 + "'" + "><button type='button' class='btn btn-link' onclick='deleteFile($(this), " + i + ")' style='margin:auto; display:block;'>임시삭제</button></span> ");
                    }
                    break;
                case 5:
                    var hello = "fileList3_1";
                    var hello2 = "deleteBtn3_1";
                    $("#" + hello).attr("src", img);
                    if(filesTempArr[i] != null) {
                        console.log("임시파일 있음")
                        $("#" + hello).after("<span id='" + hello2 + "'" + "><button type='button' class='btn btn-link' onclick='deleteFile($(this), " + i + ")' style='margin:auto; display:block;'>임시삭제</button></span> ");
                    }
                    break;
                case 6:
                    var hello = "fileList3_2";
                    var hello2 = "deleteBtn3_2";
                    $("#" + hello).attr("src", img);
                    if(filesTempArr[i] != null) {
                        console.log("임시파일 있음")
                        $("#" + hello).after("<span id='" + hello2 + "'" + "><button type='button' class='btn btn-link' onclick='deleteFile($(this), " + i + ")' style='margin:auto; display:block;'>임시삭제</button></span> ");
                    }
                    break;
            }
            console.log("case문 끝 emptyFileCountPlusOne +1 추가해주기")
            emptyFileCountPlusOne++;
        } //for문끝
        totalTempFileCount--;  //현재 파일업로드 하려고 하는 개수
        console.log("현재 파일업로드 하려고 하는 총 개수 totalTempFileCount", totalTempFileCount);
        totalFileSize--; //총 파일개수
        console.log("총 파일개수 totalFileSize : ", totalFileSize)
    }

    //완전 파일삭제
    function removeFile(obj, id) {
        console.log("id", id);
        console.log("totalFileSize", totalFileSize);
        if(totalFileSize == 1) {
            alert("사진 한장이상은 등록해야합니다.")
            return;
        }
        if(confirm("이미지를 완전히 삭제하시겠습니까?") == false) {return false;}
        $.ajax({
            type:"post",
            url : "/deleteFile/" + id,
            success: function(data){
                for(let i=1; i<7; i++) {
                    for(let j=1; j<3; j++) {
                        $('#fileList' + i + '_' + j).attr("src", 'https://dummyimage.com/600x400/343a40/6c757d');
                        $('#deleteBtn' + i + '_' + j).remove();
                    }
                }
                getFileList();
                // liSize--;
                console.log("현재 업로드되어있는 파일개수 totalFileSize" , totalFileSize)
            },
            error: function (request, status, error) { // 결과 에러 콜백함수
                console.log("error", error)
            }
        })
    }


    function requestSyncPostBodyJson(){
        return new Promise(function(resolve, reject){ // promise 정의
            const id = $('#id').val();
            $.ajax({
                type: 'get',
                url : "/fileUploadList/" + "user" + "/" + id,
                async: true, //비동기 여부
                timeout: 10000, //타임 아웃 설정 (1000 = 1초)
                dataType: "JSON", //응답받을 데이터 타입 (XML,JSON,TEXT,HTML,JSONP)
                contentType: "application/json; charset=utf-8", //헤더의 Content-Type을 설정
                success: function (data) { // 결과 성공 콜백함수
                    resolve(data);
                },
                error: function (request, status, error) { // 결과 에러 콜백함수
                    console.log("error", error)
                    reject(error);
                }
            });
        });
    };


    async function getFileList () {
        var realFile;  //DB 파일
        var dataFileList = []; //파일을 잠시 넣어둘 변수

        realFile = await requestSyncPostBodyJson();
        realFileCount = realFile.length;
        if(realFileCount == 0) {
            alert("최소 파일 한장을 등록해주셔야 활성화 됩니다.")
        }
        totalFileSize = realFileCount;
        var img = "";

        for(var i=0; i<realFile.length; i++) {
            dataFileList.push(realFile[i]);
            img = realFile[i].filepath + realFile[i].imageName
            if(dataFileList.length == 1) {
                var hello = "fileList" + dataFileList.length + '_' + 1;
                var hello2 = "deleteBtn" + dataFileList.length + '_' + 1;
            }
            if(dataFileList.length == 2) {
                var hello = "fileList" + (dataFileList.length -1) + '_' + 2;
                var hello2 = "deleteBtn" + (dataFileList.length -1) + '_' + 2;
            }
            if(dataFileList.length == 3) {
                var hello = "fileList" + (dataFileList.length -1) + '_' + 1;
                var hello2 = "deleteBtn" + (dataFileList.length -1) + '_' + 1;
            }
            if(dataFileList.length == 4) {
                var hello = "fileList" + (dataFileList.length -2) + '_' + 2;
                var hello2 = "deleteBtn" + (dataFileList.length -2) + '_' + 2;
            }
            if(dataFileList.length == 5) {
                var hello = "fileList" + (dataFileList.length -2) + '_' + 1;
                var hello2 = "deleteBtn" + (dataFileList.length -2) + '_' + 1;
            }
            if(dataFileList.length == 6) {
                var hello = "fileList" + (dataFileList.length -3) + '_' + 2;
                var hello2 = "deleteBtn" + (dataFileList.length -3) + '_' + 2;
            }
            $("#" + hello ).attr("src", img);
            $("#" + hello ).after("<span id='" + hello2 + "'" + "><button type='button' class='btn btn-dark' onclick='removeFile($(this), " + realFile[i].id +")' style='margin:auto; display:block;'>삭제</button></span> ");
        }
    }

</script>