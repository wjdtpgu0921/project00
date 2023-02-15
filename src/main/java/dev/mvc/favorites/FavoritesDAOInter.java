package dev.mvc.favorites;

import java.util.ArrayList;

// Spring framework?��?�� ?��공하?�� 기능
// application.properties�? ?��?��?�� DBMS ?���?/?��?�� ?��?�� 구현
// try ~ catch ?��?�� 구현
// surveyVO 값을 SQL?�� ?��?�� ?��?�� �? ?��?��
// return ?��?�� 구현
public interface FavoritesDAOInter {
  /**
   * ?���?
   * <xmp><insert id="create" parameterType="dev.mvc.survey.SurveyVO"></xmp>
   * @param surveyVO
   * @return ?��록한 ?��코드 개수
   */
  public int create(FavoritesVO favoritesVO);
  
  
  /**
   * 조회
   * <xmp><select id="read" resultType="dev.mvc.survey.SurveyVO" parameterType="int"></xmp>
   * @param surveyno
   * @return
   */
  public ArrayList<FavoritesVO> read(int memberno);
  
  
  /**
   * ?��?��
   * @param surveyno
   * @return ?��?��?�� ?��코드 ?��
   */
  public int delete(int frno);
  
}


