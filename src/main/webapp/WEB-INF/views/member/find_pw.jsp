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
    $('#content').val(createKey);
  });




  function createKey() {
	  return Math.floor(Math.random() * (999999 - 100000)) + 100000;
	}

</script> 

</head> 
 
<body>
<c:import url="/menu/top.do" />
 
  <DIV class='title_line'>비밀번호 찾기</DIV>

  <DIV class='content_body'> 
    <DIV style='width: 40%; margin: 0px auto;'>
      <FORM name='frm' method='POST' action='./send2.do'>
      
      	<div class="form_input">
          <label>이메일</label>    
          <input type='text' class="form-control" name='receiver' id='receiver' 
                    value='' required="required" style='width: 80%;' placeholder="이메일">
        </div>  
      
        <div class="form_input">
          <label>아이디</label>    
          <input type='text' class="form-control" name='id' id='id' 
                    value='' required="required" 
                    style='width: 80%;' placeholder="아이디" autofocus="autofocus">
        </div>   
     
        
        <div class="form_input">
          <button type="submit" class="btn btn-dark" id="send">인증번호 보내기</button>
        </div>   
        
        <div class="form_input" style="display:none">
     	<textarea name="content" id="content" rows="15"  style='width: 100%; border: #AAAAAA 1px solid;'></textarea>
    	</div>  
      
      </FORM>
    </DIV>
  </DIV> <%-- <DIV class='content_body'> END --%>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>

