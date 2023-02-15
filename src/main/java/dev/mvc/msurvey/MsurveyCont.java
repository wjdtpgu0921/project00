package dev.mvc.msurvey;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MsurveyCont {
  @Autowired
  @Qualifier("dev.mvc.msurvey.MsurveyProc") 
  private MsurveyProcInter msurveyProc;
  
  public MsurveyCont() {
    System.out.println("-> MsurveyCont created.");
  }
  
  /**
   * 모든 레코드 목록, http://localhost:9093/msurvey/list_all.do
   * @return
   */
  @RequestMapping(value="/msurvey/list_all.do", method=RequestMethod.GET)
  public ModelAndView list_all() {
    ModelAndView mav = new ModelAndView();
    
    ArrayList<MsurveyVO> list = this.msurveyProc.list_all();
    mav.addObject("list", list);
    // request.setAttribute("list", list);
    
    // System.out.println("-> list size: " + list.size());
    
    mav.setViewName("/msurvey/list_all"); // /webapp/WEB-INF/views/msurvey/list_all.jsp
    
    return mav;
  }
  
//  /**
//  * 모든 레코드 목록, http://localhost:9093/msurvey/list_by_surveyno_proc.do?surveyno=1
//  * @return
//  */ 
//  @RequestMapping(value="/msurvey/list_by_surveyno_proc.do", method=RequestMethod.POST)
//  public ModelAndView list_by_surveyno_proc(int surveyno) {
//  ModelAndView mav = new ModelAndView();
// 
//  SurveyVO surveyVO = this.surveyProc.read(surveyno);
//  mav.addObject("surveyVO", surveyVO);
// 
//  ArrayList<msurveyVO> list = this.msurveyProc.list_by_surveyno(surveyno);
//  mav.addObject("list", list);
//  // request.setAttribute("list", list);
// 
//  // System.out.println("-> list size: " + list.size());
// 
//  mav.setViewName("/msurvey/list_by_surveyno_proc"); // /webapp/WEB-INF/views/msurvey/list_by_surveyno_proc.jsp
// 
//  return mav;
// }

  }







