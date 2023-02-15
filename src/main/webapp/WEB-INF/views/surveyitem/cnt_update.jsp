<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=5.0, width=device-width" /> 
<title>투표 결과</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    
</head> 
 
<body>
<c:import url="/menu/top.do" />

   <form name='topic' action='./surveyitem/cnt_update.do' method='POST'>
     <input type='hidden' name='surveyno' value='${param.surveyno }' >
     <input type='hidden' name='surveyitemno' value='${param.surveyitemno }' >   
     
      <A href="./list_by_surveyno.do?surveyno=${surveyVO.surveyno }" class='title_link'>${surveyitemVO.cnt }</A>
    
   </form>
 
<jsp:include page="../menu/bottom.jsp" />

</body>
 
</html>

