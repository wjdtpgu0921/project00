package dev.mvc.favorites;

import java.util.ArrayList;

// Spring framework?? ? κ³΅ν? κΈ°λ₯
// application.propertiesλ₯? ?½?΄? DBMS ?°κ²?/?΄?  ?? κ΅¬ν
// try ~ catch ?? κ΅¬ν
// surveyVO κ°μ SQL? ?? ? ?¬ λ°? ?€?
// return ?? κ΅¬ν
public interface FavoritesDAOInter {
  /**
   * ?±λ‘?
   * <xmp><insert id="create" parameterType="dev.mvc.survey.SurveyVO"></xmp>
   * @param surveyVO
   * @return ?±λ‘ν ? μ½λ κ°μ
   */
  public int create(FavoritesVO favoritesVO);
  
  
  /**
   * μ‘°ν
   * <xmp><select id="read" resultType="dev.mvc.survey.SurveyVO" parameterType="int"></xmp>
   * @param surveyno
   * @return
   */
  public ArrayList<FavoritesVO> read(int memberno);
  
  
  /**
   * ?­? 
   * @param surveyno
   * @return ?­? ? ? μ½λ ?
   */
  public int delete(int frno);
  
}


