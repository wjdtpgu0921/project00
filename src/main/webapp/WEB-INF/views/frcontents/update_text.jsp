<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="frno" value="${frcontentsVO.frno }" />
<c:set var="cateno" value="${frcontentsVO.cateno }" />
<c:set var="fr_name" value="${frcontentsVO.fr_name }" />        
<c:set var="price" value="${frcontentsVO.price }" />
<c:set var="file1" value="${frcontentsVO.file1 }" />
<c:set var="file1saved" value="${frcontentsVO.file1saved }" />
<c:set var="thumb1" value="${frcontentsVO.thumb1 }" />
<c:set var="size1" value="${frcontentsVO.size1 }" />
<c:set var="fr_content" value="${frcontentsVO.fr_content }" />
<c:set var="fr_addres" value="${frcontentsVO.fr_addres }" />
<c:set var="fr_word" value="${frcontentsVO.fr_word }" />
<c:set var="size1_label" value="${frcontentsVO.size1_label }" />
<c:set var="fr_map" value="${frcontentsVO.fr_map }" />

 
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
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    
</head> 
 
<body>
<c:import url="/menu/top.do" />
 
<DIV class='title_line'><A href="./list_by_cateno_search_paging.do?cateno=${cateno }" class='title_link'>${fcateVO.name }</A> > 글 수정</DIV>

<DIV class='content_body'>
  <ASIDE class="aside_right">
    <c:if test="${sessionScope.admin_id != null }">
      <A href="./create.do?cateno=${fcateVO.cateno }">등록</A>
      <span class='menu_divide' >│</span>
    </c:if>
    
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>
    <A href="./list_by_cateno_search_paging.do?cateno=${fcateVO.cateno }">기본 목록형</A>    
    <span class='menu_divide' >│</span>
    <A href="./list_by_cateno_grid.do?cateno=${fcateVO.cateno }">갤러리형</A>
  </ASIDE> 
  
  <%-- 검색 폼 --%>
  <DIV style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='get' action='./list_by_cateno_search_paging.do'>
      <input type='hidden' name='cateno' value='${fcateVO.cateno }'>  <%-- 게시판의 구분 --%>
      
      <c:choose>
        <c:when test="${param.word != '' }"> <%-- 검색하는 경우 --%>
          <input type='text' name='fr_word' id='fr_word' value='${param.fr_word }' style='width: 20%;'>
        </c:when>
        <c:otherwise> <%-- 검색하지 않는 경우 --%>
          <input type='text' name='fr_word' id='fr_word' value='' style='width: 20%;'>
        </c:otherwise>
      </c:choose>
      <button type='submit'>검색</button>
      <c:if test="${param.word.length() > 0 }">
        <button type='button' 
                     onclick="location.href='./list_by_cateno_search_paging.do?cateno=${fcateVO.cateno}&word='">검색 취소</button>  
      </c:if>    
    </form>
  </DIV>
  
  <DIV class='menu_line'></DIV>
  <%--수정 폼 --%>
  <FORM name='frm' method='POST' action='./update_text.do'>
    <input type="hidden" name="frno" value="${frno }">
    <input type="hidden" name="cateno" value="${cateno }">
    <input type="hidden" name="adminno" value="1"> <%-- 관리자 개발후 변경 필요 --%>
    
   <div>
       <label>가게 이름</label>
       <input type='text' name='fr_name' value=${fr_name } required="required" 
                 autofocus="autofocus" class="form-control" style='width: 100%;'>
    </div>
    <div>
       <label> 맛집 설명</label>
       <textarea name='fr_content' required="required" class="form-control" rows="12" style='width: 100%;'>${fr_content }</textarea>
    </div>
    <div>
       <label>맛집 주소</label>
       <input type='text' name='fr_addres' value=${fr_addres } required="required" 
                 class="form-control" style='width: 100%;'>
    </div>   
    <div>
       <label>가격</label>
       <input type='text' name='price' value=${price } required="required" 
                 class="form-control" style='width: 100%;'>
    </div>   
    <div>
       <label>검색어</label>
       <input type='text' name='fr_word' value=${fr_word } required="required" 
                 class="form-control" style='width: 100%;'>
    </div>  
  <div class="content_body_bottom">
      <button type="submit" class="btn btn-primary">저장</button>
      <button type="button" onclick="history.back();" class="btn btn-primary">취소</button>
      <button type="button" onclick="location.href='./list_by_cateno_search_paging.do?cateno=${cateno}'" class="btn btn-primary">목록</button>
    </div>
  
  </FORM>
</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>

