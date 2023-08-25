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
<script type="text/javascript" src="/static/js/jquery-2.2.4.js"></script>
<script type="text/javascript" src="/static/js/jquery.simplePagination.js"></script>
<link type="text/css" rel="stylesheet" href="/static/css/simplePagination.css"/>

   <div>
       <h2>boardList</h2>
       <title>Title</title>

       <!--  검색영역 Star -->
       <div>
           <form name="frm" id="frm" action="" method="POST">
               <input type="hidden" name="page" id="page" value="${board.page }">
           </form>
       </div>

       <table style="width:100%;"  border="2">
           <colgroup>
               <col style="width:1%">
               <col style="width:500px">
               <col style="width:80px">
               <col style="width:80px">
           </colgroup>
           <thead>
               <tr>
                   <th>No</th>
                   <th>제목</th>
                   <th>작성자</th>
                   <th>작성일</th>
               </tr>
           </thead>
           <tbody>
           <div>Total : ${board.totalRow } [${board.page } /${board.totalPage }]</div>
           <c:forEach var="item" items="${boardList}" varStatus="status">
               <tr>
<%--                   전체개수 - 페이지-1 * 페이지당게시글개수 + index--%>
                   <td>${board.totalRow - ((board.page-1) * board.rowSize + status.index)}</td>
                   <td>
                       <a href="javascript:void(0); view(${item.id})">${item.title}</a>
                   </td>
                   <td>${item.loginId}</td>
                   <td>
                       <fmt:formatDate value="${item.createDate}" pattern="yyyy-MM-dd"/> <br>
                   </td>
               </tr>
           </c:forEach>
           </tbody>
       </table>
       <div id="pageNav" style="  position: relative; padding: 1% 10% 0% 45%;" ></div>
       <button style="float: right;" onclick = "location.href = '/board/form' ">글쓰기</button>
   </div>
<script>

    $(document).ready(function(){
        console.log(">>:", ${board.rowSize})
        //페이징
        $("#pageNav").pagination({
            items : ${board.totalRow }, 			   //총로우개수
            itemsOnPage : ${board.rowSize},
            currentPage : ${board.page},
            cssStyle: 'dark-theme',
            onPageClick : function(pageNumber,event){
                goPage(pageNumber)
            }
        });


    });

    function search(){
        $("#page").val(1)
        document.frm.action = "/board/list";
        document.frm.submit();
    }

    function goPage(p){
        $("#page").val(p)
        document.frm.action = "/board/list";
        document.frm.submit();
    }

    function save(){
        document.location.href = "/board/insert/form";
    }


    function view(id){
        // console.log(">>id", id)
        document.location.href = "/board/view/" + id;
        // document.frm.action = "/board/view"
        // $("#id").val(id);
        // document.frm.submit();
    }

</script>