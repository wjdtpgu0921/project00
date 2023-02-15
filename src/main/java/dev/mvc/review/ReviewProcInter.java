package dev.mvc.review;

import java.util.ArrayList;
import java.util.HashMap;

public interface ReviewProcInter {

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
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param 맛집번호          맛집 번호
   * @param search_count  검색(전체) 레코드수 
   * @param now_page      현재 페이지
   * @return 페이징 생성 문자열
   */ 
  public String pagingBox(int frno, int search_count, int now_page);
  
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
