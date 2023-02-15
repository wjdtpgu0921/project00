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
 
<DIV class='title_line'>
  <A href="./list_all.do" class='title_link'>전체 글 목록</A>
</DIV>

<DIV class='content_body'>
  <ASIDE class="aside_right">
    <A href="javascript:location.reload();">새로고침</A>
  </ASIDE> 

  <DIV class='menu_line'></DIV>
  
  <table class="table table-striped" style='width: 100%;'>
    <colgroup>
      <col style="width: 10%;"></col>
      <col style="width: 10%;"></col>
      <col style="width: 50%;"></col>
      <col style="width: 20%;"></col>
      <col style="width: 10%;"></col>
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
      <c:forEach var="surveySurveyitemVO" items="${list }">
        <c:set var="name" value="${surveySurveyitemVO.name }" />
        <c:set var="title" value="${surveySurveyitemVO.title }" />
        <c:set var="content" value="${surveySurveyitemVO.content }" />
        <c:set var="surveyno" value="${surveySurveyitemVO.surveyno }" />
        <c:set var="surveyitemno" value="${surveySurveyitemVO.surveyitemno }" />
        <c:set var="thumb1" value="${surveySurveyitemVO.thumb1 }" />
        <c:set var="price" value="${surveySurveyitemVO.price }" />
        <c:set var="dc" value="${surveySurveyitemVO.dc }" />
        <c:set var="saleprice" value="${surveySurveyitemVO.saleprice }" />
        <c:set var="point" value="${surveySurveyitemVO.point }" />
        
        <tr style="height: 132px;">
          <td style='vertical-align: middle; text-align: center;'>
            ${name }
          </td>
          <td style='vertical-align: middle; text-align: center;'>
            <c:choose>
              <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}"> <%-- 이미지인지 검사 --%>
                <%-- /static/surveyitem/storage/ --%>
                <a href="./read.do?surveyitemno=${surveyitemno}&now_page=${param.now_page }"><IMG src="/surveyitem/storage/${thumb1 }" style="width: 120px; height: 80px;"></a> 
              </c:when>
              <c:otherwise> <!-- 기본 이미지 출력 -->
                <IMG src="/surveyitem/images/none1.png" style="width: 120px; height: 80px;">
              </c:otherwise>
            </c:choose>
          </td>  
          <td style='vertical-align: middle;'>
            <a href="./read.do?surveyitemno=${surveyitemno}&surveyno=${surveyno}"><strong>${title}</strong> 
            <c:choose>
              <c:when test="${content.length() > 160 }">
                  ${content.substring(0, 160)}.....
              </c:when>
              <c:when test="${content.length() <= 160 }">
                  ${content}
              </c:when>
            </c:choose>
            
            </a> 
          </td> 
          <td style='vertical-align: middle; text-align: center;'>
            <del><fmt:formatNumber value="${price}" pattern="#,###" /></del><br>
            <span style="color: #FF0000; font-size: 1.2em;">${dc} %</span>
            <strong><fmt:formatNumber value="${saleprice}" pattern="#,###" /></strong><br>
            <span style="font-size: 0.8em;">포인트: <fmt:formatNumber value="${point}" pattern="#,###" /></span>
          </td>
          <td style='vertical-align: middle; text-align: center;'>
            <A href="/surveyitem/map.do?surveyno=${surveyno }&surveyitemno=${surveyitemno}" title="지도"><IMG src="/surveyitem/images/map.png" class="icon"></A>
            <A href="/surveyitem/youtube.do?surveyno=${surveyno }&surveyitemno=${surveyitemno}" title="Youtube"><IMG src="/surveyitem/images/youtube.png" class="icon"></A>
          </td>
        </tr>
      </c:forEach>
      
    </tbody>
  </table>
</DIV>
 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>

