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
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    
</head> 
 
<body>
<c:import url="/menu/top.do" />

 <form name='topic' action='./surveyitem/read_delete.do' method='GET'>
   <input type='hidden' name='surveyno' value='${param.surveyno }' >
   <input type='hidden' name='surveyitemno' value='${param.surveyitemno }' >
 
<DIV class='title_line'>
  <A href="./list_by_surveyno.do?surveyno=${surveyVO.surveyno }" class='title_link'>${surveyVO.topic }</A>
</DIV>

<DIV class='title_line'>설문조사 > [${surveyitemVO.item}] 삭제</DIV>

<DIV class='content_body'>
  <DIV id='panel_delete' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <div class="msg_warning">설문조사를 삭제하면 복구 할 수 없습니다.</div>
    <FORM name='frm_delete' id='frm_delete' method='GET' action='./read_delete.do'>
      <!-- 삭제할 설문 번호 -->
      <input type='hidden' name='surveyitemno' id='surveyitemno' value="${surveyitemVO.surveyitemno}">
      
      <label>설문조사</label>: ${surveyitemVO.item } 
       
      <button type="submit" id='submit'>삭제</button>
      <button type="button" onclick="location.href='./list_by_surveyno.do'">취소</button>
    </FORM>
  </DIV>
  
  <DIV class='content_body'>
  <ASIDE class="aside_right">
    <A href="./create.do?surveyno=${surveyVO.surveyno }">등록</A>
    <span class='menu_divide' >│</span>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>
    <A href="./list_by_surveyno_grid1.do?surveyno=${surveyVO.surveyno }">갤러리형</A>
  </ASIDE> 

  <DIV class='menu_line'></DIV>

  <table class="table table-striped" style='width: 100%;'>
    <colgroup>
      <col style="width: 10%;"></col>
      <col style="width: 60%;"></col>
      <col style="width: 30%;"></col>
    </colgroup>
    <tbody>
      <c:forEach var="surveyitemVO" items="${list }" varStatus="prop" >
        <c:set var="surveyno" value="${surveyitemVO.surveyno }" />
        
        <tr style="height: 30px;"> 
          <td style='vertical-align: middle; text-align: center;'>
            <c:choose>
              <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}"> <%-- 이미지인지 검사 --%>
                <%-- /static/surveyitem/storage/ --%>
                <a href="./read.do?surveyitemno=${surveyitemno}&now_page=${param.now_page }"><IMG src="/surveyitem/storage/${thumb1 }" style="width: 120px; height: 80px;"></a> 
              </c:when>
            </c:choose>
          </td>  
          <td style='vertical-align: middle;'> 

     
            <label style="cursor: pointer;">
            <input type="radio" name="surveyitemno" value="${surveyitemVO.surveyno}" > ${surveyitemVO.item}
            </label>
          </td> 
         

          <td style='vertical-align: middle; text-align: center;'>
            <A href="./read_update.do?surveyitemno=${surveyno }&surveyitemno=${surveyitemno}" title="수정"><IMG src="/surveyitem/images/update.png" class="icon"></A>
            <A href="./read_delete.do?surveyitemno=${surveyno }&surveyitemno=${surveyitemno}" title="삭제"><IMG src="/surveyitem/images/delete.png" class="icon"></A>
          </td> 
       </tr>
      </c:forEach>
     
            
    </tbody>
  </table>
</DIV>

       <div class="content_body_bottom">
       <button type="submit" class="btn btn-primary">참여</button>
       </div>
 </form>

 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>
 