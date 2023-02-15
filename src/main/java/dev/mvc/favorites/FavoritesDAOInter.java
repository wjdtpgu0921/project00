package dev.mvc.favorites;

import java.util.ArrayList;

// Spring framework?—?„œ ? œê³µí•˜?Š” ê¸°ëŠ¥
// application.propertiesë¥? ?½?–´?„œ DBMS ?—°ê²?/?•´? œ ??™ êµ¬í˜„
// try ~ catch ??™ êµ¬í˜„
// surveyVO ê°’ì„ SQL?— ??™ ? „?‹¬ ë°? ?‹¤?–‰
// return ??™ êµ¬í˜„
public interface FavoritesDAOInter {
  /**
   * ?“±ë¡?
   * <xmp><insert id="create" parameterType="dev.mvc.survey.SurveyVO"></xmp>
   * @param surveyVO
   * @return ?“±ë¡í•œ ? ˆì½”ë“œ ê°œìˆ˜
   */
  public int create(FavoritesVO favoritesVO);
  
  
  /**
   * ì¡°íšŒ
   * <xmp><select id="read" resultType="dev.mvc.survey.SurveyVO" parameterType="int"></xmp>
   * @param surveyno
   * @return
   */
  public ArrayList<FavoritesVO> read(int memberno);
  
  
  /**
   * ?‚­? œ
   * @param surveyno
   * @return ?‚­? œ?œ ? ˆì½”ë“œ ?ˆ˜
   */
  public int delete(int frno);
  
}


