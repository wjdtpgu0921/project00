<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>


<script type="text/javascript">
  $(function() { // click 이벤트 핸들러 등록
    $('#authBtn').on('click', check_authKey); // 찾기 버튼 클릭시 입력창 나타나기
  });

  function check_authKey(){ 

	  let auth = $('#auth', frm).val(); // frm 폼에서 auth가 'auth'인 태그 검색
	  
	  if ($.trim(auth) == ${authKey}) { // auth과 인증번호가 일치하면
		  $('#frm').submit(); 
		}
	  else{
		  msg = '입력된 인증번호가 일치하지 않습니다.<br>';
	      msg += "인증번호를 다시 입력해주세요.<br>"; 
	      
	      $('#modal_content').attr('class', 'alert alert-danger'); // CSS 변경
	      $('#modal_title').html('패스워드 일치 여부  확인'); // 제목 
	      $('#modal_content').html(msg);  // 내용
	      $('#btn_close').attr('data-focus', 'passwd');
	      $('#modal_panel').modal();         // 다이얼로그 출력
	      
		  }
  }

</script> 

</head> 
 
<body>
---------------------------------<br>
<c:import url="/menu/top.do" />

<!-- ******************** Modal 알림창 시작 ******************** -->
  <div id="modal_panel" class="modal fade"  role="dialog">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title" id='modal_title'></h4><%-- 제목 --%>
          <button type="button" id='btn_close_modal' class="close" data-dismiss="modal">×</button>
        </div>
        <div class="modal-body">
          <p id='modal_content'></p>  <%-- 내용 --%>
        </div>
        <div class="modal-footer"> <%-- data-focus="": 캐럿을 보낼 태그의 id --%>
          <button type="button" id="btn_close" data-focus="" onclick="setFocus()" class="btn btn-default" 
                      data-dismiss="modal">닫기</button> <%-- data-focus: 캐럿이 이동할 태그 --%>
        </div>
      </div>
    </div>
  </div>
  <!-- ******************** Modal 알림창 종료 ******************** -->

  <DIV class='title_line'>인증번호 입력</DIV>

  <DIV class='content_body'> 
    <DIV style='width: 40%; margin: 0px auto;'>
      <FORM name='frm' id='frm' method='POST' action='./show_id.do'>
      
        
        <div class="form_input">
        <label>인증번호를 입력해주세요</label>    
          <input type='text' class="form-control" name='auth' id='auth' 
                    value='' required="required" 
                    style='width: 80%;' placeholder="인증번호" autofocus="autofocus">                    
        </div> 
        
        <div class="form_input">
          <button type="button" id="authBtn" class="btn btn-dark">찾기</button>
        </div>
        
     	<div class="form_input" style="display:none">
     	<textarea name="checkn" id="checkn" rows="15"  style='width: 100%; border: #AAAAAA 1px solid;'>${checkn}</textarea>
     	</div>
      </FORM>
    </DIV>
  </DIV> <%-- <DIV class='content_body'> END --%>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>