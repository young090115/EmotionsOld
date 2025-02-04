<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<style type="text/css">
	#btn{
		width: 40%;
	}
	.listA:link {
	  text-decoration: none;
	  color: gray;
	}
	 
	.listA:visited {
	  text-decoration: none;
	  color: gray;
	}
	 
	.listA:hover {
	  text-decoration: underline;
	  color: gray;
	}
	 
	.listA:active {
	  text-decoration: underline;
	  color: gray;
	}
	#detailDiv{
		min-height: 400px;
	
	}
	#label{
		color: #448AFF;
	}
	#detailP{
		width: 900px;
		margin-left: 6%;
	}
	#titleP{
		width: 900px;
		margin-left: 6%;
	}
	#replyId{
		border: none;
		pointer-events: none;
	}
	.editBox{
		margin-left: 90%;
	}
	#editBtn ,#delBox,#addBox{
            fill: gray;
    }
</style>
<meta charset="UTF-8">
<head>
<title>Emotions Project</title>
<link href="./css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<link rel="stylesheet" href="../css/bootstrap.min3.css">
<%@include file="../include/top.jsp"%>
 <body>
<main class="container">
<br>
    <div class="p-5 mb-4 bg-body-tertiary rounded-3">
      <div class="container-fluid py-5">
      <fmt:formatDate value="${detailList.board_input_dt}" var="dt" pattern="yyyy-MM-dd HH:mm" />
	      <h2 class="display-5 link-body-emphasis mb-1">${dt}일의 기록</h2>
	      <br><br><br>
	       <div class="mb-3">
	        <label for="emotions" class="form-label" id="label">이 날의 감정</label><br><br>
				<p id="emotions">&emsp;&emsp;&emsp;${detailEmotion.cls2_nm}  -  ${detailEmotion.cls3_nm}</p>
			</div>
        	<br>
	       <div class="mb-3">
			  <label for="title" class="form-label" id="label">제목</label><br><br>
			  <p for="title" id="titleP">${detailList.board_title}</p>
			</div>
			<div id="detailDiv" class="mb-3">
			  <label for="content" class="form-label"  id="label">내용</label><br><br>
			  	<p for="content" id="detailP">${detailList.board_detail}</p>
			</div>
      	</div>
      	<br>
      		<div align="left" >
      		<c:if test="${detailList.beforeNum != '' }">
				<a href="detailBoard.do?board_no=${detailList.beforeNum}&screen=${screen}" class="listA">이전글 : ${detailList.beforeTitle}</a>
			</c:if>
      		<c:if test="${detailList.beforeNum == '' }">
				<a style="color: gray;">이전글 : 이전글이 없습니다.</a>
			</c:if>
				<hr>
				<c:if test="${detailList.nextNum != '' }">
					<a href="detailBoard.do?board_no=${detailList.nextNum}&screen=${screen}"  class="listA">다음글 : ${detailList.nextTitle}</a>
				</c:if>
				<c:if test="${detailList.nextNum == '' }">
					<a style="color: gray;">다음글 : 다음글이 없습니다.</a>
				</c:if>
	    	</div>
	    	<br><br>
	    	<c:if test="${detailList.user_id == loginInfo.user_id }">
				<div class="form-check form-switch" align="right">
				  <input class="form-check-input" type="checkbox" role="switch" id="hideRecord" name="hideChk" value="Y" onchange="hideRecord(${detailList.board_no})">
				  <label class="form-check-label" for="flexSwitchCheckDefault"><b>비공개 여부</b></label>
				 <br><br><button class="btn btn-outline-danger me-md-2" type="button" onclick="deleteBtn(${detailList.board_no})" >해당 글 삭제하기</button>
				</div>
	    	</c:if>
	    	<c:if test="${detailList.user_id != loginInfo.user_id }">
				<div class="form-check form-switch" align="right">
				  	<input type="checkbox" class="btn-check" name="interest" id="danger-outlined" value="Y" onchange="interestRecord(${detailList.board_no})" >
					<label class="btn btn-outline-danger" for="danger-outlined">관심 글♡</label>
				</div>
	    	</c:if>
	   </div>
	<div class="card mb-2">
		<div class="card-header bg-light">
	        <i class="fa fa-comment fa">REPLY</i>
	    </div>
		<div class="card-body">
			<ul class="list-group list-group-flush">
			    <li class="list-group-item">
				<div class="form-inline mb-2">
					<label for="replyId"><i class="fa fa-user-circle-o fa-2x">작성자 아이디 :</i></label>
					<input type="text" class="form-control ml-2" value="${loginInfo.user_id}" id="replyId" readonly="readonly">
				</div>
				<textarea class="form-control" id="board_rply" rows="3" maxlength="200" placeholder="댓글을 남겨보세요"></textarea>
				<div class="textLengthWrap">
		  			<span class="textCount">0자</span>
		  			<span class="textTotal">/200자</span>
		  		</div>
				<div align="right">
					<button type="button" class="btn btn-dark mt-3" onClick="replyInsert(${detailList.board_no})" >post reply</button>
				</div>
			    </li>
			</ul>
			<hr class="rhr">
			<c:if test="${not empty replyList}">
			    <c:forEach items="${replyList}" var="m" varStatus="status">
			    <input type="hidden" id="puser_id" value="${m.puser_id}">
			    	<c:if test="${m.board_no == detailList.board_no}">
			        <div class="accordion" >
			        	<input type="hidden" id="reply_no_${status.index}" value="${m.reply_no}">
			        	<input type="hidden" id="level_no_${status.index}" value="${m.level_no}">
			        	<div class="arrow"  >
			        	<c:if test="${m.level_no == 0 and status.index != 0}">
			        		<hr class="replyHr">
			        	</c:if>
			        	<c:if test="${m.level_no != 0 and status.index != 0}">
			        		<hr>
			        	</c:if>
			                <span class="reply_user_id">${m.user_id}</span>
			               <c:if test="${m.text != null}">
			                <div class="editBox">
			                <c:if test="${loginInfo.user_id eq m.user_id}">
			                <a href="javascript:void(0);" onclick="editReply(${status.index})">
								<svg id="editBtn" width="20" height="20" fill="gray" class="bi bi-eraser" viewBox="0 0 16 16">
								  <path d="M8.086 2.207a2 2 0 0 1 2.828 0l3.879 3.879a2 2 0 0 1 0 2.828l-5.5 5.5A2 2 0 0 1 7.879 15H5.12a2 2 0 0 1-1.414-.586l-2.5-2.5a2 2 0 0 1 0-2.828l6.879-6.879zm2.121.707a1 1 0 0 0-1.414 0L4.16 7.547l5.293 5.293 4.633-4.633a1 1 0 0 0 0-1.414l-3.879-3.879zM8.746 13.547 3.453 8.254 1.914 9.793a1 1 0 0 0 0 1.414l2.5 2.5a1 1 0 0 0 .707.293H7.88a1 1 0 0 0 .707-.293l.16-.16z"/>
								</svg>
							</a>
							<a href="javascript:void(0);" onclick="replyDel(${status.index})">
								<svg id="delBox" width="20" height="20" fill="gray" class="bi bi-x-square-fill" viewBox="0 0 16 16">
								  <path d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2zm3.354 4.646L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 1 1 .708-.708z"/>
								</svg>
							</a>
							<a href="javascript:void(0);" onclick="addreply(${status.index})" >
								<svg id="addBox" width="20" height="20" fill="gray" class="bi bi-plus-square-fill" viewBox="0 0 16 16">
								  <path d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2zm6.5 4.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3a.5.5 0 0 1 1 0z"/>
								</svg>
							</a>
							</c:if>
							<c:if test="${loginInfo.user_id ne m.user_id}">
								<button  onclick="addreply(${status.index})"  class="btn btn-dark mt-3"  id="addBtn" >답글달기</button>
							</c:if>
			                </div>
			                </c:if>
			             	<span id="replytext_${status.index}" class="reply_text" >
			             	<span id="replytext_${status.index}" class="reply_text puser_idSpan" style="color:navy; font-weight:bold">
			             	</span>${m.text2}</span>
			            </div>
			            <br>
				            <!-- 답글 DIV -->
				            <div class="replyAdd_${status.index}" style="display: none">
								<ul class="list-group list-group-flush">
								    <li class="list-group-item">
									<div class="form-inline mb-2">
										<label for="replyId"><i class="fa fa-user-circle-o fa-2x">작성자 아이디 :</i></label>
										<input type="text" class="form-control ml-2" value="${loginInfo.user_id}" id="replyId" readonly="readonly">
									</div>
									<textarea class="form-control" id="board_re_rply_${status.index}" rows="3" maxlength="200" placeholder="댓글을 남겨보세요"></textarea>
									<div class="textLengthWrap">
							  			<span class="re_textCount">0자</span>
							  			<span class="re_textTotal">/200자</span>
							  		</div>
									<div align="right">
										<button type="button" class="btn btn-dark mt-3" onClick="replyAdd(${status.index})" >post Reply</button>
									</div>
								    </li>
								</ul>
				            </div>
				            
				            <!-- 글수정 DIV -->
				            <div class="replyEditDiv_${status.index}" style="display: none">
				            	<ul class="list-group list-group-flush">
								    <li class="list-group-item">
									<div class="form-inline mb-2">
										<label for="replyId"><i class="fa fa-user-circle-o fa-2x">작성자 아이디 :</i></label>
										<input type="text" class="form-control ml-2" value="${loginInfo.user_id}" id="replyId" readonly="readonly">
									</div>
									<textarea class="form-control" id="board_edit_${status.index}" rows="3" maxlength="200">${m.text2}</textarea>
									<div class="textLengthWrap">
							  			<span class="edit_textCount">0자</span>
							  			<span class="edit_textTotal">/200자</span>
							  		</div>
									<div align="right">
										<button type="button" onclick="replyEdit(${status.index})" class="btn btn-dark mt-3">수정</button>
									</div>
								    </li>
								</ul>
				            </div>
				        </div>
				    </c:if>
				</c:forEach>
			</c:if>
		</div>
	</div>
    <br><br>
<%@include file="../include/bottom.jsp"%>
</main>
<script src="./js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
<script src="../js/jquery-1.10.2.js" ></script>
<script type="text/javascript">

jQuery.ajaxSetup({cache:false});

//path 경로 설정 
function getContextPath() {
var hostIndex = location.href.indexOf( location.host ) + location.host.length;
return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1));
};

//공개글 비공개글 / 관심글 상세 화면 띄울때 체크 여부
$(document).ready(function(){
	var hide = '${detailList.hide}';
	var interest = '${interest}';
	if("Y" == hide){
		$("input[name=hideChk]").prop("checked",true);
	}else if(0 < interest){
		$("input[name=interest]").prop("checked",true);
	}
	
})

//답글아이콘 클릭 시 textarea 띄우기
function addreply(a) {
    event.preventDefault();
    $(".replyAdd_"+a).toggle();
    $(".replyEdit").hide();
  	//이건 대댓글이랑 수정
    setupTextareaCount('board_re_rply_'+a, 're_textCount');
  	
    //console.log(document.getElementsByClassName('arrow')[0].nextElementSibling.nextElementSibling.getElementsByTagName('textarea')[0].id);
    //자바스크립트에서 id값 가져오는 방법
}

//수정아이콘 클릭 시 textarea 띄우기
function editReply(b) {
       event.preventDefault();
       $(".replyEditDiv_"+b).toggle();
       $(".replyAdd").hide();
       $("#replytext_"+b).toggle();
       setupTextareaCount('board_edit_'+b, 'edit_textCount');
}


//댓글, 대댓글 글자수 세기
function setupTextareaCount(textareaId, textCountClass) {
    $(document).on('keyup', '#' + textareaId, function (e) {
        let content = $(this).val();
        let countElement = $(this).siblings('.textLengthWrap').find('.' + textCountClass);

        // 글자수 세기
        if (content.length == 0 || content == '') {
            countElement.text('0자');
        } else {
            countElement.text(content.length + '자');
        }

        // 글자수 제한
        if (content.length > 200) {
            // 200자 부터는 타이핑 되지 않도록
            $(this).val(content.substring(0, 200));
            // 200자 넘으면 알림창 뜨도록
            alert('댓글은 200자까지 입력 가능합니다.');
        }
    });
}
//이게 댓글
setupTextareaCount('board_rply', 'textCount');


//상세에서 버튼으로 삭제 시 
function deleteBtn(board_no) {
	var path = getContextPath();
	 if (confirm("글을 삭제하시겠습니까? \n삭제 시 댓글 또한 함께 삭제 됩니다.")) {
	      $.ajax({
	           type : 'post'   
	           , url : path+"/deleteBtn.do"
	           , data: {board_no : board_no}
	           , dataType: 'text'
	           , success: function (data){
	              if("ok" == data){
	                 alert("글이 삭제되었습니다");
                	 var link = '/recordList.do?screen='+'${screen}';
                     location.replace(link);
               		}
              	}
           });
      };
   }
   
//비공개여부
function hideRecord(board_no) {
	var path = getContextPath();
	var hide = $("input[name='hideChk']:checked").val();
	if("Y" == hide){
		 if (confirm("해당 글을 비공개로 전환 하시겠습니까?")) {
		      $.ajax({
		           type : 'post'   
		           , url : path+"/hideChk.do"
		           , data: {	
		        	   board_no : board_no
		        	   ,hide : hide
		           	}
		           , dataType: 'text'
		           , success: function (data){
		              if("ok" == data){
		            	  alert("해당 글이 비공개로 전환 되었습니다.");
	                	 var link = '/detailBoard.do?board_no='+board_no;
	                     location.replace(link);
	               		}
	              	}
	           });
	      };
	}else if("" == hide || null == hide){
		hide = "N";
		$.ajax({
	           type : 'post'   
	           , url : path+"/hideChk.do"
	           , data: {	
	        	   board_no : board_no
	        	   ,hide : hide
	           	}
	           , dataType: 'text'
	           , success: function (data){
	              if("ok" == data){
	                 alert("해당 글이 공개로 전환 되었습니다.");
             	 var link = '/detailBoard.do?board_no='+board_no;
                  location.replace(link);
            		}
           	}
        });
	}
}

//관심글여부
function interestRecord(board_no) {
	var path = getContextPath();
	var interest = $("input[name='interest']:checked").val();
	var screen = '${screen}';
	if("Y" == interest){
	      $.ajax({
	           type : 'post'   
	           , url : path+"/interestInsert.do"
	           , data: {	
	        	   board_no : board_no
	           	}
	           , dataType: 'text'
	           , success: function (data){
	              if("ok" == data){
	               	 var link = '/detailBoard.do?board_no='+board_no+'&screen='+screen;
	                    location.replace(link);
	              		}
	             	}
	       });
	}else if("" == interest || null == interest){
		$.ajax({
	           type : 'post'   
	           , url : path+"/interestDel.do"
	           , data: {	
	        	   board_no : board_no
	           	}
	           , dataType: 'text'
	           , success: function (data){
	              if("ok" == data){
	            	  	alert("관심글에서 해제 되었습니다.");
             	 		var link = '/detailBoard.do?board_no='+board_no+'&screen='+screen;
                  		location.replace(link);
            		}
           	}
        });
	}
}


//댓글 등록
function replyInsert(board_no) {
	if ("" == $('#board_rply').val().trim()) {
		alert("댓글을 입력해주세요.");
		$('#board_rply').focus();
		return false;
	} else {
		var ReplyData = {}; 
		ReplyData.board_no = board_no;
		ReplyData.text = $("#board_rply").val();
		$.ajax({ 
			type : 'post'
			, url :"/replyInsert.do"
			, contentType : "application/json"
			, data : JSON.stringify(ReplyData)
			, success : function(data) {
				if ("ok" == data) {
					location.reload();
				}
			}
		});
	}
}

//대댓글 등록
function replyAdd(addIndex) {
	var board_no = ${detailList.board_no};
	if ("" == $('#board_re_rply_'+addIndex).val().trim()) {
		alert("답글을 입력해주세요.");
		$('#board_re_rply_'+addIndex).focus();
		return false;
	} else {
		var addReplyData = {}; 
		addReplyData.board_no = board_no;
		addReplyData.text = $("#board_re_rply_"+addIndex).val();
		addReplyData.reply_no = $("#reply_no_"+addIndex).val();
		$.ajax({ 
			type : 'post'
			, url :"/addReply.do"
			, contentType : "application/json"
			, data : JSON.stringify(addReplyData)
			, success : function(data) {
				if ("ok" == data) {
					location.reload();
				}
			}
		});
	}
}

//댓글 수정
function replyEdit(editIndex) {
	if ("" == $('#board_edit_'+editIndex).val().trim()) {
		alert("답글을 입력해주세요.");
		$('#board_edit_'+editIndex).focus();
		return false;
	} else {
		var editReplyData = {}; 
		editReplyData.text = $("#board_edit_"+editIndex).val();
		editReplyData.reply_no = $("#reply_no_"+editIndex).val();
		$.ajax({ 
			type : 'post'
			, url :"/editReply.do"
			, contentType : "application/json"
			, data : JSON.stringify(editReplyData)
			, success : function(data) {
				if ("ok" == data) {
					location.reload();
				}
			}
		});
	}
}

//댓글 삭제
function replyDel(delIndex) {
	var reply_no =  "reply_no="+$('#reply_no_'+delIndex).val(); 
	if (confirm("댓글을 삭제하시겠습니까?")) {
		$.ajax({
	        type : 'post'   
	        , url : "/replyDelete.do"
	        , data: reply_no
	        , dataType: 'text'
	        , success: function (data){
	           if("ok" == data){
	              	alert("댓글이 삭제되었습니다");
	              	location.reload();
	              }
	           }
	        })
	   };
	}
	
//레벨 별로 margin 주기. 이거 어디까지 stop할지 상의해보기 
document.addEventListener("DOMContentLoaded", function () {
  var replyDivs = document.querySelectorAll('.arrow');
  var puser_id = $('#puser_id').val();
  
  replyDivs.forEach(function (div, index) {
    var levelNo = parseInt(document.getElementById('level_no_' + index).value);
    if (levelNo > 2) {
      levelNo = 3;
    }
    if (levelNo > 0) {
      var userIdSpan = div.querySelector('.reply_user_id');
      var textSpan = div.querySelector('.reply_text');

      // 레벨 번호에 따라 여백을 동적으로 설정
      var marginValue = 100 + (levelNo - 1) * 30;
      var marginValueText = 100 + (levelNo - 1) * 35;

      userIdSpan.style.marginLeft = marginValue + 'px';
      textSpan.style.marginLeft = marginValueText + 'px';
      
      if (levelNo >= 3) {

        var puser_idSpanList = div.querySelectorAll('.puser_idSpan');
        puser_idSpanList.forEach(function (puser_idSpan) {
          puser_idSpan.textContent = puser_id + " ";
        });
      }
    }
  });
});
</script>
</body>
</html>