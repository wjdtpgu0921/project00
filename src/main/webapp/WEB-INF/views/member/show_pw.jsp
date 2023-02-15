<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
 
<script type="text/javascript">
  $(function(){
 
  });
</script>
</head> 
 
<body>
<c:import url="/menu/top.do" />
 
  <DIV class='title_line'>
    비밀번호
  </DIV>

  <DIV class='content_body'>

    <ASIDE class="aside_right">
      <A href="javascript:location.reload();">새로고침</A>
      <span class='menu_divide' >│</span> 
      <A href='./create.do'>회원 가입</A>
    </ASIDE> 
   
    <div class='menu_line'></div>
    
   
    <table class="table table-striped" style='width: 100%; margin:auto;'>
    <colgroup>
      <col style='width: 100%;'/>
    </colgroup>
    <TR>
      <TH class='th_bs'>비밀번호 : ${find_pw}</TH>
    </TR>
   
    <c:forEach var="memberVO" items="${list}">
      <c:set var="memberno" value ="${find_pw}" />


    </c:forEach>
    
  </TABLE>
   
  <DIV class='bottom_menu'>
    <button type='button' onclick="location.href='./login.do'" class="btn btn-dark">로그인</button>
    <button type='button' onclick="location.reload();" class="btn btn-dark">새로 고침</button>
  </DIV>
</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>

