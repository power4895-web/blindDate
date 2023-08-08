<%--
  Created by IntelliJ IDEA.
  User: anjdu
  Date: 2023-06-20
  Time: 오후 12:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<script src="https://code.jquery.com/jquery-1.12.4.js"></script>--%>
<%--<script src="/static/js/jquery.form.js"></script>--%>
<script type="text/javascript" src="/static/js/jquery-2.2.4.js"></script>
<script type="text/javascript" src="/static/js/commonUtil.js"></script>
    아이디: <input type="text" id="loginId" name="loginId" value="">
    비밀번호: <input type="text" id="password" name="password" value="">
<button onclick="login()">로그인</button>
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