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

<DIV class='title_line'>설문조사 > [${surveyVO.topic}] 삭제</DIV>

<DIV class='content_body'>
  <DIV id='panel_delete' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <div class="msg_warning">설문조사를 삭제하면 복구 할 수 없습니다.</div>
    <FORM name='frm_delete' id='frm_delete' method='POST' action='./read_delete.do'>
      <!-- 삭제할 설문 번호 -->
      <input type='hidden' name='surveyno' id='surveyno' value="${surveyVO.surveyno}">
      
      <label>설문조사</label>: ${surveyVO.topic } 
       
      <button type="submit" id='submit'>삭제</button>
      <button type="button" onclick="location.href='./list_all.do'">취소</button>
    </FORM>
  </DIV>

  <TABLE class='table table-hover'>
    <colgroup>
      <col style='width: 25%;'/>
      <col style='width: 25%;'/>
      <col style='width: 15%;'/>    
      <col style='width: 20%;'/>
      <col style='width: 15%;'/>
    </colgroup>
   
    <thead>  
    <TR>
      <TH class="th_bs">설문 번호</TH>
      <TH class="th_bs">주제</TH>
      <TH class="th_bs">진행 여부</TH>
      <TH class="th_bs">등록일</TH>
      <TH class="th_bs">기타</TH>
    </TR>
    </thead>
    
    <tbody>
    <c:forEach var="surveyVO" items="${list }">
      <c:set var="surveyno" value="${surveyVO.surveyno }" />
      <c:set var="topic" value="${surveyVO.topic }" />
      <c:set var="cnt" value="${surveyVO.yn }" />
      <c:set var="rdate" value="${surveyVO.rdate.substring(0, 16) }" />

      <TR>
<TD class="td_bs">${surveyno}</TD>
        <TD class="td_bs_left">${topic}</TD>
        <TD class="td_bs">${yn }</TD>
        <TD class="td_bs">${rdate}</TD>
        <TD class="td_bs">
          <A href="./read_update.do?surveyno=${surveyno}" title="수정"><IMG src="/survey/images/update.png" class="icon"></A>
          <A href="./read_delete.do?surveyno=${surveyno}" title="삭제"><IMG src="/survey/images/delete.png" class="icon"></A>
          
        </TD>   
      </TR> 
      
    </c:forEach>
    </tbody>
   
  </TABLE>
</DIV>

 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>
 