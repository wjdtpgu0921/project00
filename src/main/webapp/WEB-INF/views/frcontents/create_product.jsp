<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>

<!-- /static 기준 -->
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<script type="text/javascript" src="/ckeditor/ckeditor.js"></script> <!-- /static 기준 -->
 
<script type="text/JavaScript">
  // window.onload=function(){
  //  CKEDITOR.replace('content');  // <TEXTAREA>태그 name 값
  // };

  $(function() {
    CKEDITOR.replace('fr_content');  // <TEXTAREA>태그 name 값
  });
 
</script>   
</head> 
 
<body>
<c:import url="/menu/top.do" />
 
<DIV class='title_line'>${FcateVO.name } > 글 등록</DIV>

<DIV class='content_body'>
  <ASIDE class="aside_right">
    <c:if test="${sessionScope.admin_id != null }">
      <A href="./create.do?cateno=${FcateVO.cateno }">등록</A>
      <span class='menu_divide' >│</span>
    </c:if>
    
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>
    <A href="./list_by_cateno_search_paging.do?cateno=${FcateVO.cateno }">기본 목록형</A>    
    <span class='menu_divide' >│</span>
    <A href="./list_by_cateno_grid.do?cateno=${FcateVO.cateno }">갤러리형</A>
  </ASIDE> 
  
  <%-- 검색 폼 --%>
  <DIV style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='get' action='./list_by_cateno_search.do'>
      <input type='hidden' name='cateno' value='${FcateVO.cateno }'>  <%-- 게시판의 구분 --%>
      
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
                     onclick="location.href='./list_by_cateno_search.do?cateno=${FcateVO.cateno}&word='">검색 취소</button>  
      </c:if>    
    </form>
  </DIV>
  
  <DIV class='menu_line'></DIV>
  <%--등록 폼 --%>
  <FORM name='frm' method='POST' action='./create.do' enctype="multipart/form-data">
    <input type="hidden" name="cateno" value="${param.cateno }">
    <%-- <input type="hidden" name="adminno" value="1"> --%> <%-- 관리자 개발후 변경 필요 --%>
    
    <div>
       <label>가게 이름</label>
       <input type='text' name='fr_name' value='가게 이름' required="required" 
                 autofocus="autofocus" class="form-control" style='width: 100%;'>
    </div>
    <div>
       <label> 맛집 설명</label>
       <textarea name='fr_content' id='fr_content' required="required" class="form-control" rows="12" style='width: 100%;'>맛있다</textarea>
    </div>
    <div>
       <label>맛집 주소</label>
       <input type='text' name='fr_addres' value='서울시 000000' required="required" 
                 class="form-control" style='width: 100%;'>
    </div>   
    <div>
       <label>가격</label>
		       <input type='text' name='price' value='10000원 이상' required="required" 
                 class="form-control" style='width: 100%;' >
    </div>   
    <div>
       <label>검색어</label>
       <input type='text' name='fr_word' value='월터,벤 스틸러,크리스튼위그,휴먼,도전' required="required" 
                 class="form-control" style='width: 100%;'>
    </div>   
    <div>
       <label>이미지</label>
       <input type='file' class="form-control" name='file1MF' id='file1MF' 
                 value='' placeholder="파일 선택">
    </div> 
    <div class="content_body_bottom">
      <button type="submit" class="btn btn-primary">등록</button>
      <button type="button" onclick="location.href='./list_by_cateno_search_paging.do?cateno=${param.cateno}'" class="btn btn-primary">목록</button>
    </div>
  
  </FORM>
</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>

