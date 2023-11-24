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
    <c:if test="${field == 'relationship' || field == 'total'}">
        <c:if test="${relationshipList != null}">
<%--            css가 meet up위치가 변경되어 임시적으로 추가--%>
            <div class="col-lg-6 col-xl-4">
            </div>
            <div class="mb-1">
                <p class="lead fw-semibold text-muted mb-0">내가 친구해요를 ${type == 'send' ? '보낸' :  '받은'} 이성  <i class="bi bi-heart-fill" style="color: red"></i></p>
            </div>
        </c:if>
        <c:if test="${relationshipList == null}">

            <div class="col-lg-6 col-xl-4">
            </div>
            <div class="mb-1">
                <p class="lead fw-semibold text-muted mb-0">친구해요를 보낸 이성이 없습니다. 이성에게 먼저 다가가보세요.  <i class="bi bi-heart-fill" style="color: red"></i></p>
            </div>
        </c:if>
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
                                <a style="color: black" href="/user/view/${type == 'send' ? item.getId : item.sendId}/${type}">${item.nickname}, ${item.age}</a>
                            </div>
                            <div class="text-muted">
                                <i class="bi bi-geo-alt-fill"></i>${item.address}・${item.distance == 0.0 ? '측정불가' : item.distance}${item.distance == 0.0 ? '' : 'km'},
<%--                                <i class="bi bi-geo-alt-fill"></i>${item.addressDoro}--%>
                                <i class="bi bi-rulers"></i>${item.height}cm
                                💘${item.purpose}
                            </div>
                        </div>
                    </ul>
                </div>
            </div>
        </div>
    </c:forEach>
    <br><br>
    <c:if test="${field == 'evaluation' || field == 'total'}">
        <c:if test="${evaluationList != null}">
            <div class="mb-1">
                <p class="lead fw-semibold text-muted mb-0">${type == 'send' ? '내가' :  '내게'}  높은점수를 준 이성  <i class="bi bi-heart-fill" style="color: red"></i></p>
            </div>
        </c:if>
        <c:if test="${evaluationList == null}">
            <div class="mb-1">
                <p class="lead fw-semibold text-muted mb-0">호감을 ${type == 'send' ? '보낸이성이 없습니다. 호감을 표현하세요.' :  '받은 이성이 없습니다.'}    <i class="bi bi-heart-fill" style="color: red"></i></p>
            </div>
        </c:if>
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
                                <a style="color: black" href="/user/view/${type == 'send' ? item.receiveId : item.evaluationId}/${type}">${item.nickname}, ${item.age}</a>
                            </div>
                            <div class="text-muted">
                                <i class="bi bi-geo-alt-fill"></i>${item.address}・${item.distance == 0.0 ? '측정불가' : item.distance}${item.distance == 0.0 ? '' : 'km'},
<%--                                <i class="bi bi-geo-alt-fill"></i>${item.addressDoro}--%>
                                <i class="bi bi-rulers"></i>${item.height}cm
                                💘${item.purpose}
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
