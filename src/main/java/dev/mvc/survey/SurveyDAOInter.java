package dev.mvc.survey;

import java.util.ArrayList;

// Spring framework에서 제공하는 기능
// application.properties를 읽어서 DBMS 연결/해제 자동 구현
// try ~ catch 자동 구현
// surveyVO 값을 SQL에 자동 전달 및 실행
// return 자동 구현
public interface SurveyDAOInter {
  /**
   * 등록
   * <xmp><insert id="create" parameterType="dev.mvc.survey.SurveyVO"></xmp>
   * @param surveyVO
   * @return 등록한 레코드 개수
   */
  public int create(SurveyVO surveyVO);
  
  /**
   * 전체 목록
   * <xmp><select id="list_all" resultType="dev.mvc.survey.SurveyVO"></xmp>
   * @return 레코드 전체 목록
   */
  public ArrayList<SurveyVO> list_all();
  
  /**
   * 조회
   * <xmp><select id="read" resultType="dev.mvc.survey.SurveyVO" parameterType="int"></xmp>
   * @param surveyno
   * @return
   */
  public SurveyVO read(int surveyno);
  
  /**
   * 수정
   * <xmp><update id="update" parameterType="dev.mvc.survey.SurveyVO"></xmp>
   * @param surveyVO
   * @return 수정된 레코드 갯수
   */
  public int update(SurveyVO surveyVO);
  
  /**
   * 삭제
   * @param surveyno
   * @return 삭제된 레코드 수
   */
  public int delete(int surveyno);
  
}


