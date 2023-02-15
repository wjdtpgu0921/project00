package dev.mvc.surveyitem;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public interface SurveyitemProcInter {
  /**
   * 등록
   * @param surveyitemVO
   * @return
   */
  public int create(SurveyitemVO surveyitemVO);
  
  /**
   * 전체 목록
   * <xmp><select id="list_by_surveyno" resultType="dev.mvc.surveyitem.SurveyitemVO" parameterType="int"></xmp>
   * @return 레코드 전체 목록
   */
  public ArrayList<SurveyitemVO> list_by_surveyno(int surveyno);
  
  /**
   * 카운트 증가
   * @param
   * @return
   */
  public int cnt_update(int surveyitemno);
  
  /**
   * 조회
   * <xmp><select id="read" resultType="dev.mvc.surveyitem.SurveyitemVO" parameterType="int"></xmp>
   * @param surveyitemno
   * @return
   */
  public SurveyitemVO read(int surveyitemno);
  
  /**
   * 수정
   * <xmp><update id="update" parameterType="dev.mvc.surveyitem.SurveyitemVO"></xmp>
   * @param surveyitemVO
   * @return 수정된 레코드 갯수
   */
  public int update(SurveyitemVO surveyitemVO);
  
  /**
   * 삭제
   * @param surveyitemno
   * @return 삭제된 레코드 수
   */
  public int delete(int surveyitemno);
  
  /**
   * 설문 번호에 해당하는 카운트의 합
   * @param
   * @return
   */
  public int sum_cnt(int surveyno);
}
