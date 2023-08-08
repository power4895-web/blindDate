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
       <h2>form</h2>
       <!--  검색영역 Star -->
       <div>
           <form name="frm" id="frm" action="/board/insert" method="POST" enctype="multipart/form-data">
               <input type="hidden" name="id" value="${boardInfo.id}">
               <table style="width:100%" border="3">
                   <colgroup>
                       <col style="width:50px">
                       <col style="width:500px">
                       <col style="width:500px">
                   </colgroup>
                   <tbody>
                   <tr>
                       <th scope="row">제목 </th>
                       <td>
                           <input style="width:100%" name="title" value="${boardInfo.title}"/>
                       </td>
                   </tr>
                   <tr>
                       <th scope="row">내용 </th>
                       <td>
                       <textarea style="width:100%" name="content">
                           ${boardInfo.content}
                       </textarea>
                       </td>
                   </tr>
                   <tr>
                       <td>
                           <input type="file" name="file">
                       </td>
                   </tr>
                   </tbody>
               </table>
           </form>
       </div>
       <c:if test="${boardInfo.id != null}">
           <button onclick="update()">수정</button>
       </c:if>
       <c:if test="${boardInfo == null}">
           <button onclick="save()">등록</button>
       </c:if>
       <button onclick="location.href='/board/list'">목록</button>
   </div>
<script>

    $(document).ready(function(){


    });

    function save() {
        document.frm.action = "/board/insert"
        document.frm.submit();
    }
    function update() {
        document.frm.action = "/board/update"
        document.frm.submit();
    }
</script>