<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

</head> 
 
<body>
<c:import url="/menu/top.do" />
 
<DIV class='title_line'>
  <A class='title_link'></A>
</DIV>

<DIV class='content_body'>
  <ASIDE class="aside_right">
    <A href="javascript:location.reload();">새로고침</A>
  </ASIDE> 

  <%-- 검색 --%>
  <DIV style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='get' action='./list_by_cateno_search_paging.do'>
      <input type='hidden' name='cateno' value='${param.cateno }'>
      
      <c:choose>
        <c:when test="${param.fr_word != '' }"> <%-- 검색하는 경우 --%>
          <input type='text' name='fr_word' id='fr_word' value='${param.fr_word }' style='width: 20%;'>
        </c:when>
        <c:otherwise> <%-- 검색하지 않는 경우 --%>
          <input type='text' name='fr_word' id='fr_word' value='' style='width: 20%;'>
        </c:otherwise>
      </c:choose>
      <button type='submit'>검색</button>
      <c:if test="${param.fr_word.length() > 0 }">
        <button type='button' 
                     onclick="location.href='./list_by_cateno_search_paging.do?cateno=${fcateVO.cateno}&fr_word='">검색 취소</button>  
      </c:if>    
    </form>
  </DIV>
  
  <DIV class='menu_line'></DIV>
  
  <table class="table table-striped" style='width: 100%;'>
    <colgroup>
      <col style="width: 10%;"></col>
      <col style="width: 35%;"></col>
      <col style="width: 15%;"></col>
      <col style="width: 15%;"></col>
      <col style="width: 10%;"></col>
      <col style="width: 15%;"></col>
    </colgroup>
    <%-- table 컬럼 --%>
<!--     <thead>
      <tr>
        <th style='text-align: center;'>파일</th>
        <th style='text-align: center;'>상품명</th>
        <th style='text-align: center;'>정가, 할인률, 판매가, 포인트</th>
        <th style='text-align: center;'>기타</th>
      </tr>
    
    </thead> -->
    
    <%-- table 내용 --%>
    <tbody>

<c:forEach var="frcontentsVO" items="${list }">
        <c:set var="cateno" value="${frcontentsVO.cateno }" />
        <c:set var="frno" value="${frcontentsVO.frno }" />
        <c:set var="file1" value="${frcontentsVO.file1 }" />
        <c:set var="size1" value="${frcontentsVO.size1 }" />
        <c:set var="thumb1" value="${frcontentsVO.thumb1 }" />
        <c:set var="ratings" value="${frcontentsVO.ratings }" />
        
        <tr style="height: 132px;"> 
          <td style='vertical-align: middle; text-align: center;'>
            <c:choose>
              <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}"> <%-- 이미지인지 검사 --%>
                <%-- /static/contents/storage/ --%>
                <a href="./read.do?frno=${frno}&cateno=${cateno}&fr_word=${param.fr_word}&now_page=${param.now_page}"><IMG src="/frcontents/storage/${thumb1 }" style="width: 120px; height: 80px;"></a> 
              </c:when>
              <c:otherwise> <!-- 파일이 없거나 이미지가 아닌 경우 출력 -->
    
                <c:choose>
                  <c:when test="${size1 > 0 }"> <!-- 파일명 출력 -->
                    <a href="./read.do?frno=${frno}&cateno=${cateno}&fr_word=${param.fr_word}&now_page=${param.now_page}">${file1 }</a>
                  </c:when>
                  <c:when test="${size1 == 0 }"> <!-- 기본 이미지 출력 -->
                    <a href="./read.do?frno=${frno}&cateno=${cateno}&fr_word=${param.fr_word}&now_page=${param.now_page}"><IMG src="/frcontents/images/none1.png" style="width: 120px; height: 80px;"></a>
                  </c:when>
                </c:choose>   
              </c:otherwise>
            </c:choose>
          </td>  
          <td style='vertical-align: middle;'>
            <a href="/frcontents/read.do?frno=${frno}&cateno=${cateno}&fr_word=${param.fr_word}&now_page=${param.now_page}"><strong>${frcontentsVO.fr_name}</strong> 
            <c:choose>
              <c:when test="${frcontentsVO.fr_content.length() > 160 }">
                  ${frcontentsVO.fr_content.substring(0, 160)}.....
              </c:when>
              <c:when test="${frcontentsVO.fr_content.length() <= 160 }">
                  ${frcontentsVO.fr_content}
              </c:when>
            </c:choose>
            </a> 
           <td style='vertical-align: middle; text-align: center;'>
              ${frcontentsVO.fr_addres}
          </td> 
          <td style='vertical-align: middle; text-align: center;'>
              ${frcontentsVO.review_cnt}
          </td> 
           <td style='vertical-align: middle; text-align: center;'>
              ${frcontentsVO.price}
          </td> 
          <td style='vertical-align: middle; text-align: center;'>
            <A href="/frcontents/map.do?cateno=${cateno }&frno=${frno}&fr_word=${param.fr_word }" title="지도"><IMG src="/frcontents/images/map.png" class="icon"></A>
            <A href="/frcontents/update_text.do?cateno=${cateno }&frno=${frno}&fr_word=${param.fr_word }" title="글 수정"><IMG src="/frcontents/images/update.png" class="icon"></A>
            <A href="/frcontents/update_file.do?cateno=${cateno }&frno=${frno}&fr_word=${param.fr_word }" title="파일 수정"><IMG src="/frcontents/images/update_file.png" class="icon"></A>
            <A href="/frcontents/delete.do?cateno=${cateno }&frno=${frno}&fr_word=${param.fr_word }" title="삭제"><IMG src="/frcontents/images/delete.png" class="icon"></A>
   				 <form name='frm' id='frm' method='get' action='./favorites_delete.do'>
     			<input type='hidden' name='frno' value='${frno }'>
      			<button type='submit'>삭제</button>
   				 </form>
  			
          </td>
          
        </tr>
      </c:forEach>
    </tbody>
  </table>
</DIV>
 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>

