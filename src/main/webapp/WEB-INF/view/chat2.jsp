<script type="text/javascript" src="/static/js/jquery-2.2.4.js"></script>
<head>
    <meta charset="utf-8">
</head>
        <div class="chat-content">
            <!-- 메시지 시작 날짜 -->
            <div class="date-line">
                <time datetime="2021-03-29">2021년 3월 29일 월요일</time>
            </div>
            <!-- 채팅 내용 -->
            <div class="main-chat">
                <div class="friend-chat">
                    <img class="profile-img" src="./pic/default.png" alt="쀼프로필사진">
                    <div class="friend-chat-col">
                        <span class="profile-name">쀼사원</span>
                        <span class="balloon">대리님, 혹시 7시50분에 시간 괜찮으세요?</span>
                        <span class="balloon">저와 커피 한잔 해주실 수 있으실까요? ㅜㅜ</span>
                    </div>
                    <time datetime="07:30:00+09:00">오전 7:30</time>
                </div>
                <div class="me-chat">
                    <div class="me-chat-col">
                        <span class="balloon">ㅇㅋ</span>
                    </div>
                    <time datetime="07:32:00+09:00">오전 7:32</time>
                </div>
                <div class="me-chat">
                    <div class="me-chat-col">
                        <span class="balloon">그런데 무슨일있어요?</span>
                    </div>
                    <time datetime="07:33:00+09:00">오전 7:33</time>
                </div>
                <div class="friend-chat">
                    <img class="profile-img" src="./pic/default.png" alt="쀼프로필사진">
                    <div class="friend-chat-col">
                        <span class="profile-name">쀼사원</span>
                        <span class="balloon">아니요 별일은 아니에요.</span>
                        <span class="balloon">상담을 좀 하고 싶어서요.</span>
                        <span class="balloon">커피는 제가 사겠습니다!</span>
                    </div>
                    <time datetime="07:35:00+09:00">오전 7:35</time>
                </div>
                <div class="me-chat">
                    <div class="me-chat-col">
                        <span class="balloon">내가 살게요.</span>
                    </div>
                    <time datetime="07:36:00+09:00">오전 7:36</time>
                </div>
                <div class="me-chat">
                    <div class="me-chat-col">
                        <span class="balloon">ㄱㄱ</span>
                    </div>
                    <time datetime="07:49:00+09:00">오전 7:49</time>
                </div>
                <div class="friend-chat">
                    <img class="profile-img" src="./pic/default.png" alt="쀼프로필사진">
                    <div class="friend-chat-col">
                        <span class="profile-name">쀼사원</span>
                        <span class="balloon">이제 쓸말도 떨어졌다. 근데 테스트는 계속해야하니까 글을 일단 길게 써보자.</span>
                        <span class="balloon">1초라도 안보이면 2렇게 초초한데 3초는 어떻게 기다려 이야이야이야이야 4랑해 널 사랑해 5늘은 말할거야</span>
                    </div>
                    <time datetime="09:00:00+09:00">오전 9:00</time>
                </div>
                <div class="me-chat">
                    <div class="me-chat-col">
                        <span class="balloon">6십억 지구에서 널 만난건 7(럭키)야. 이제 정말 쓸 말이 떨어졌다.</span>
                    </div>
                    <time datetime="09:30:00+09:00">오전 9:30</time>
                </div>
                <div class="friend-chat">
                    <img class="profile-img" src="./pic/default.png" alt="쀼프로필사진">
                    <div class="friend-chat-col">
                        <span class="profile-name">쀼사원</span>
                        <span class="balloon">대리님! 회의 끝나시면 연락 부탁드립니다!</span>
                    </div>
                    <time datetime="10:15:00+09:00">오전 10:15</time>
                </div>
            </div>
        </div>

<script>
    $( window ).on( "scroll", function() {
        var scrollPosition = $(window).scrollTop();

        var documentHeight = $(document).height();

        var windowHeight = $(window).height();
        console.log("scrollPosition", scrollPosition)
        console.log("documentHeight", documentHeight)
        console.log("windowHeight", windowHeight)
        if (scrollPosition + windowHeight >= documentHeight) {
            console.log(">>>>>>>>>>>>>>>>>!");
        }
    } );
</script>