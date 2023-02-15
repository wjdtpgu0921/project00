<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>관심분야 등록</title>
    <link href="/css/style.css" rel="Stylesheet" type="text/css"> <%-- /static 기준 --%>

    <script type="text/JavaScript"
                 src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

    <script type="text/javascript">
      $(function() { // 자동 실행
        $('#btn_forward').on('click', function() { location.href='/type2_recommend_food/form1.do';});
        $('#btn_close').on('click', function() { window.close(); });     // 윈도우 닫기
      });
    </script>
</head>
<body>
<DIV class="container">
    <H3 style="text-align: center; margin-top: 10px;">관심분야 등록</H3>

    <DIV style="text-align:center; margin: 20px auto; width: 100%;">
        관심 분야를 등록하시면 최적의 음식 추천 서비스를 이용하실수 있습니다.<br><br>
        등록은 관심 분야의 음식을 선택하며 몇번의 클릭만으로 바로 종료됩니다.
    </DIV>

    <DIV style="text-align:center; margin: 50px auto;">
        <button type='button' id='btn_forward' class='btn btn-info'>관심분야 등록하기</button>
        <button type='button' id='btn_close' class='btn btn-info'>취소</button>
    </DIV>

</DIV>
</body>
</html>

