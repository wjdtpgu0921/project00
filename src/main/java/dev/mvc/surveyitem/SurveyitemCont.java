package dev.mvc.surveyitem;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.survey.SurveyProcInter;
import dev.mvc.survey.SurveyVO;
import dev.mvc.tool.Tool;
import dev.mvc.tool.Upload;

@Controller
public class SurveyitemCont {
  @Autowired
  @Qualifier("dev.mvc.survey.SurveyProc") 
  private SurveyProcInter surveyProc;
  
   /**
   * 새로고침 방지, POST -> POST 정보 삭제 -> GET -> msg.jsp
   * @return
   */
  @RequestMapping(value="/surveyitem/msg.do", method=RequestMethod.GET)
  public ModelAndView msg(String url){
    ModelAndView mav = new ModelAndView();

    mav.setViewName(url); // forward
    
    return mav; // forward
  }
  
  @Autowired
  @Qualifier("dev.mvc.surveyitem.SurveyitemProc") 
  private SurveyitemProcInter surveyitemProc;
  
  public SurveyitemCont () {
    System.out.println("-> SurveyitemCont created.");
  }
  
  // 등록 폼
  // http://localhost:9093/surveyitem/create.do?surveyno=1
  @RequestMapping(value="/surveyitem/create.do", method = RequestMethod.GET)
  public ModelAndView create(int surveyno) {
//  public ModelAndView create(HttpServletRequest request,  int surveyno) {
    ModelAndView mav = new ModelAndView();

    SurveyVO surveyVO = this.surveyProc.read(surveyno);
    mav.addObject("surveyVO", surveyVO);
//    request.setAttribute("surveyVO", surveyVO);
    
    mav.setViewName("/surveyitem/create"); // /webapp/WEB-INF/views/surveyitem/create.jsp
    
    return mav;
  }
  
  /**
   * 등록 처리 http://localhost:9093/surveyitem/create.do
   * 
   * @return
   */
  @RequestMapping(value="/surveyitem/create.do", method = RequestMethod.POST)
  public ModelAndView create(SurveyitemVO surveyitemVO) {
    
    ModelAndView mav = new ModelAndView();
    
    int cnt = this.surveyitemProc.create(surveyitemVO);
    
    if (cnt == 1) {
      mav.addObject("code", "create_success");
      // request.setAttribute("code", "create_success");
    } else {
      mav.addObject("code", "create_fail");
    }
    
    mav.addObject("cnt", cnt);
    mav.addObject("surveyno", surveyitemVO.getSurveyno());
    
    if (cnt > 0) { // 정상 등록
      System.out.println("정상 등록");
      // mav.setViewName("redirect:/survey/list_all.do"); // 콘트롤러의 주소 요청, 자동 이동
      // mav.setViewName("/survey/list_all"); // /webapp/WEB-INF/views/survey/list_all.jsp X      
      mav.addObject("url", "/surveyitem/msg"); // /webapp/WEB-INF/views/surveyitem/msg.jsp  
    } else { // 등록 실패
      System.out.println("등록 실패");
      mav.addObject("url", "/surveyitem/msg"); // /webapp/WEB-INF/views/surveyitem/msg.jsp  
    }
    
    mav.setViewName("redirect:/surveyitem/msg.do"); // GET
    
    return mav;
  }
  
  /**
  * 모든 레코드 목록, http://localhost:9093/surveyitem/list_by_surveyno.do?surveyno=1
  * @return
  */ 
  @RequestMapping(value="/surveyitem/list_by_surveyno.do", method=RequestMethod.GET)
  public ModelAndView list_by_surveyno(int surveyno) {
  ModelAndView mav = new ModelAndView();
 
  SurveyVO surveyVO = this.surveyProc.read(surveyno);
  mav.addObject("surveyVO", surveyVO);
 
  ArrayList<SurveyitemVO> list = this.surveyitemProc.list_by_surveyno(surveyno);
  mav.addObject("list", list);
  // request.setAttribute("list", list);
 
  // System.out.println("-> list size: " + list.size());
  
  System.out.println("-> surveyno: " + surveyno);
  int sum = this.surveyitemProc.sum_cnt(surveyno);
  System.out.println("-> sum: " + sum);
  mav.addObject("sum", sum);
 
  mav.setViewName("/surveyitem/list_by_surveyno"); // /webapp/WEB-INF/views/surveyitem/list_by_surveyno.jsp
 
  return mav;
 }
  
  /**
  * 모든 레코드 목록, http://localhost:9093/surveyitem/list_by_surveyno_proc.do?surveyno=1
  * @return
  */ 
  @RequestMapping(value="/surveyitem/list_by_surveyno_proc.do", method=RequestMethod.POST)
  public ModelAndView list_by_surveyno_proc(int surveyno, int surveyitemno, HttpSession session) {
  ModelAndView mav = new ModelAndView();
 
  SurveyVO surveyVO = this.surveyProc.read(surveyno);
  mav.addObject("surveyVO", surveyVO);
 
  ArrayList<SurveyitemVO> list = this.surveyitemProc.list_by_surveyno(surveyno);
  mav.addObject("list", list);
  // request.setAttribute("list", list);
 
  // System.out.println("-> list size: " + list.size());
 
  mav.setViewName("/surveyitem/list_by_surveyno_proc"); // /webapp/WEB-INF/views/surveyitem/list_by_surveyno_proc.jsp
 
  return mav;
 }
  
  /**
   * 수정폼, http://localhost:9093/surveyitem/read_update.do?surveyitemno=1
   * @return
   */
  @RequestMapping(value="/surveyitem/read_update.do", method=RequestMethod.GET)
  public ModelAndView read_update(int surveyitemno) {
    // System.out.println("-> surveyitemno: " + surveyitemno);
    
    ModelAndView mav = new ModelAndView();
    
    ArrayList<SurveyitemVO> list = this.surveyitemProc.list_by_surveyno(surveyitemno);
    mav.addObject("list", list);
    
    SurveyitemVO surveyitemVO = this.surveyitemProc.read(surveyitemno);
    mav.addObject("surveyitemVO", surveyitemVO);
    
    mav.setViewName("/surveyitem/read_update"); // /webapp/WEB-INF/views/surveyitem/read_update.jsp
    
    return mav;
  }
  
 //수정 처리
 // <FORM name='frm' method='POST' action='./read_update.do'>
 // http://localhost:9093/surveyitem/read_update.do
 @RequestMapping(value="/surveyitem/read_update.do", method = RequestMethod.POST)
 public ModelAndView read_update(SurveyitemVO surveyitemVO) {
   
   ModelAndView mav = new ModelAndView();
   
   int cnt = this.surveyitemProc.update(surveyitemVO);
   
   if (cnt == 0) {
     mav.addObject("code", "update_fail");
   }
   
   mav.addObject("cnt", cnt);
   
   if (cnt > 0) { // 정상 등록
     // System.out.println("정상 수정");
     mav.setViewName("redirect:/surveyitem/list_by_surveyno.do"); // 콘트롤러의 주소 요청, 자동 이동
//     // mav.setViewName("/survey/list_all"); // /webapp/WEB-INF/views/surveyitem/list_by_surveyno.jsp X
   } else { // 등록 실패
     // System.out.println("수정 실패");
     mav.setViewName("/surveyitem/msg"); // /webapp/WEB-INF/views/surveyitem/msg.jsp      
   }
   
   return mav;
 }
 
 /**
  * 삭제폼, http://localhost:9093/surveyitem/read_delete.do?surveyitemno=1
  * @return
  */
 @RequestMapping(value="/surveyitem/read_delete.do", method=RequestMethod.GET)
 public ModelAndView read_delete(int surveyitemno) {
   // System.out.println("-> surveyitemno: " + surveyitemno);
   
   ModelAndView mav = new ModelAndView();
   
   ArrayList<SurveyitemVO> list = this.surveyitemProc.list_by_surveyno(surveyitemno);
   mav.addObject("list", list);
   
   SurveyitemVO surveyitemVO = this.surveyitemProc.read(surveyitemno);
   mav.addObject("surveyitemVO", surveyitemVO);
   
   mav.setViewName("/surveyitem/read_delete"); // /webapp/WEB-INF/views/survey/read_delete.jsp
   
   return mav;
 }
 
 // 삭제 처리
 // <FORM name='frm' method='POST' action='./read_delete.do'>
 // http://localhost:9093/surveyitem/read_delete.do
 @RequestMapping(value="/surveyitem/read_delete.do", method = RequestMethod.POST)
 public ModelAndView delete(int surveyitemno) {
   ModelAndView mav = new ModelAndView();
   
   int cnt = this.surveyitemProc.delete(surveyitemno);
   
   if (cnt == 0) {
     mav.addObject("code", "delete_fail");
   }
   
   mav.addObject("cnt", cnt);
   
   if (cnt > 0) { // 정상 삭제
     mav.setViewName("redirect:/surveyitem/list_by_surveyno.do"); // 콘트롤러의 주소 요청, 자동 이동
     // mav.setViewName("/surveyitem/list_by_surveyno"); // /webapp/WEB-INF/views/surveyitem/list_by_surveyno.jsp X
   } else { // 등록 실패
     mav.setViewName("/surveyitem/msg"); // /webapp/WEB-INF/views/surveyitem/msg.jsp      
   }
   
   return mav;
 }

 // 카운트 증가
 // http://localhost:9093/surveyitem/cnt_update.do
 @RequestMapping(value="/surveyitem/cnt_update.do", method = RequestMethod.POST)
 public ModelAndView cnt_update(int surveyitemno) {
   ModelAndView mav = new ModelAndView();
   
   this.surveyitemProc.cnt_update(surveyitemno);
   
   mav.setViewName("redirect:/survey/list_all.do"); 
   
   return mav;
 }

 
}
