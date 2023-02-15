<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    
</head> 
 
<body>
<c:import url="/menu/top.do" />
 
<DIV class='title_line'>${surveyVO.topic } > 글 등록</DIV>

<DIV class='content_body'>
  <ASIDE class="aside_right">
    <A href="./create.do?surveyno=${surveyVO.surveyno }">등록</A>
    <span class='menu_divide' >│</span>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>
    <A href="./list_by_surveyno.do?surveyno=${surveyVO.surveyno }">기본 목록형</A>    
    <span class='menu_divide' >│</span>
    <A href="./list_by_surveyno_grid.do?surveyno=${surveyVO.surveyno }">갤러리형</A>
  </ASIDE> 
  
  <DIV style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='get' action='./list_by_surveyno.do'>
      <input type='hidden' name='surveyno' value='${surveyVO.surveyno }'>  <%-- 게시판의 구분 --%>
      
      <c:choose>
        <c:when test="${param.word != '' }"> <%-- 검색하는 경우 --%>
          <input type='text' name='word' id='word' value='${param.word }' style='width: 20%;'>
        </c:when>
        <c:otherwise> <%-- 검색하지 않는 경우 --%>
          <input type='text' name='word' id='word' value='' style='width: 20%;'>
        </c:otherwise>
      </c:choose>
      <button type='submit'>검색</button>
      <c:if test="${param.word.length() > 0 }">
        <button type='button' 
                     onclick="location.href='./list_by_surveyno_search.do?surveyno=${surveyVO.surveyno}&word='">검색 취소</button>  
      </c:if>    
    </form>
  </DIV>
  
  <DIV class='menu_line'></DIV>
  
  <FORM name='frm' method='POST' action='./create.do' enctype="multipart/form-data">
    <input type="hidden" name="surveyno" value="${param.surveyno }">

    <div>
       <label>설문 항목 번호</label>
       <input type='text' name='surveyno' value="${param.surveyno }" required="required" 
                 autofocus="autofocus" class="form-control" style='width: 100%;'>
    </div>

    <div>
       <label>항목 내용</label>
       <textarea name='item' required="required" class="form-control" rows="12" style='width: 100%;'></textarea>
    </div>
      
    <div class="content_body_bottom">
      <button type="submit" class="btn btn-primary">등록</button>
      <button type="button" onclick="location.href='./list_by_surveyno.do?surveyno=${param.surveyno}'" class="btn btn-primary">목록</button>
    </div>
  
  </FORM>
</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>