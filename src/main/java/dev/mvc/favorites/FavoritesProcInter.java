package dev.mvc.favorites;

import java.util.ArrayList;

// ?��?��?�� 처리 �??�� ?��고리�? 구현, ?��칙연?��, ?��?���?
public interface FavoritesProcInter {
  /**
   * ?���?
   * @param surveyVO
   * @return ?��록한 ?��코드 개수
   */
  public int create(FavoritesVO favoritesVO);
  
  /**
   * 조회
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


