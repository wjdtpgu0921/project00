package dev.mvc.frcontents;

import java.util.ArrayList;
import java.util.HashMap;

public interface FRContentsDAOInter {

  /**
   * 등록
   * @param frcontentsVO
   * @return 등록한 레코드 개수
   */
  public int create(FRContentsVO frcontentsVO);
  
  /**
   * 검색된 레코드 수
   * @param hashMap 검색어
   * @return 검색된 레코드 수
   */
  public int search_count(HashMap hashMap);
 
  
  /**
   * 특정 레코드 목록
   * <xmp><select id="list_by_cateno" resultType="dev.mvc.contents.ContentsVO" parameterType="int"></xmp>
   * @return 레코드 전체 목록
   */
  public ArrayList<FRContentsVO> list_by_cateno(int cateno);
  
  /**
   * 검색 + 페이징 목록
   * @param map
   * @return
   */
  public ArrayList<FRContentsVO> list_by_cateno_search_paging(HashMap<String, Object> map);
  
  /**
   * 조회
   * @param contentsno 조회할 레코드 번호(PK)
   * @return 조회된 레코드
   */
  public FRContentsVO read(int frno);
  
  /**
   * 글 정보 수정
   * @param contentsVO
   * @return 처리된 레코드 갯수
   */
  public int update_text(FRContentsVO frcontentsVO);
  
  /**
   * 파일 정보 수정
   * @param contentsVO
   * @return 처리된 레코드 갯수
   */
  public int update_file(FRContentsVO frcontentsVO);


  /**
   * 삭제
   * @param contentsno
   * @return 삭제된 레코드 갯수
   */
  public int delete(int frno);
  
  /**
   * 카테고리 번호에 의한 카운트 
   * @param cateno 카테고리 번호
   * @return 갯수
   */
  public int count_by_cateno(int cateno);
  
  /**
   * MAP 등록/수정/삭제
   * @param hashMap
   * @return 수정된 레코드 수
   */
  public int map(HashMap<String, Object> hashMap);
  
  /**
   * 추천 목록
   * @return
   */
  public ArrayList<FRContentsVO> mf_food_member(HashMap<String, Object> hashMap); 
  
  /**
   * 평점
   * @param frcontentsVO
   * @return 처리된 레코드 수
   */
  public void update_ratings(FRContentsVO frcontentsVO);
  
  /**
   * 검색 + 페이징 목록
   * @param map
   * @return
   */
  public ArrayList<FRContentsVO> list_by_cateno_search_paging_all(HashMap<String, Object> map);
  
  /**
   * 검색된 레코드 수
   * @param hashMap 검색어
   * @return 검색된 레코드 수
   */
  public int search_count_all(HashMap hashMap);
}
