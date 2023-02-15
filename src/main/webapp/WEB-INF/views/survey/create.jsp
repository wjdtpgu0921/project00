<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css"> <%-- /static/css/style.css 기준 --%>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    
</head>  
 
<body>   
<c:import url="/menu/top.do" />
 
<DIV class='title_line'>설문 조사</DIV>

<DIV class='content_body'>
  <!-- <FORM name='frm' method='POST' action='http://localhost:9093/survey/create.do'> -->
  <!-- <FORM name='frm' method='POST' action='/survey/create.do'> -->
  <FORM name='frm' method='POST' action='./create.do'><!-- /survey 폴더 자동 인식, 권장 -->
    <div>
       <label>설문 제목</label>
       <input type='text' name='topic' value='' required="required" 
                 autofocus="autofocus" class="form-control" style='width: 50%;'>
    </div>
    <div>
       <label>출력</label>
       <input type='text' name='yn' value='Y' required="required" 
                 autofocus="autofocus" class="form-control" style='width: 50%;'>
    </div>
    <div class="content_body_bottom">
      <button type="submit" class="btn btn-info">진행</button>      
      <button type="button" onclick="location.href='./list_all.do'" class="btn btn-info">전체 목록</button>
    </div>
  
  </FORM>
</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>
 