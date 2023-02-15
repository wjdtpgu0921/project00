package dev.mvc.msurvey;

import java.util.ArrayList;

// Spring framework에서 제공하는 기능
// application.properties를 읽어서 DBMS 연결/해제 자동 구현
// try ~ catch 자동 구현
// surveyVO 값을 SQL에 자동 전달 및 실행
// return 자동 구현
public interface MsurveyDAOInter {
  /**
   * 전체 목록
   * <xmp><select id="list_all" resultType="dev.mvc.msurvey.MsurveyVO"></xmp>
   * @return 전체 목록
   */
  public ArrayList<MsurveyVO> list_all();

  
}


