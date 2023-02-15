<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>http://localhost:9091/recommend_food/mf_food.do</title> 
<script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
                 
<link href="/css/style.css" rel='Stylesheet' type='text/css'> <!-- /static -->
<script type="text/javascript">
$(function() {
  $('#btn_send').on('click', send);  // id가 btn_send인 태그를 찾아 click시 send 함수가 실행 되도록 이벤트 처리 함수 등록
  
});

function send() {
  let params = $('#frm').serialize(); // id가 frm인 태그를 찾아 폼의 값을 직렬화, 폼의 데이터를 키와 값의 구조로 조합
  // alert('params: ' + params);
  // return; // 함수 실행 중지
  
  // 동기: 응답이 올때까지 계속 기다림  예) 통화 상태
  // 비동기:  web에서는 사용자에게 무언가 중간 처리 상황을 전달할 필요가 있음으로 많이 사용, 응답을 기다리지 않고 계속 다음 코드 실행.
  //           응답이 오면 그때 실행  예) 세탁소에가서 세탁을하는동안 미용실에 가는 경우
  $.ajax({
    url: 'http://192.168.12.7:8000/recommend_food/mf_food', // form action
    type: 'get',          // form method, get
    cache: false,          // 응답 결과 임시 저장 취소
    async: true,           // true: 비동기 통신, false: 동기
    dataType: 'json',    // 응답 형식: json, html, xml...
    data: params,        // 데이터, 폼의 데이터를 키와 값의 구조로 조합
    success: function(rdata) { // 응답이 온경우
      // alert(rdata);
    	// $('#panel').html(rdata);  // 보통 DIV, SPAN등에 출력
    	      
      // rdata = JSON.parse(rdata);

      let tags = '';
      tags += "<DIV style='text-align: center;'>데이터 " + rdata.length + " 건</DIV>"
      tags += "<DIV style='margin: 0px auto; width: 75%;'>";  
      for (var i=0; i< rdata.length; i++) {  // 0 ~ 2
    	  tags += "<DIV style='margin: 0px auto; width: 19.5%; float: left;'>";  
        let row = rdata[i]; // 배열에서 하나의 객체 추출 ★
        tags += "frno: " + row.frno + "<br>";
        tags += "fr_name: " + row.fr_name +"<br>";
        tags += "food_rating: " + row.food_rating + "</li>";
        tags += "</DIV>";
      }
      tags += "</DIV>";
      
      $('#panel').html(tags);  // 보통 DIV, SPAN등에 출력
    },
    // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
    error: function(request, status, error) { // callback 함수
      console.log(error);
    }
  });
  
  // $('#panel').html('급여를 조회 중입니다...');
  // Spring의 응답을 기다리는 동안 animation 출력
  $('#panel').html("<img src='/recommend_food/images/ani04.gif' style='width: 10%;'>"); // static
  $('#panel').show(); // 숨겨진 태그의 출력
}

</script>
</head> 
<body>
<DIV class="title_line" style='width: 80%;'>AI 기반 영화 추천 받기</DIV>

<%-- Ajax 응답 출력, animation 출력, display: none: 태그를 숨기는 기능 --%>
<DIV id='panel' style='display: none; margin: 10px auto; text-align: center; width: 100%;'></DIV>

<DIV style='width: 80%; margin: 0px auto;'> 
  <FORM name='frm' id='frm' style='width: 80%; margin: 0px auto;'>
    <TABLE class='table' style='width: 80%; margin: 0px auto;'>
      <TR>
        <TH>회원 번호</TH>
        <TD><input type='number' name='memberno' id='memberno' size='10' value='1' class='form-control'></TD>
      </TR>
    </TABLE>
    
    <DIV class='bottom_menu'>
       <button type='button' id='btn_send' class='btn btn-primary'>추천 받기</button>
    </DIV>
  </FORM> 
</DIV> <!-- content_body END -->

</body>
 
</html>

