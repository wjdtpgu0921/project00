<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>관심분야 등록</title>
    <link href="/css/style.css" rel="Stylesheet" type="text/css">
    <script type="text/JavaScript"
                 src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    
    <script type="text/javascript">
        $(function() {
            send();  // Django ajax 호출
            $('#btn_previous').on('click', function() { history.back(); });   // 이전
            $('#btn_close').on('click', function() { window.close(); });      // 윈도우 닫기
        });

        function send() {
            var params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
            // alert('params: ' + params);  // 수신 데이터 확인
            $.ajax({
              url: 'http://localhost:8000/type2_recommend_food/end_ajax',  // Spring Boot -> Django 호출
              type: 'get',  // get or post
              cache: false, // 응답 결과 임시 저장 취소
              async: true,  // true: 비동기 통신
              dataType: 'json', // 응답 형식: json, html, xml...
              data: params,      // 데이터
              success: function(rdata) { // 응답이 온경우
                // alert(rdata.index);
                if (rdata.index == 0) {        // 개발 관련 도서 추천 필요
                    $('#korean').css('display',''); // show
                } else if(rdata.index == 1) { // 해외 여행 관련 도서 추천 필요
                    $('#eng').css('display','');
                } else if(rdata.index == 2) {                            // 소설 관련 도서 추천 필요
                    $('#china').css('display','');
                } else if(rdata.index == 3) {                            // 소설 관련 도서 추천 필요
                    $('#jap').css('display','');
                } else if(rdata.index == 4) {                            // 소설 관련 도서 추천 필요
                    $('#bet').css('display','');
                } else {                            // 소설 관련 도서 추천 필요
                    $('#tha').css('display','');
                } 
             


                // Upgrade
                // Spring Boot로 Ajax -> favorite 테이블 insert
                // -> 카테고리를 파악헀음으로 카테고리의 평점이 높은 상품을 내림차순으로 정렬 로딩
                // -> 로딩된 상품 정보를 마지막 페이지에 출력
                $('#panel').html("");  // animation gif 삭제
                $('#panel').css('display', 'none'); // 숨겨진 태그의 출력

                // --------------------------------------------------
                // 분류 정보에 따른 상품 이미지 SELECT
                //  --------------------------------------------------
              },
              // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우
              error: function(request, status, error) { // callback 함수
                console.log(error);
              }
            });

            // $('#panel').html('처리중입니다....');  // 텍스트를 출력하는 경우
            $('#panel').html("<img src='/type2_recommend_food/images/ani04.gif' style='width: 10%;'>");
            $('#panel').show(); // 숨겨진 태그의 출력
          }
    </script>

    <style>
        *{
            text-align: center;
        }

        .td_image{
            vertical-align: middle;
            padding: 5px;
            cursor: pointer;
        }

    </style>
    
</head>
<body>

<DIV style='display: none;'>
    <form name='frm' id='frm'>
        <input type='hidden' name='step1' value='${param.step1 }'>
        <input type='hidden' name='step2' value='${param.step2 }''>
        <input type='hidden' name='step3' value='${param.step3 }''>
        <input type='hidden' name='step4' value='${param.step4 }''>
        <input type='hidden' name='step5' value='${param.step5 }''>
        <input type='hidden' name='step6' value='${param.step6 }''>
    </form>
</DIV>

<DIV class="container">
    <H3 style=' margin-top: 10px;'>참여해주셔서 감사합니다.</H3>
    <H3>추천 음식</H3>

    <DIV id='panel' style='margin: 30px auto; width: 90%;'></DIV>
    
    <DIV id='panel_img' style='margin: 0px auto; width: 90%;'>
        <DIV id='korean' style='display: none;'> <!-- 개발 관련 도서 추천 필요 -->
        한식 추천해 드립니다
            <TABLE style='margin: 0px auto;'>
                <TR>
                    <TD class='td_image'>
                        <img id='img1' src="/type2_recommend_food/images/v11.jpg" style='float:left; height: 180px'>
                    </TD>
                    <TD class='td_image'>
                        <img id='img2' src="/type2_recommend_food/images/v21.jpg" style='float:left; height: 180px'>
                    </TD>
                    <TD class='td_image'>
                        <img id='img3' src="/type2_recommend_food/images/v31.jpg" style='float:left; height: 180px'>
                    </TD>
                </TR>  
                <TR>
            <TD class='td_image'>
                    <img id='img4' src="/type2_recommend_food/images/v41.jpg" style='float:left; height: 180px'>
                </TD>
                <TD class='td_image'>
                    <img id='img5' src="/type2_recommend_food/images/v51.jpg" style='float:left; height: 180px'>
                </TD>
                <TD class='td_image'>
                    <img id='img6' src="/type2_recommend_food/images/v61.jpg" style='float:left; height: 180px'>
                </TD>
             </TR>
            <TR>        
            </TABLE>
        </DIV>
        <DIV id='eng' style='display: none;'>  <!-- 해외 여행 관련 도서 추천 필요 -->
            양식 추천해 드립니다
            <TABLE style='margin: 0px auto;'>
                <TR>
                    <TD class='td_image'>
                        <img id='img1' src="/type2_recommend_food/images/v12.jpg" style='float:left; height: 180px'>
                    </TD>
                    <TD class='td_image'>
                        <img id='img2' src="/type2_recommend_food/images/v22.jpg" style='float:left; height: 180px'>
                    </TD>
                    <TD class='td_image'>
                        <img id='img3' src="/type2_recommend_food/images/v32.jpg" style='float:left; height: 180px'>
                    </TD>
                </TR>    
                <TR>
            <TD class='td_image'>
                    <img id='img4' src="/type2_recommend_food/images/v42.jpg" style='float:left; height: 180px'>
                </TD>
                <TD class='td_image'>
                    <img id='img5' src="/type2_recommend_food/images/v52.jpg" style='float:left; height: 180px'>
                </TD>
                <TD class='td_image'>
                    <img id='img6' src="/type2_recommend_food/images/v62.jpg" style='float:left; height: 180px'>
                </TD>
             </TR>      
            </TABLE>
        </DIV>
        <DIV id='china' style='display: none;'> <!-- 소설 관련 도서 추천 필요 -->
          중식 추천해 드립니다
            <TABLE style='margin: 0px auto;'>
                <TR>
                    <TD class='td_image'>
                        <img id='img1' src="/type2_recommend_food/images/v13.jpg" style='float:left; height: 180px'>
                    </TD>
                    <TD class='td_image'>
                        <img id='img2' src="/type2_recommend_food/images/v23.jpg" style='float:left; height: 180px'>
                    </TD>
                    <TD class='td_image'>
                        <img id='img3' src="/type2_recommend_food/images/v33.jpg" style='float:left; height: 180px'>
                    </TD>
                </TR>      
                <TR>
            <TD class='td_image'>
                    <img id='img4' src="/type2_recommend_food/images/v43.jpg" style='float:left; height: 180px'>
                </TD>
                <TD class='td_image'>
                    <img id='img5' src="/type2_recommend_food/images/v53.jpg" style='float:left; height: 180px'>
                </TD>
                <TD class='td_image'>
                    <img id='img6' src="/type2_recommend_food/images/v63.jpg" style='float:left; height: 180px'>
                </TD>
             </TR>    
            </TABLE>
        </DIV>
        <DIV id='jap' style='display: none;'> <!-- 소설 관련 도서 추천 필요 -->
          일식 추천해 드립니다
            <TABLE style='margin: 0px auto;'>
                <TR>
                    <TD class='td_image'>
                        <img id='img1' src="/type2_recommend_food/images/v14.jpg" style='float:left; height: 180px'>
                    </TD>
                    <TD class='td_image'>
                        <img id='img2' src="/type2_recommend_food/images/v24.jpg" style='float:left; height: 180px'>
                    </TD>
                    <TD class='td_image'>
                        <img id='img3' src="/type2_recommend_food/images/v34.jpg" style='float:left; height: 180px'>
                    </TD>
                </TR>      
                <TR>
            <TD class='td_image'>
                    <img id='img4' src="/type2_recommend_food/images/v44.jpg" style='float:left; height: 180px'>
                </TD>
                <TD class='td_image'>
                    <img id='img5' src="/type2_recommend_food/images/v54.jpg" style='float:left; height: 180px'>
                </TD>
                <TD class='td_image'>
                    <img id='img6' src="/type2_recommend_food/images/v64.jpg" style='float:left; height: 180px'>
                </TD>
             </TR>    
            </TABLE>
        </DIV>
        <DIV id='bet' style='display: none;'> <!-- 소설 관련 도서 추천 필요 -->
          베트남음식 추천해 드립니다
            <TABLE style='margin: 0px auto;'>
                <TR>
                    <TD class='td_image'>
                        <img id='img1' src="/type2_recommend_food/images/v15.jpg" style='float:left; height: 180px'>
                    </TD>
                    <TD class='td_image'>
                        <img id='img2' src="/type2_recommend_food/images/v25.jpg" style='float:left; height: 180px'>
                    </TD>
                    <TD class='td_image'>
                        <img id='img3' src="/type2_recommend_food/images/v35.jpg" style='float:left; height: 180px'>
                    </TD>
                </TR>      
                <TR>
            <TD class='td_image'>
                    <img id='img4' src="/type2_recommend_food/images/v45.jpg" style='float:left; height: 180px'>
                </TD>
                <TD class='td_image'>
                    <img id='img5' src="/type2_recommend_food/images/v55.jpg" style='float:left; height: 180px'>
                </TD>
                <TD class='td_image'>
                    <img id='img6' src="/type2_recommend_food/images/v65.jpg" style='float:left; height: 180px'>
                </TD>
             </TR>    
            </TABLE>
        </DIV>
        <DIV id='tha' style='display: none;'> <!-- 소설 관련 도서 추천 필요 -->
          태국음식 추천해 드립니다
            <TABLE style='margin: 0px auto;'>
                <TR>
                    <TD class='td_image'>
                        <img id='img1' src="/type2_recommend_food/images/v16.jpg" style='float:left; height: 180px'>
                    </TD>
                    <TD class='td_image'>
                        <img id='img2' src="/type2_recommend_food/images/v26.jpg" style='float:left; height: 180px'>
                    </TD>
                    <TD class='td_image'>
                        <img id='img3' src="/type2_recommend_food/images/v36.jpg" style='float:left; height: 180px'>
                    </TD>
                </TR>      
                <TR>
            <TD class='td_image'>
                    <img id='img4' src="/type2_recommend_food/images/v46.jpg" style='float:left; height: 180px'>
                </TD>
                <TD class='td_image'>
                    <img id='img5' src="/type2_recommend_food/images/v56.jpg" style='float:left; height: 180px'>
                </TD>
                <TD class='td_image'>
                    <img id='img6' src="/type2_recommend_food/images/v66.jpg" style='float:left; height: 180px'>
                </TD>
             </TR>    
            </TABLE>
        </DIV>
    </DIV>
    
    <form id='frm' name='frm' action='' method='GET'>
        <br>
        <DIV style="text-align:center;">
            <button type='button' id='btn_previous' class="btn btn-info">이전</button>
            <button type='button' id='btn_close' class="btn btn-info">종료</button>
        </DIV>
    </form>
</DIV>
</body>
</html>


