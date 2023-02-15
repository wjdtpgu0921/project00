package dev.mvc.msurvey;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

@Component("dev.mvc.msurvey.MsurveyProc")
public class MsurveyProc implements MsurveyProcInter {
  // SurveyDAOInter interface 만 존재하고 구현 class는 존재하지 않음.
  // interface는 객체를 만들 수 없고 할당만 받을 수 있음.
  
  @Autowired
  private MsurveyDAOInter msurveyDAO;
  
  public MsurveyProc() {
    // System.out.println("-> MsurveyProc created.");
    // System.out.println("-> MsurveyProc: " + (surveyDAO == null));
  }
  
  @Override
  public ArrayList<MsurveyVO> list_all() {
    ArrayList<MsurveyVO> list = this.msurveyDAO.list_all();
    
    return list;
  }
  
}

