<%--
  Created by IntelliJ IDEA.
  User: anjdu
  Date: 2023-06-30
  Time: 오후 3:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>ㅁ
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" src="/static/js/jquery-2.2.4.js"></script>
<script type="text/javascript" src="/static/js/jquery.simplePagination.js"></script>
<link type="text/css" rel="stylesheet" href="/static/css/simplePagination.css"/>

   <div>
       <h2>boardList</h2>
       <title>Title</title>

       <!--  검색영역 Star -->
       <div>
           <form name="frm" id="frm" method="POST">
               <input type="hidden" name="id" id="id" value="${boardInfo.id}">
           </form>
       </div>

       <table style="width:100%" border="3">
           <tbody>
           <tr>
               <th >제목</th>
               <td >${boardInfo.title}</td>
           </tr>
           <tr>
               <th >내용</th>
               <td>
                   ${boardInfo.content}
               </td>
           </tr>
           <tr>
               <th>날짜</th>
               <td>
                   <fmt:formatDate value="${boardInfo.createDate}" pattern="yyyy-MM-dd"/> <br>
               </td>
           </tr>
           </tbody>

           <colgroup>
               <col width="5%">
               <col width="50%">
           </colgroup>
       </table>
       <button onclick="updateForm()">수정</button>
       <button onclick="deleteBoard()">삭제</button>
<%--       <button onclick="location.href='/board/delete/' + ${boardInfo.id}">삭제</button>--%>

       <div id="pageNav"></div>
   </div>
<script>

    $(document).ready(function(){


    });

    function updateForm() {
        document.frm.action = "/board/form"
        document.frm.submit();
    }
    function deleteBoard() {
        document.frm.action = "/board/delete"
        document.frm.submit();
    }


</script>