var com = {
	/**
	 * 숫자 체크
	 */
	isNumber : function(str){
		var reg =  /^[0-9]+$/ ;
		return reg.test(str);
	},
	
	/**
	 * 메일 체크
	 */
	isEmail : function(str){
		var reg = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/ ;
		return reg.test(str);
	},
	
	/**
	 * Ajax 요청
	 */
	requestAjax : function(obj, callbackFnc){
		console.log("obj.params", obj.params)
		var options = {
				type : "GET", 
				async : true,
				traditional : true,
				data : obj.params,
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", "true");
			    },
		        success : function(response){
		        	data = response;
					console.log("data", data)
		        	if( typeof callbackFnc ===  "function") callbackFnc(data);
		        },   
		        error : function(xhr) {
					alert("에이작스 에러")
		        	if(xhr.status == "403"){
		        		document.location.href = "/login";
		        	}else{
		    	        alert("시스템에러 : " + xhr.status);
			       	}
		        }
			};
		$.extend(options, obj);
		$.ajax(options);
		
	},
	

	
	/**
	 * Ajax 파일업로드 
	 */
	requestFileAjax : function(obj, callbackFnc){
		
		 $.ajax({      
			type : "POST",
			async : obj.async,
			url : obj.url,
			data : obj.data,
			processData: false,
			contentType: false,
	        beforeSend : function(xhr){
				xhr.setRequestHeader("AJAX", "true");
		    },
	        success : function(response){   
	        	data = response;
	        	if( typeof callbackFnc ===  "function") callbackFnc(data);
	        },   
	        error : function(xhr) {
	        	if(xhr.status == "403"){
	        		document.location.href = "/login";
	        	}else{
//	    	        alert("시스템에러 : " + xhr.status);
		       	}
	        }
	    });  
	 
	},

	
	/**
	 * 폼 Validation 체크
	 */
	validation : function(selector) {
		var result = true;
		
		$(selector).find(".required").each(function(idx){
			
			var value = "";
			
			var $this = $(this);
			var $tdObj = $this.next();
			var $obj = $tdObj.find('input, select, textarea');
				
			if($obj.length < 1) return result;
			
			if( $obj.attr("type") == "radio" ){
				$obj = $tdObj.find( 'input[id=' + $obj.attr("id") + ']' );
				for( var i = 0; i < $obj.length; i++){
					if( $obj[i].checked ) value = "checked";				
				}
			}else{
				if( typeof $obj[0].getValue == 'function' ){
					value = $obj[0].getValue();
				}else{
					value = $obj.val();
				}
			}
			
			if( value == undefined || value == "" ){
				alert($this.text() +  " 값은 필수입니다.");
				$obj.focus();
				result = false;
				return false;
			}
			
		});
		
		return result;
	},
	
	
	 formatBytes : function(a,b){
		if(0==a)return"0 Bytes";
		var c=1024,
		d=b||2,e=["Bytes","KB","MB","GB","TB","PB","EB","ZB","YB"],
		f=Math.floor(Math.log(a)/Math.log(c));
		return parseFloat((a/Math.pow(c,f)).toFixed(d))+" "+e[f]
	},
	
	formatNumber : function(p){
	    return p.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	},
	setFormatNumber : function(obj){
		$(obj).val( $(obj).val().replace(/,/g,'').replace(/\B(?=(\d{3})+(?!\d))/g, ",") );
	},

	/**
	 * 날자 변환
	 * yyyy-MM-dd, yyyy-MM-dd HH:mm:ss, yyyy-MM-dd a/p hh:mm:ss, yyyy-MM-dd E
	 * @param {날짜 Date} format
	 * @returns
	 */
	getDate: function (format, date) {

		if (date == null) return "";

		let weekName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
		let d = new Date(date);
		let h;
		String.prototype.string = function (len) {
			var s = '', i = 0;
			while (i++ < len) {
				s += this;
			}
			return s;
		};
		String.prototype.zf = function (len) {
			return "0".string(len - this.length) + this;
		};
		Number.prototype.zf = function (len) {
			return this.toString().zf(len);
		};

		return format.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function ($1) {
			switch ($1) {
				case "yyyy":
					return d.getFullYear();
				case "yy":
					return (d.getFullYear() % 1000).zf(2);
				case "MM":
					return (d.getMonth() + 1).zf(2);
				case "dd":
					return d.getDate().zf(2);
				case "E":
					return weekName[d.getDay()];
				case "HH":
					return d.getHours().zf(2);
				// case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2);
				case "hh":
					return ((h = d.getHours() % 12) ? h : 12);
				case "mm":
					return d.getMinutes().zf(2);
				case "ss":
					return d.getSeconds().zf(2);
				case "a/p":
					return d.getHours() < 12 ? "오전" : "오후";
				default:
					return $1;
			}
		});
	},

	//datetime 데이터를 스트링으로 변환
	fromDateToString : function (date) {
		var monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
		var dateString = date;
		var dateParts = dateString.split(' ');
		// console.log(">>>", dateParts);
		var year = parseInt(dateParts[5]);
		var month = monthNames.indexOf(dateParts[1]) + 1;
		var day = parseInt(dateParts[2]);
		// 결과 출력
		// console.log("년: " + year);
		// console.log("월: " + month);
		// console.log("일: " + day);


		// 콜론(:)을 기준으로 문자열을 분리
		var timeParts = dateParts[3].split(':');

		// 시간, 분, 초 추출
		var hour = parseInt(timeParts[0]);
		var minute = parseInt(timeParts[1]);
		let minutes = (minute < 10) ? '0' + minute : minute;

		var second = parseInt(timeParts[2]);

		// console.log("시간: " + hour);
		// console.log("분: " + minutes);
		// console.log("초: " + second);

		var dateTime = {
			year : year,
			month : month,
			day : day,
			hour : hour,
			minute : minute,
			second : second
		}


		return dateTime;
	},



	bytesToSize : function(bytes) {
		   var sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB'];
		   if (bytes == 0) return '0 Byte';
		   var i = parseInt(Math.floor(Math.log(bytes) / Math.log(1024)));
		   return Math.round(bytes / Math.pow(1024, i), 2) + ' ' + sizes[i];
	},
	
	/**
	 *  리스트 데이터 Object  MVC 에서 받을 수 있는 Object  로 변환
	 *  dataList[0].dataTitle : 'abcd'
	 *  dataList[1].dataTitle : 'efgh'
	 *  ...
	 */
	converListToObject : function(name, objList){
		
		var obj = {};
		$(objList).each(function(i,val){
		    $.each(val,function(k,v){
		        obj[name + "[" + i + "]." + k] = v;
			});
		    
		});
		//console.log( obj )
		return obj
		
	},
	
	/**
	 * textarea 높이 내용에 맞게 조정
	 */
	autoHeight : function(obj){
		$(obj).height( $(obj).prop("scrollHeight") + 16)
	},
	
	
	/**
	 * //날짜 셀렉트박스 값에 년,월 세팅
	 */
	setDate : function(){
		// 시작할 년도 
		var today = new Date(); 
		var startYear = today.getFullYear();
	    var month = today.getMonth() + 1;  // 월
	    var date = today.getDate();  // 일
	    //전년도 설정
		var beforeYear=today.getFullYear() - 1;
		var index = 0; 
			//시작날짜 옵션에 16~21년까지 데이터 생성
			2021 >= 2016
//	 					2021		2021	>= 2016
			for(var y=beforeYear-5; y<=startYear; y++){ 
					//startYear ~ 현재 년도 
					$("#startSelectYear").append(new Option(y, y));
			} 
			index=0; 
			//시작날짜 옵션에 월 1~12개 데이터 생성
			for(var m=1; m<=12; m++){ 
				$("#startSelectMonth").append(new Option(m, m));
			}
			//시작일(date) 세팅
			$("#startSelectYear").val(startYear);
			$("#startSelectMonth").val(month);
			var startTime = com.startLastDay(); 
			
			
//			==============종료=================
			//종료날짜 옵션에 16~21년까지 데이터 생성
			var index=0; 
			for(var y=beforeYear; y<=startYear+10; y++){ 
					//startYear ~ 현재 년도 
					$("#endSelectYear").append(new Option(y, y));
			} 
			index=0; 
			//종료날짜 옵션에 월 1~12개 데이터 생성
			for(var m=1; m<=12; m++){ 
				$("#endSelectMonth").append(new Option(m, m));
			} 

			//종료일 세팅
			$("#endSelectYear").val(startYear);
			$("#endSelectMonth").val(month);
			$("#endSelectDay").val(date);
			var endTime = com.endLastDay();
			//화면 들어왔을 때 셀렉트박스에 오늘날짜 값 세팅
			return endTime;
	},
	
	/**
	 * 시작날짜 변경 이벤트
	 * 시작셀렉트박스의 년월에 대한 마지막 날짜 구함
	 * month는 0부터 시작한다.
	 */
	
	//month는 0부터 시작한다. 0이 1월 ,  시작날짜 이벤트, 년,월에 대한 일 세팅
	startLastDay : function(){
		//선택한 년도
		var Year=$('#startSelectYear').val(); 
		
		//선택한 월
		var Month = ('0' + $('#startSelectMonth').val()).slice(-2);  //1,2월을 01,02로

		//이걸 풀이하면 new date(2021, 11, 1) =>는 곧 2021-12-01을 말한다. month의 11은 12월이기 때문에, 2021-12-01의 하루전날은 11월의 마지막날일것이고 그걸 getdate했기 때문에 마지막날자가 구해진다.
		var day = new Date(new Date(Year,Month,1) - 24 * 60 * 60 * 1000 ).getDate(); 
//		console.log("startLastDay 해당월의 마지막 날짜 : ", day)  
		
		//1월이 31일까지 있고 2월을 선택했을 때, 1월이 31일까지 있기 때문에 dayindex는 31일이다. 하지만 day가 마지막날이 28일이라 else if로 타게 된다.
		//날짜를 변경하기 전달의 총날짜 개수
		var dayindex_len=document.getElementById('startSelectDay').length; 
		if(day>dayindex_len){ 
//			console.log("0일까지 있는 월에서 31까지 있는 월을 선택했을 때") 
			for(var i=(dayindex_len+1); i<=day; i++){ 
				$("#startSelectDay").append(new Option(i, i));
			} 
		}else if(day<dayindex_len){ 
//			console.log("31일까지 있는 월에서 30까지 있는 월을 선택했을 때")  
			//10월 31일 인 상태에서 2월을 선택햇을 때 28일까지밖에, 11월은 30일에서 12월을 선택했을 때, 31일까지 보여줘야 하기때문에 리셋
			for(var i=dayindex_len; i>=day; i--){ 
				$('#startSelectDay option:eq(' + i + ')').remove();
			} 
		}
		
		//선택한 일
		var Day = ('0' + $('#startSelectDay').val()).slice(-2);
		startDt = Year + "-" + Month + "-" + Day;
		return startDt;
	},
	
	/**
	 * 종료날짜 변경 이벤트
	 * 종료셀렉트박스의 년월에 대한 마지막 날짜 구함
	 * month는 0부터 시작한다.
	 */
	endLastDay : function(){
		var Year=$('#endSelectYear').val(); 
		var Month = ('0' + $('#endSelectMonth').val()).slice(-2);  //1,2월을 01,02로 
		var day = new Date(new Date(Year,Month,1) - 24 * 60 * 60 * 1000 ).getDate(); 
//		console.log("endLastDay 해당월의 마지막 날짜 : ", day)  
		var dayindex_len=document.getElementById('endSelectDay').length; 
		if(day>dayindex_len){ 
			for(var i=(dayindex_len+1); i<=day; i++){ 
				document.getElementById('endSelectDay').options[i-1] = new Option(i, i); 
				} 
		}else if(day<dayindex_len){ 
			for(var i=dayindex_len; i>=day; i--){ 
				$('#endSelectDay option:eq(' + i + ')').remove();
			} 
		}
		var Day = ('0' + document.getElementById('endSelectDay').value).slice(-2);
		endDt = Year + "-" + Month + "-" + Day;
		return endDt;
	},
	
	/**
	 * 1개월,3개월6개월,12개월로 날짜변경
	 */
	chagneDate : function(dateValue){
		//오늘날짜 구하기
	    var today = new Date();   
	    var year = today.getFullYear(); // 년도
	    var month = today.getMonth() + 1;  // 월
	    var date = today.getDate();  // 일
	    
	    //15일전
	    if(dateValue == 15){
			var changedDate = new Date(Date.parse(today)-15 * 1000 * 60 * 60 * 24)
		    //console.log("changedDate" , changedDate);  
		    //console.log("changedDate.getFullYear" , changedDate.getFullYear());    
			//month는 0부터 시작하기 때문에 +1 해주기
		    //console.log("changedDate.getMonth()" , (changedDate.getMonth() + 1));   
		    //console.log("changedDate.getDate()" , changedDate.getDate()); 
		    
		    $('#startSelectMonth option').each(function(i, e){ 
		    	if(e.value == (changedDate.getMonth() + 1)){
		    		$('#startSelectMonth option:eq(' + i + ')').prop("selected", true); 
		    	}
		    });
		    
		    $('#startSelectYear option').each(function(i, e){
		    	if(e.value == changedDate.getFullYear()){
		    		$('#startSelectYear option:eq(' + i + ')').prop("selected", true); 
		    	}
		    });
		    
		    $('#startSelectDay option').each(function(i, e){
		    	if(e.value == changedDate.getDate()){
		    		$('#startSelectDay option:eq(' + i + ')').prop("selected", true); 
		    	}
		    });
		    
		    
		    startDt = changedDate.getFullYear() + "-" + (changedDate.getMonth() + 1) + "-" + changedDate.getDate();
		    //console.log("15일 전 startDt", startDt)
	    }else{
	    	//월별 전  1, 3, 6, 12개월
		    var changedDate = new Date(today.setMonth(month - (dateValue + 1)));	// month는 0부터 시작하기 때문에 +1을 해줘야한다.
		    $('#startSelectMonth option').each(function(i, e){ 
		    	if(e.value == (changedDate.getMonth() + 1)){
		    		$('#startSelectMonth option:eq(' + i + ')').prop("selected", true); 
		    	}
		    });
		    $('#startSelectYear option').each(function(i, e){
		    	if(e.value == changedDate.getFullYear()){
		    		$('#startSelectYear option:eq(' + i + ')').prop("selected", true); 
		    	}
		    });
		    
		    $('#startSelectDay option').each(function(i, e){
		    	if(e.value == changedDate.getDate()){
		    		$('#startSelectDay option:eq(' + i + ')').prop("selected", true); 
		    	}
		    });
		    
		    startDt = changedDate.getFullYear() + "-" + (changedDate.getMonth() + 1)  + "-" + changedDate.getDate();
		    //console.log("월별로 계산한 startDt", startDt)
	    }

		//엔드 데이트는 현재날짜 세팅
		$('#endSelectYear option').each(function(i, e){ 
	    	if(e.value == year){
	    		$('#endSelectYear option:eq(' + i + ')').prop("selected", true); 
	    	}
	    });
	    $('#endSelectMonth option').each(function(i, e){
	    	if(e.value == month){
	    		$('#endSelectMonth option:eq(' + i + ')').prop("selected", true); 
	    	}
	    });
	    $('#endSelectDay option').each(function(i, e){
	    	if(e.value == date){
	    		$('#endSelectDay option:eq(' + i + ')').prop("selected", true); 
	    	}
	    });
	    endDt = year + "-" + month + "-" + date;
	    var dateResult = {
	    		startDt : startDt,
	    		endDt : endDt
	    }
	    return dateResult;
	},
	
	clip : function(){
	    var url = '';
	    var textarea = document.createElement("textarea");
	    document.body.appendChild(textarea);
	    url = window.document.location.href;
	    textarea.value = url;
	    textarea.select();
	    document.execCommand("copy");
	    document.body.removeChild(textarea);
	    alert("URL 주소가 복사되었습니다. 게시판이나 메신저 창에서 Ctrl+V를 눌러보세요.")
	}

};
/*com끝*/

/**
 * 쿠키 세팅 
 * key:키
 * value:값 
 * expires:만료기간 
 * */
var setCookie = function(key, value, expires) {
    var date = new Date();
    var path = window.location.pathname;    // 쿠키에 접근가능한 도메인경로 세팅
    //console.log(date.toUTCString());      // 쿠키 생성시 시간
    date.setTime(date.getTime() + expires*24*60*60*1000);
    //console.log(date.toUTCString());      // 쿠키 만료시 시간
    document.cookie = key + '=' + value + ';expires=' + date.toUTCString() + ';path=' + path;
};

/**
 * 쿠키의 key로 value값을 가져온다. 
 * key:쿠키의 key 값
 * value값 = 문자
 * */
var getCookie = function(key) {
    var value = document.cookie.match('(^|;) ?' + key + '=([^;]*)(;|$)');
    return value? value[2] : null;
};



/**
 * 로그인아이디 쿠키 세팅 
 * cookieName : key
 * value: 저장할 아이디 값
 * exdays: 만료시간
 */
var setLoginCookie = function(cookieName, value, exdays){
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
    document.cookie = cookieName + "=" + cookieValue;
}
/**
 * 로그인 아이디 쿠키 삭제 
 */
var deleteLoginCookie = function(cookieName){
    var expireDate = new Date();
    expireDate.setDate(expireDate.getDate() - 1);
    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
};
/**
 * 저장되어있는 쿠키값(로그인 아이디) 가져오기  
 */
var getLoginIdCookie = function(cookieName) {
    cookieName = cookieName + '=';
    var cookieData = document.cookie;
    var start = cookieData.indexOf(cookieName);
    var cookieValue = '';
    if(start != -1){
        start += cookieName.length;
        var end = cookieData.indexOf(';', start);
        if(end == -1)end = cookieData.length;
        cookieValue = cookieData.substring(start, end);
    }
    return unescape(cookieValue);
};


/**
 * 공통게시판 썸머노트 설정
 * */
var summernoteConfig = {
    width: "100%",
    height: "500",
    lang: "ko-KR",
    fontNames: ['sans-serif','나눔바른고딕','맑은 고딕','굴림','돋움','바탕','궁서'],
    //fontSizes: ['8','9','10','11','12','13','14','15','16','17','18','19','20','24','30','36','48','64','82','150'],
    toolbar: [
        ['font', ['bold', 'italic', 'underline', 'clear']],
        //['fontname', ['fontname', 'fontsize']],
        ['fontname', ['fontsize']],
        ['color', ['color']],
        ['para', ['paragraph']],
        ['height', ['height']],
        ['insert', ['link', 'picture']],
    ],
    maximumImageFileSize: 2*1048576, // 2mb;
    callbacks:{
        onImageUploadError: function(msg){
           alert(msg + ' (2 MB)');
        }
    }
};

//레이어 팝업(confirm)
/**
 * @param e : popup 종류 : layerConfirm, layerAlert
 * @param s : 너비 기본 null
 * @param message : 메세지
 * @param callback : layerConfirm 일때만 사용
 * @returns
 */

function fn_layer_custom(e,s,message,callback) {

	 setTimeout(() => {
	    $(".layerPop.customLayer #message").html(message);
	 }, 50)
 ;
 var pdt = $("."+e).find(".inner").css('padding-top').replace(/[^-\d\.]/g, ''),
     pdb = $("."+e).find(".inner").css('padding-bottom').replace(/[^-\d\.]/g, '');
 $("."+e).fadeIn(200).addClass("on");
 $("body, html").css({"overflow":"hidden"});
 if(callback && typeof callback == 'function') {
     $(".layerPop.customLayer #ok").unbind("click");
     $(".layerPop.customLayer #ok").on("click", function() {
         callback(true);
     })
 };
 $(window).resize(function(){
     $("."+e).find(".inner").css({width:s+"px"});
     $("."+e).find(".cont").css({"max-height":($("."+e).height()*0.9) - (Number(pdt) + Number(pdb))});
 }).resize();
}

//--------------------------------------------------------------------  Jquery plugin
/**
 * 함수 토글
 */
$.fn.clickToggle = function(func1, func2) {
    var funcs = [func1, func2];
    this.data('toggleclicked', 0);
    this.click(function() {
        var data = $(this).data();
        var tc = data.toggleclicked;
        $.proxy(funcs[tc], this)();
        data.toggleclicked = (tc + 1) % 2;
    });
    return this;
};

/**
 * form data To Object
 */
jQuery.fn.serializeObject = function() {
    var obj = null;
    try {
        if (this[0].tagName && this[0].tagName.toUpperCase() == "FORM") {
            var arr = this.serializeArray();
            if (arr) {
                obj = {};
                jQuery.each(arr, function() {
                    obj[this.name] = this.value;
                });
            }
        }
    } catch (e) {
        alert(e.message);
    }
 
    return obj;
};

function searchPostalCode(target) {
	new daum.Postcode({
		oncomplete: (data) => {
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
			// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			var roadAddr = data.roadAddress; // 도로명 주소 변수
			var extraRoadAddr = ''; // 참고 항목 변수

			// 법정동명이 있을 경우 추가한다. (법정리는 제외)
			// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
			if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
				extraRoadAddr += data.bname;
			}
			// 건물명이 있고, 공동주택일 경우 추가한다.
			if (data.buildingName !== '' && data.apartment === 'Y') {
				extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
			}
			// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
			if (extraRoadAddr !== '') {
				extraRoadAddr = ' (' + extraRoadAddr + ')';
			}

			if (!data.jibunAddress) {
				alert("지번을 선택하세요");
				target.callback(false);
				return;
			}

			if (target.postalCode) {
				$("#" + target.postalCode).val(data.zonecode);
			}
			if (target.addressDoro) {
				$("#" + target.addressDoro).val(roadAddr);
			}
			if (target.addressJibun) {
				$("#" + target.addressJibun).val(data.jibunAddress);
			}
			if (target.addressCode) {
				$("#" + target.addressCode).val(data.bcode);
			}
			if (target.callback) {
				target.callback(true);
			}
		},
	}).open();
}


/**
 * 날짜
 */






