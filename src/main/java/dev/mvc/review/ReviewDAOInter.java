package dev.mvc.review;

import java.util.ArrayList;
import java.util.HashMap;

import dev.mvc.fcate.FCateVO;

public interface ReviewDAOInter {

  /**
   * 등록
   * @param frcontentsVO
   * @return 등록한 레코드 개수
   */
  public int create(ReviewVO reviewVO);
 
  /**
   * 검색 + 페이징 목록
   * @param map
   * @return
   */
  public ArrayList<ReviewVO> list_by_cateno_search_paging(HashMap<String, Object> map);
  
  /**
   * 검색된 레코드 수
   * @param hashMap 검색어
   * @return 검색된 레코드 수
   */
  public int search_count(HashMap hashMap);

  /**
   * 삭제
   * @param reviewno
   * @return 삭제된 레코드 갯수
   */
  public int delete(ReviewVO reviewVO);
  
  /**
   * 조회
   * <xmp><select id="read" resultType="dev.mvc.cate.CateVO" parameterType="int"></xmp>
   * @param reviewno
   * @return
   */
  public ReviewVO read(int reviewno);
  
  /**
   * 평균
   * <xmp>
   * @param frno
   * @return
   */
  public double rating_avg(int frno);
}
