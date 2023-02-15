package dev.mvc.survey;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

@Component("dev.mvc.survey.SurveyProc")
public class SurveyProc implements SurveyProcInter {
  // SurveyDAOInter interface 만 존재하고 구현 class는 존재하지 않음.
  // interface는 객체를 만들 수 없고 할당만 받을 수 있음.
  
  @Autowired
  private SurveyDAOInter surveyDAO;
  
  public SurveyProc() {
    // System.out.println("-> SurveyProc created.");
    // System.out.println("-> SurveyProc: " + (surveyDAO == null));
  }
  
  @Override
  public int create(SurveyVO surveyVO) {
    int cnt = this.surveyDAO.create(surveyVO); // MyBATIS가 처리한 레코드 갯수가 return됨    
    // System.out.println("-> SurveyProc create: " + (surveyDAO == null));
    return cnt;
  }
  
  @Override
  public ArrayList<SurveyVO> list_all() {
    ArrayList<SurveyVO> list = this.surveyDAO.list_all();
    
    return list;
  }
  
  @Override
  public SurveyVO read(int surveyno) {
    SurveyVO surveyVO = this.surveyDAO.read(surveyno);
    return surveyVO;
  }

  @Override
  public int update(SurveyVO surveyVO) {
    int cnt = this.surveyDAO.update(surveyVO);
    return cnt;
  }
  
  @Override
  public int delete(int surveyno) {
    int cnt = this.surveyDAO.delete(surveyno);
    return cnt;
  }
}

