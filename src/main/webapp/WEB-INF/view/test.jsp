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
                <div class="card-body p-5">
                    <div class="mb-3">
                        <img class="card-img-top" src="${item.imgUrl}" alt="..." />
                    </div>
                    <ul class="list-unstyled mb-4">
                        <div class="small">
                            <div class="fw-bold">${item.nickname}, ${item.age}</div>
                            <div class="text-muted">${item.job},${item.purpose}</div>
                        </div>
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
                </div>
            </div>
        </div>
    </c:forEach>
</p>

</body>
</html>
