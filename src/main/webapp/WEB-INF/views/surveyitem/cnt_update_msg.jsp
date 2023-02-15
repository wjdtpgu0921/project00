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

  설문조사에 참여해주셔서 감사합니다<br><br>
  <A href='./result.do' class="btn btn-primary">설문 결과 조회</A>
  <A href='./list_by_surveyno.do' class="btn btn-primary">설문 목록</A>
  <A href="/index.do" class="btn btn-primary">시작 화면</A>
 
<jsp:include page="../menu/bottom.jsp" />

</body>
 
</html>

