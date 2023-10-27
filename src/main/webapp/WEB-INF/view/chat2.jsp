<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>on demo</title>
    <style>
        div {
            color: blue;
        }
        p {
            color: green;
        }
        span {
            color: red;
            display: none;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
</head>
<body>

<div>Try scrolling the iframe.</div>
<div>Try scrolling the iframe.</div>
<div>Try scrolling the iframe.</div>
<div>Try scrolling the iframe.</div>
<div>Try scrolling the iframe.</div>
<div>Try scrolling the iframe.</div>
<div>Try scrolling the iframe.</div>
<div>Try scrolling the iframe.</div>
<div>Try scrolling the iframe.</div>
<div>Try scrolling the iframe.</div>
<div>Try scrolling the iframe.</div>
<div>Try scrolling the iframe.</div>
<div>Try scrolling the iframe.</div>
<div>Try scrolling the iframe.</div>
<div>Try scrolling the iframe.</div>
<div>Try scrolling the iframe.</div>
<div>Try scrolling the iframe.</div>
<div>Try scrolling the iframe.</div>
<div>Try scrolling the iframe.</div>
<div>Try scrolling the iframe.</div>
<div>Try scrolling the iframe.</div>
<p>Paragraph - <span>Scroll happened!</span></p>

<script>
    $( "p" ).clone().appendTo( document.body );
    $( "p" ).clone().appendTo( document.body );
    $( "p" ).clone().appendTo( document.body );
    $( window ).on( "scroll", function() {
        $( "span" ).css( "display", "inline" ).fadeOut( "slow" );
        // 현재 스크롤 위치
        var scrollPosition = $(window).scrollTop();

        // 문서의 높이
        var documentHeight = $(document).height();

        // 윈도우의 높이
        var windowHeight = $(window).height();
        console.log("scrollPosition", scrollPosition)
        console.log("documentHeight", documentHeight)
        console.log("windowHeight", windowHeight)
        if (scrollPosition + windowHeight >= documentHeight) {
            // 맨 마지막 스크롤 이벤트가 발생했습니다.
            console.log(">>>>>>>>>>>>>>>>>!");
        }


    } );
</script>

</body>
</html>