<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">

<script type="text/javascript">
  $(function() {
    // $('#panel_update').hide();
  });



  // 삭제
  function read_delete_ajax(reviewno) {
    $('#panel_delete_msg').html('삭제 정보를 읽어오는 중입니다.'); // 메시지 출력
    $('#frm_delete_name').html('카테고리: '); // 카테고리 이름 출력

    $('#panel_create').hide();
    $('#panel_delete').show();
        
    // alert(cateno);
    
     
        // $('#cnt', frm).val(rdata.cnt);
        // frm폼의 id가 name인 태그에 rdata json 객체의 name 변수의 값을 저장 
        
    var params = "";
    params = 'reviewno=' + reviewno; // 공백이 값으로 있으면 안됨.
    
     // params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    // alert('params: ' + params);
    // return;
    $.ajax({
      url: '/review/read_ajax_json.do',
      type: 'get',  // get, post
      cache: false, // 응답 결과 임시 저장 취소
      async: true,  // true: 비동기 통신
      dataType: 'json', // 응답 형식: json, html, xml...
      data: params,      // 데이터
      success: function(rdata) { // 응답이 온경우
        let frm = $('#frm_delete');

        
        // <div id="panel_delete_msg" class="msg_warning">카테고리를 삭제하면 복구 할 수 없습니다.</div>
        let msg ="";
         msg = "카테고리를 삭제하면 복구 할 수 없습니다.";
          $('#btn_submit', frm).show(); // 삭제 버튼 출력
        $('#panel_delete_msg').html(msg); // 메시지 출력
        
        // frm폼의 id가 cateno인 태그에 rdata json 객체의 cateno 변수의 값을 저장 
        $('#reviewno', frm).val(rdata.reviewno);
        $('#frm_delete_name').html('카테고리: ');

        $('#panel_delete_animation').hide(); // 태그 감추기
      },
      error: function(request, status, error) { // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우
        console.log(error);
      }
    });
  
    $('#panel_delete_animation').css('text-align', 'center'); // style 접근
    $('#panel_delete_animation').html("<img src='/fcate/images/ani01.gif' style='width: 3%;'>");
    $('#panel_delete_animation').show(); // 숨겨진 태그의 출력
        
  }

  
  // 수정 취소, 삭제 취소
  function cancel() {
    $('#panel_create').show();
    $('#panel_delete').hide();
  }
</script>
    
</head> 
 
<body>
<c:import url="/menu/top.do" />
 
<DIV class='title_line'>${frcontentsVO.fr_name} 리뷰 </DIV>
<DIV class='content_body'>
  <%-- 등록 --%>
  <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%;  text-align: center; border: solid 2px; border-radius: 10px;' >
    <FORM name='frm_create' id='frm_create' method='POST' action='/review/create.do'>
    <input type="hidden" name="frno" id="frno" value="${param.frno}">
     <input type="hidden" name="memberno" id="memberno" value="${sessionScope.memberno }">
  <c:choose>
      <c:when test="${sessionScope.id != null}">
       <label class='review_label'>리뷰</label>
      <input type='text' name='review_content' value='' required="required" style='width: 70%; height: 100px;' autofocus="autofocus">
         <label class='review_label'>평점</label>
         <input type='number' name='rating' id="rating" value=' ' required="required" min="1" max="5" step="1" style='width: 5%;'>
      <button type="submit"  class="btn btn-dark" id='submit'>등록</button>
        </c:when>
        <c:otherwise>
          <a class="nav-link" href='/member/login.do'>로그인하여 리뷰 쓰기</a>
      </c:otherwise>
   </c:choose>
    </FORM>
  </DIV>
  
    <%-- 삭제 --%>
  <DIV id='panel_delete' style='display: none; padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <div id="panel_delete_msg" class="msg_warning">삭제 정보를 읽어오는 중입니다.</div>
    <FORM name='frm_delete' id='frm_delete' method='POST' action='./read_delete.do'>
      <!-- 삭제할 글 번호 -->
      <input type='hidden' name='reviewno' id='reviewno' value="">
     
     <span id="frm_delete_name"></span> <%-- 삭제할 카테고리 이름 --%>
       
      <button type="submit" id='btn_submit'>삭제</button>
      <button type="button" onclick="cancel()">취소</button>
      
      <span id='panel_delete_animation' style='display: none;'></span>
    </FORM>
  </DIV>
  
  <TABLE class='table table-hover'>
    <colgroup>
      <col style='width: 10%;'/>
      <col style='width: 60%;'/>
      <col style='width: 10%;'/>    
    </colgroup>
   
    <thead>  
    <TR>
      <TH class="th_bs">닉네임</TH>
      <TH class="th_bs">리뷰 내용</TH>
      <TH class="th_bs">평점</TH>
    </TR>
    </thead>
    
    <tbody>
    
    <c:forEach var="reviewVO" items="${list }">
      <c:set var="nickname" value="${reviewVO.nickname }" />
      <c:set var="review_content" value="${reviewVO.review_content }" />
      <c:set var="rating" value="${reviewVO.rating }" />
      <c:set var="reviewno" value="${reviewVO.reviewno }" />

      <TR>
        <TD class="td_bs">${reviewVO.nickname}</TD>
        <TD class="td_bs_left">${reviewVO.review_content }</TD>
        <TD class="td_bs">${reviewVO.rating }</TD>
        <TD class="td_bs"> <A href="javascript: read_delete_ajax(${reviewno})" title=" 삭제"><IMG src="/fcate/images/delete.png" class="icon"></A> </TD>
  
      </TR> 
      
    </c:forEach>
    </tbody>
   
  </TABLE>
  
    <!-- 페이지 목록 출력 부분 시작 -->
  <DIV class='bottom_menu'>${paging }</DIV> <%-- 페이지 리스트 --%>
  <!-- 페이지 목록 출력 부분 종료 -->
</DIV>

 

</body>
 
</html>
 