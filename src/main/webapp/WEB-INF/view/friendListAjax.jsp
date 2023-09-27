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
    <c:forEach var="item" items="${dataList}" varStatus="status" >
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
                            <div class="text-muted">${item.addressDoro},${item.purpose}</div>
                        </div>
                        <li class="mb-2">
                            <i class="bi bi-check text-primary"></i>
                            <label>직업: </label>
                            <label>${item.job}</label>
                        </li>
                        <li class="mb-2">
                            <i class="bi bi-check text-primary"></i>
                            <label>직장: </label>
                            <label>${item.workplace}</label>
                        </li>
                        <li class="mb-2">
                            <i class="bi bi-check text-primary"></i>
                            <label>학력: </label>
                            <label>${item.academic}</label>
                        </li>
                        <li class="mb-2">
                            <i class="bi bi-check text-primary"></i>
                            <label>체형: </label>
                            <label>${item.bodyType}</label>
                        </li>
                        <li class="mb-2">
                            <i class="bi bi-check text-primary"></i>
                            <label>성격: </label>
                            <label>${item.personality}</label>
                        </li>
                        <li class="mb-2">
                            <i class="bi bi-check text-primary"></i>
                            <label>MBTI: </label>
                            <label>${item.mbti}</label>
                        </li>
                        <li class="mb-2">
                            <i class="bi bi-check text-primary"></i>
                            <label>흡연: </label>
                            <label>${item.smokingYn}</label>
                        </li>
                        <li class="mb-2">
                            <i class="bi bi-check text-primary"></i>
                            <label>음주: </label>
                            <label>${item.drinkingType}</label>
                        </li>
                        <li class="mb-2">
                            <i class="bi bi-check text-primary"></i>
                            <label>종교: </label>
                            <label>${item.religionType}</label>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </c:forEach>
</p>

</body>
</html>
