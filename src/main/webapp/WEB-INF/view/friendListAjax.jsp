<%--
  Created by IntelliJ IDEA.
  User: anjdu
  Date: 2023-09-25
  Time: 오전 11:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<p id="indexListAjax">
    <c:if test="${relationshipList != null}">
        <div class="mb-1">
            <p class="lead fw-semibold text-muted mb-0">내가 친구해요를 보낸 이성  <i class="bi bi-heart-fill" style="color: red"></i></p>
        </div>
    </c:if>
    <c:forEach var="item" items="${relationshipList}" varStatus="status" >
        <div class="col-lg-6 col-xl-4">
            <div class="card mb-5 mb-xl-0">
                <div class="card-body p-0">
                    <div class="mb-3">
                        <img class="card-img-top" src="${item.imgUrl}" alt="..." />
                    </div>
                    <ul class="list-unstyled mb-4">
                        <div class="small">
                            <div class="fw-bold">
                                <a href="/user/view/${type == 'relationship' ? item.getId : item.receiveId}">${item.nickname}, ${item.age}</a>
                            </div>
                            <div class="text-muted">
                                <i class="bi bi-geo-alt-fill"></i>${item.addressDoro}
                                <i class="bi bi-rulers"></i>${item.height}cm
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-through-heart-fill" viewBox="0 0 16 16">
                                    <path fill-rule="evenodd" d="M2.854 15.854A.5.5 0 0 1 2 15.5V14H.5a.5.5 0 0 1-.354-.854l1.5-1.5A.5.5 0 0 1 2 11.5h1.793l3.103-3.104a.5.5 0 1 1 .708.708L4.5 12.207V14a.5.5 0 0 1-.146.354l-1.5 1.5ZM16 3.5a.5.5 0 0 1-.854.354L14 2.707l-1.006 1.006c.236.248.44.531.6.845.562 1.096.585 2.517-.213 4.092-.793 1.563-2.395 3.288-5.105 5.08L8 13.912l-.276-.182A23.825 23.825 0 0 1 5.8 12.323L8.31 9.81a1.5 1.5 0 0 0-2.122-2.122L3.657 10.22a8.827 8.827 0 0 1-1.039-1.57c-.798-1.576-.775-2.997-.213-4.093C3.426 2.565 6.18 1.809 8 3.233c1.25-.98 2.944-.928 4.212-.152L13.292 2 12.147.854A.5.5 0 0 1 12.5 0h3a.5.5 0 0 1 .5.5v3Z"/>
                                </svg>${item.purpose}
                            </div>
                        </div>
                    </ul>
                </div>
            </div>
        </div>
    </c:forEach>
    <c:if test="${evaluationList != null}">
        <div class="mb-1">
            <p class="lead fw-semibold text-muted mb-0">내가 높은점수를 준 이성 <i class="bi bi-star-fill" style="color: orange"></i></p>
        </div>
    </c:if>
    <c:forEach var="item" items="${evaluationList}" varStatus="status" >
        <div class="col-lg-6 col-xl-4">
            <div class="card mb-5 mb-xl-0">
                <div class="card-body p-0">
                    <div class="mb-3">
                        <img class="card-img-top" src="${item.imgUrl}" alt="..." />
                    </div>
                    <ul class="list-unstyled mb-4">
                        <div class="small">
                            <div class="fw-bold">
                                <a href="/user/view/${type == 'relationship' ? item.getId : item.receiveId}">${item.nickname}, ${item.age}</a>
                            </div>
                            <div class="text-muted">
                                <i class="bi bi-geo-alt-fill"></i>${item.addressDoro}
                                <i class="bi bi-rulers"></i>${item.height}cm
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-through-heart-fill" viewBox="0 0 16 16">
                                    <path fill-rule="evenodd" d="M2.854 15.854A.5.5 0 0 1 2 15.5V14H.5a.5.5 0 0 1-.354-.854l1.5-1.5A.5.5 0 0 1 2 11.5h1.793l3.103-3.104a.5.5 0 1 1 .708.708L4.5 12.207V14a.5.5 0 0 1-.146.354l-1.5 1.5ZM16 3.5a.5.5 0 0 1-.854.354L14 2.707l-1.006 1.006c.236.248.44.531.6.845.562 1.096.585 2.517-.213 4.092-.793 1.563-2.395 3.288-5.105 5.08L8 13.912l-.276-.182A23.825 23.825 0 0 1 5.8 12.323L8.31 9.81a1.5 1.5 0 0 0-2.122-2.122L3.657 10.22a8.827 8.827 0 0 1-1.039-1.57c-.798-1.576-.775-2.997-.213-4.093C3.426 2.565 6.18 1.809 8 3.233c1.25-.98 2.944-.928 4.212-.152L13.292 2 12.147.854A.5.5 0 0 1 12.5 0h3a.5.5 0 0 1 .5.5v3Z"/>
                                </svg>${item.purpose}
                            </div>
                        </div>
                    </ul>
                </div>
            </div>
        </div>
    </c:forEach>
</p>

</body>
</html>
