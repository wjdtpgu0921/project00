package dev.mvc.frcontents;

import java.util.ArrayList;
import java.util.HashMap;

public interface FRContentsProcInter {

  /**
   * 등록
   * @param frcontentsVO
   * @return 등록한 레코드 개수
   */
  public int create(FRContentsVO frcontentsVO);
  
  /**
   * 특정 레코드 목록
   * <xmp><select id="list_by_cateno" resultType="dev.mvc.contents.ContentsVO" parameterType="int"></xmp>
   * @return 레코드 전체 목록
   */
  public ArrayList<FRContentsVO> list_by_cateno(int cateno);
  
  /**
   * 검색된 레코드 수
   * @param hashMap 검색어
   * @return 검색된 레코드 수
   */
  public int search_count(HashMap hashMap);
 
  
  /**
   * 검색 + 페이징 목록
   * @param map
   * @return
   */
  public ArrayList<FRContentsVO> list_by_cateno_search_paging(HashMap<String, Object> map);
  
  /** 
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param cateno          카테고리번호 
   * @param search_count  검색(전체) 레코드수 
   * @param now_page      현재 페이지
   * @param word 검색어
   * @return 페이징 생성 문자열
   */ 
  public String pagingBox(int cateno, int search_count, int now_page, String fr_word);
  
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
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param cateno          카테고리번호 
   * @param search_count  검색(전체) 레코드수 
   * @param now_page      현재 페이지
   * @param word 검색어
   * @return 페이징 생성 문자열
   */ 
  public String pagingBox2(int search_count, int now_page, String fr_word);
  
  /**
   * 검색된 레코드 수
   * @param hashMap 검색어
   * @return 검색된 레코드 수
   */
  public int search_count_all(HashMap hashMap);
  
}
