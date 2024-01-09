<%--
  Created by IntelliJ IDEA.
  User: anjdu
  Date: 2023-08-01
  Time: 오후 3:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<sec:authentication var="info" property="principal" />
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Modern Business - Start Bootstrap Template</title>
</head>
<body class="d-flex flex-column h-100">
<main class="flex-shrink-0">
    <header class="bg-dark py-5">
        <div class="container px-5">
            <div class="row gx-5 align-items-center justify-content-center">
                <div class="col-lg-8 col-xl-7 col-xxl-6">
                    <div class="my-5 text-center text-xl-start">
                        <h1 class="display-5 fw-bolder text-white mb-2">a reliable match system</h1>
                        <p class="lead fw-normal text-white-50 mb-4">99.5%로 악성, 허위 유저를 잡는 밋업의 놀라운 AI 기술력으로 안심하고 즐겨보세요</p>
                        <div class="d-grid gap-3 d-sm-flex justify-content-sm-center justify-content-xl-start">
                            <a class="btn btn-primary btn-lg px-4 me-sm-3" href="#features">장점</a>
                            <sec:authorize access="isAnonymous()">
                                <a class="btn btn-primary btn-lg px-4 me-sm-3" href="/registerForm">Sign up</a>
                                <a class="btn btn-outline-light btn-lg px-4" href="/loginForm">Sign in</a>
                            </sec:authorize>
                        </div>
                    </div>
                </div>
                <div class="col-xl-5 col-xxl-6 d-none d-xl-block text-center"><img class="img-fluid rounded-3 my-5" src="/static/files/커플.jpg" alt="..." /></div>
            </div>
        </div>
    </header>
    <!-- Features section-->
    <section class="py-5" id="features">
        <div class="container px-5 my-5">
            <div class="row gx-5">
                <div class="col-lg-4 mb-5 mb-lg-0"><h2 class="fw-bolder mb-0">장점</h2></div>
                <div class="col-lg-8">
                    <div class="row gx-5 row-cols-1 row-cols-md-2">
                        <div class="col mb-5 h-100">
                            <div class="feature bg-dark bg-gradient text-white rounded-3 mb-3"><i class="bi bi-people"></i></div>
                            <h2 class="h5">근처에서 만나기</h2>
                            <p class="mb-0">recommend someone close to me.</p>
                        </div>
                        <div class="col mb-5 h-100">
                            <div class="feature bg-dark bg-gradient text-white rounded-3 mb-3"><i class="bi bi-chat-dots"></i></div>
                            <h2 class="h5">관심사 공유</h2>
                            <p class="mb-0">share movies, games, food, everyday life, and so on.</p>
                        </div>
                        <div class="col mb-5 mb-md-0 h-100">
                            <div class="feature bg-dark bg-gradient text-white rounded-3 mb-3"><i class="bi bi-toggles2"></i></div>
                            <h2 class="h5">내게 딱 맞는 섬세한 추천</h2>
                            <p class="mb-0">Simple settings and smart recommendations.</p>
                        </div>
                        <div class="col h-100">
                            <div class="feature bg-dark bg-gradient text-white rounded-3 mb-3"><i class="bi bi-toggles2"></i></div>
                            <h2 class="h5">과금유도X</h2>
                            <p class="mb-0">Who pays to check your profile these days? Now check your profile for free on Meet Up!</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Testimonial section-->
    <div class="py-5 bg-light">
        <div class="container px-5 my-5">
            <div class="row gx-5 justify-content-center">
                <div class="col-lg-10 col-xl-7">
                    <div class="text-center">
                        <div class="fs-4 mb-4 fst-italic">"Meeting is easy and comfortable"</div>
                        <div class="d-flex align-items-center justify-content-center">
                            <img class="rounded-circle me-3" src="/static/files/40x40 고선우 증명사진.jpg" alt="..." />
                            <div class="fw-bold">
                                KSW
                                <span class="fw-bold text-primary mx-1">/</span>
                                CEO
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Blog preview section-->
    <section class="py-5" id="features2">
        <div class="container px-5 my-5">
            <div class="row gx-5 justify-content-center">
                <div class="col-lg-8 col-xl-6">
                    <div class="text-center">
                        <h2 class="fw-bolder">People like this are waiting for you</h2>
                        <p class="lead fw-normal text-muted mb-5">Show me your charms</p>
                    </div>
                </div>
            </div>
            <div class="row gx-5">
                <div class="col-lg-4 mb-5">
                    <div class="card h-100 shadow border-0">
                        <img class="card-img-top" src="/static/files/민지_430x575.jpg" alt="..." />
                        <div class="card-body p-4">
                            <div class="badge bg-primary bg-gradient rounded-pill mb-2">New</div>
                            <a class="text-decoration-none link-dark stretched-link" href="#!"><h5 class="card-title mb-3">Let's get closer together.</h5></a>
                            <i class="bi bi-check text-primary"></i>
                            <label>직업: </label>
                            <label>공무원</label><br>
                            <i class="bi bi-check text-primary"></i>
                            <label>직장: </label>
                            <label>시청</label><br>
                            <i class="bi bi-check text-primary"></i>
                            <label>학력: </label>
                            <label>고등학교</label><br>
                            <i class="bi bi-check text-primary"></i>
                            <label>체형: </label>
                            <label>슬랜더</label><br>
                            <i class="bi bi-check text-primary"></i>
                            <label>성격: </label>
                            <label>상냥한</label><br>
                            <i class="bi bi-check text-primary"></i>
                            <label>MBTI: </label>
                            <label>ISFP</label>
                        </div>
                        <div class="card-footer p-4 pt-0 bg-transparent border-top-0">
                            <div class="d-flex align-items-end justify-content-between">
                                <div class="d-flex align-items-center">
                                    <div class="small">
                                        <div class="fw-bold">Minji</div>
                                        <div class="text-muted">인천, 160cm 💘캐주얼</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 mb-5">
                    <div class="card h-100 shadow border-0">
                        <img class="card-img-top" src="/static/files/설윤2_430x575.jpg" alt="..." />
                        <div class="card-body p-4">
                            <div class="badge bg-primary bg-gradient rounded-pill mb-2">New</div>
                            <a class="text-decoration-none link-dark stretched-link" href="#!"><h5 class="card-title mb-3">I'll be waiting for you.</h5></a>
                            <i class="bi bi-check text-primary"></i>
                            <label>직업: </label>
                            <label>가수</label><br>
                            <i class="bi bi-check text-primary"></i>
                            <label>직장: </label>
                            <label>뮤직뱅크</label><br>
                            <i class="bi bi-check text-primary"></i>
                            <label>학력: </label>
                            <label>대학교</label><br>
                            <i class="bi bi-check text-primary"></i>
                            <label>체형: </label>
                            <label>마름</label><br>
                            <i class="bi bi-check text-primary"></i>
                            <label>성격: </label>
                            <label>차가움</label><br>
                            <i class="bi bi-check text-primary"></i>
                            <label>MBTI: </label>
                            <label>ISFP</label>
                        </div>
                        <div class="card-footer p-4 pt-0 bg-transparent border-top-0">
                            <div class="d-flex align-items-end justify-content-between">
                                <div class="d-flex align-items-center">
                                    <div class="small">
                                        <div class="fw-bold">Sulyoon</div>
                                        <div class="text-muted">강남, 165cm 💘캐주얼</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 mb-5">
                    <div class="card h-100 shadow border-0">
                        <img class="card-img-top" src="/static/files/카리나_430x575.png" alt="..." />
                        <div class="card-body p-4">
                            <div class="badge bg-primary bg-gradient rounded-pill mb-2">New</div>
                            <a class="text-decoration-none link-dark stretched-link" href="#!"><h5 class="card-title mb-3">Let's be neighbors.</h5></a>
                            <i class="bi bi-check text-primary"></i>
                            <label>직업: </label>
                            <label>인플루언서</label><br>
                            <i class="bi bi-check text-primary"></i>
                            <label>직장: </label>
                            <label>인스타그램</label><br>
                            <i class="bi bi-check text-primary"></i>
                            <label>학력: </label>
                            <label>대학교</label><br>
                            <i class="bi bi-check text-primary"></i>
                            <label>체형: </label>
                            <label>마른</label><br>
                            <i class="bi bi-check text-primary"></i>
                            <label>성격: </label>
                            <label>차분함</label><br>
                            <i class="bi bi-check text-primary"></i>
                            <label>MBTI: </label>
                            <label>ENTJ</label>
                        </div>
                        <div class="card-footer p-4 pt-0 bg-transparent border-top-0">
                            <div class="d-flex align-items-end justify-content-between">
                                <div class="d-flex align-items-center">
                                    <div class="small">
                                        <div class="fw-bold">Karina</div>
                                        <div class="text-muted">경기, 165cm 💘기타</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container px-5 my-5">
            <div class="row gx-5">
                <div class="col-lg-4 mb-5">
                    <div class="card h-100 shadow border-0">
                        <img class="card-img-top" src="/static/files/박보검_430x575.jpg" alt="..." />
                        <div class="card-body p-4">
                            <div class="badge bg-primary bg-gradient rounded-pill mb-2">New</div>
                            <a class="text-decoration-none link-dark stretched-link" href="#!"><h5 class="card-title mb-3">Let's get in touch.</h5></a>
                            <i class="bi bi-check text-primary"></i>
                            <label>직업: </label>
                            <label>학생</label><br>
                            <i class="bi bi-check text-primary"></i>
                            <label>직장: </label>
                            <label>학교</label><br>
                            <i class="bi bi-check text-primary"></i>
                            <label>학력: </label>
                            <label>대학교</label><br>
                            <i class="bi bi-check text-primary"></i>
                            <label>체형: </label>
                            <label>보통</label><br>
                            <i class="bi bi-check text-primary"></i>
                            <label>성격: </label>
                            <label>차분한</label><br>
                            <i class="bi bi-check text-primary"></i>
                            <label>MBTI: </label>
                            <label>ESFJ</label>
                        </div>
                        <div class="card-footer p-4 pt-0 bg-transparent border-top-0">
                            <div class="d-flex align-items-end justify-content-between">
                                <div class="d-flex align-items-center">
                                    <div class="small">
                                        <div class="fw-bold">bogum</div>
                                        <div class="text-muted">성남, 188cm 💘친구</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 mb-5">
                    <div class="card h-100 shadow border-0">
                        <img class="card-img-top" src="/static/files/송강_430x575.jpg" alt="..." />
                        <div class="card-body p-4">
                            <div class="badge bg-primary bg-gradient rounded-pill mb-2">New</div>
                            <a class="text-decoration-none link-dark stretched-link" href="#!"><h5 class="card-title mb-3">Who likes to work out?</h5></a>
                            <i class="bi bi-check text-primary"></i>
                            <label>직업: </label>
                            <label>의사</label><br>
                            <i class="bi bi-check text-primary"></i>
                            <label>직장: </label>
                            <label>병원</label><br>
                            <i class="bi bi-check text-primary"></i>
                            <label>학력: </label>
                            <label>대학원</label><br>
                            <i class="bi bi-check text-primary"></i>
                            <label>체형: </label>
                            <label>보통</label><br>
                            <i class="bi bi-check text-primary"></i>
                            <label>성격: </label>
                            <label>차분한</label><br>
                            <i class="bi bi-check text-primary"></i>
                            <label>MBTI: </label>
                            <label>INTP</label>
                        </div>
                        <div class="card-footer p-4 pt-0 bg-transparent border-top-0">
                            <div class="d-flex align-items-end justify-content-between">
                                <div class="d-flex align-items-center">
                                    <div class="small">
                                        <div class="fw-bold">Songgang</div>
                                        <div class="text-muted">경기, 175cm 💘친구</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 mb-5">
                    <div class="card h-100 shadow border-0">
                        <img class="card-img-top" src="/static/files/차은우2_430x575.jpg" alt="..." />
                        <div class="card-body p-4">
                            <div class="badge bg-primary bg-gradient rounded-pill mb-2">New</div>
                            <a class="text-decoration-none link-dark stretched-link" href="#!"><h5 class="card-title mb-3">I like drinking.</h5></a>
                            <i class="bi bi-check text-primary"></i>
                            <label>직업: </label>
                            <label>헬스트레이너</label><br>
                            <i class="bi bi-check text-primary"></i>
                            <label>직장: </label>
                            <label>헬스장</label><br>
                            <i class="bi bi-check text-primary"></i>
                            <label>학력: </label>
                            <label>대학교</label><br>
                            <i class="bi bi-check text-primary"></i>
                            <label>체형: </label>
                            <label>근육</label><br>
                            <i class="bi bi-check text-primary"></i>
                            <label>성격: </label>
                            <label>착한</label><br>
                            <i class="bi bi-check text-primary"></i>
                            <label>MBTI: </label>
                            <label>ISFP</label>
                        </div>
                        <div class="card-footer p-4 pt-0 bg-transparent border-top-0">
                            <div class="d-flex align-items-end justify-content-between">
                                <div class="d-flex align-items-center">
                                    <div class="small">
                                        <div class="fw-bold">Eunwoo</div>
                                        <div class="text-muted">전북, 180cm 💘연애</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Call to action-->
            <aside class="bg-primary bg-gradient rounded-3 p-4 p-sm-5 mt-5">
                <div class="d-flex align-items-center justify-content-between flex-column flex-xl-row text-center text-xl-start">
                    <div class="mb-4 mb-xl-0">
                        <div class="fs-3 fw-bold text-white">Get out. Together.</div>
                        <div class="text-white-50">Simply sign up for membership.</div>
                    </div>
                    <div class="ms-xl-2">
                        <a class="btn btn-outline-light" href="/registerForm">Sign up</a>
                    </div>
                </div>
            </aside>
        </div>
    </section>
</main>
</body>

<script>
    $(document).ready(function (){
        console.log("====main_Notification.permission", Notification.permission)
        // 브라우저가 알림(notifications)를 지원하는지 확인
        if (!("Notification" in window)) {
            alert("브라우저가 notification을 지원하지 않음");
        }
        // 알림 허용이 되었는지 확인
        else if (Notification.permission === "granted") {
            // notification 생성
            var notification = new Notification("알람을 받습니다.");
            setTimeout(() => {
                notification.close();
            }, 3000);
        }
        // 사용자가 최초 웹전근시 default일 때, 사용자가 허용으로 바꿨을 경우
        else if (Notification.permission !== 'denied') {
            Notification.requestPermission().then((permission) => {
                console.log("permission", permission)
                // handlePermission(permission);
                // 사용자가 허용하면 알림 띄우기
                if (permission === "granted") {
                    var notification = new Notification("알림 메세지를 받습니다.");
                    setTimeout(() => {
                        notification.close();
                    }, 10 * 1000);
                }
            });
        }
    })

</script>
