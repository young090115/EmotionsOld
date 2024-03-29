<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<meta name="theme-color" content="#712cf9">
    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
      
      .bi {
        vertical-align: -.125em;
        fill: currentColor;
      }

      .nav-scroller {
        position: relative;
        z-index: 2;
        height: 2.75rem;
        overflow-y: hidden;
      }

      .nav-scroller .nav {
        display: flex;
        flex-wrap: nowrap;
        padding-bottom: 1rem;
        margin-top: -1px;
        overflow-x: auto;
        text-align: center;
        white-space: nowrap;
        -webkit-overflow-scrolling: touch;
      }

      .btn-bd-primary {
        --bd-violet-bg: #712cf9;
        --bd-violet-rgb: 112.520718, 44.062154, 249.437846;

        --bs-btn-font-weight: 600;
        --bs-btn-color: var(--bs-white);
        --bs-btn-bg: var(--bd-violet-bg);
        --bs-btn-border-color: var(--bd-violet-bg);
        --bs-btn-hover-color: var(--bs-white);
        --bs-btn-hover-bg: #6528e0;
        --bs-btn-hover-border-color: #6528e0;
        --bs-btn-focus-shadow-rgb: var(--bd-violet-rgb);
        --bs-btn-active-color: var(--bs-btn-hover-color);
        --bs-btn-active-bg: #5a23c8;
        --bs-btn-active-border-color: #5a23c8;
      }
      .profilDiv{
      	display: inline-block;
      	border-radius: 70%;
      	overflow: hidden;
      	margin-top: 8%;
      	vertical-align: middle;
      }
      .modal {
    	display: none;
	  }
    </style>
  </head>
  <body>
<div class="container">
  <header class="border-bottom lh-1 py-3">
    <div class="row flex-nowrap justify-content-between align-items-center">
      <div class="col-4 pt-1">
        <a class="link-secondary" href="index.do">Emotions</a>
      </div>
      <div class="col-4 text-center">
        <h1><a class="blog-header-logo text-body-emphasis text-decoration-none" href="index.do">Emotions</a></h1>
      </div>
      <div class="col-4 d-flex justify-content-end align-items-center">
	      <c:if test="${empty loginInfo}">
			<a class="btn btn-sm btn-outline-secondary" href="login.do">sign in</a>&emsp;
	        <a class="btn btn-sm btn-outline-secondary" href="form.do">sign up</a>
	       </c:if>
	       <c:if test="${not empty loginInfo}">
		       <div class="profilAllDiv">
					<div class="profilDiv"><a href="#" data-bs-toggle="modal" data-bs-target="#profilModal"><img alt="프로필사진" src="${path}/files/${login_profil_name}" width="50px" height="50px" ></a></div>
		       		<label>${loginInfo.user_id}&emsp;</label>
		       		&emsp;<a class="btn btn-sm btn-outline-secondary" href="logout.do">Logout</a>
		       </div>
	       </c:if>
      </div>
    </div>
  </header>
    <nav class="navbar navbar-expand-lg bg-body-tertiary rounded" aria-label="Twelfth navbar example">
      <div class="container-fluid">
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsExample10" aria-controls="navbarsExample10" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse justify-content-md-center" id="navbarsExample10">
          <ul class="navbar-nav">
	          <li class="nav-item">
	          	<a class="nav-link active" aria-current="page" href="#" id="myCalendar">calendar</a>
	          </li>
            <li class="nav-item">
             	<a class="nav-link active" aria-current="page" href="#" id="myRecord">my record</a>
            </li>
            <li class="nav-item">
              <a class="nav-link active" href="#" id="yourRecord">your record</a>
            </li>
            <li class="nav-item">
              <a class="nav-link active"  aria-disabled="true" href="#" id="myPage" >my page</a>
            </li>
            <li class="nav-item">
              <a class="nav-link active"  aria-disabled="true" href="#" id="interesList" >Posts of interest</a>
            </li>
            <c:if test="${loginInfo.auth_id eq 'B001'}">
	            <li class="nav-item dropdown">
	              <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown" aria-expanded="false">관리자페이지</a>
	              <ul class="dropdown-menu">
	                <li><a class="dropdown-item" href="#">그룹관리</a></li>
	                <li><a class="dropdown-item" href="#">회원관리</a></li>
	                <li><a class="dropdown-item" href="#">정지회원 관리</a></li>
	              </ul>
	            </li>
            </c:if>
          </ul>
        </div>
      </div>
    </nav>
</div>
	<!-- 프로필 변경 모달용 -->
	<div class="modal fade" id="profilModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="exampleModalLabel">프로필 사진</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
			<div class="col-md-12" align="center">
				<img alt="프로필사진" src="${path}/files/${login_profil_name}" width="400px" height="400px">
				<br><br>
				 <input type="file" class="form-control" id="profil_img">
			</div>
	      </div><br>
	      <div class="modal-footer">
	     	<button type="button" class="btn btn-danger" onclick="delProfil()">프로필 삭제</button>
	        <button type="button" class="btn btn-primary" onclick="changeProfil()">적용</button>
	      </div>
	    </div>
	  </div>
	</div>
<script src="./js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<script src="../js/jquery-3.7.1.js" ></script>
<script src="../js/jquery-ui.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">

jQuery.ajaxSetup({cache:false});

//절대 경로 path 
function getContextPath() {
var hostIndex = location.href.indexOf( location.host ) + location.host.length;
return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
}


// 로그인이 안되어있는 경우 버튼 클릭 시 로그인 화면으로 이동
var loggedIn = true;
//링크 엘리먼트를 가져옵니다.
var yourRecord = document.getElementById("yourRecord");
var myRecord = document.getElementById("myRecord");
var myPage = document.getElementById("myPage");
var myCalendar = document.getElementById("myCalendar");
var interesList = document.getElementById("interesList");

if(${empty loginInfo}){
	loggedIn = false;
}
// 사용자의 로그인 상태에 따라 href 속성을 설정합니다.
yourRecord.href = loggedIn ? "/recordList.do?screen=yourRecord" : "/login.do";
myRecord.href = loggedIn ? "/recordList.do?screen=myRecord" : "/login.do";
myPage.href = loggedIn ? "/userEdit.do" : "/login.do";
myCalendar.href = loggedIn ? "/myCalendar.do" : "/login.do";
interesList.href = loggedIn ? "/interesList.do" : "/login.do";

//프로필 사진 모달에서 사진 변경하기
function changeProfil() {
    var profil_img = $('#profil_img')[0].files[0];
    if (!profil_img) {
        alert("사진을 선택해주세요");
        return false;
    } else {
    	debugger;
        var data = new FormData();
        data.append('profil_img', profil_img);
        data.append('before_profil', '${login_profil_name}');

        var path = getContextPath();
        $.ajax({
            type: "post",
            url: path + "/changeProfil.do",
            data: data,
            processData: false,  // 필수: FormData를 문자열로 변환하지 않도록 설정
            contentType: false,  // 필수: Content-Type 헤더를 설정하지 않도록 설정
            success: function (data) {
                if ("OK" == data) {
                    var link = '/index.do';
                    location.replace(link);
                }
            }
        });
    }
}
//프로필 삭제
function delProfil() {
	var path = getContextPath();
	$.ajax({
           type: "post",
           url: path + "/delProfil.do",
           success: function (data) {
               if ("OK" == data) {
                   var link = '/index.do';
                   location.replace(link);
               }
           }
       });
}


// 모달 닫으면 기존 내용 초기화 만들기
$('#profilModal').on('hidden.bs.modal', function () {
  // 입력 필드 초기화
  $('#profil_name').val('');
});

</script>