package dev.mvc.fcate;

import java.util.ArrayList;


import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.frcontents.FRContentsProcInter;

//import dev.mvc.contents.ContentsProcInter;

@Controller
public class FCateCont {
  @Autowired
  @Qualifier("dev.mvc.fcate.FCateProc") 
  private FCateProcInter fcateProc; // "dev.mvc.fcate.CateProc" 이름으로 지정된 클래스의 객체가 자동 생성되어 할당
  
  @Autowired
  @Qualifier("dev.mvc.frcontents.FRContentsProc") 
  private FRContentsProcInter frcontentsProc;  // "dev.mvc.contents.ContentsProc" 이름으로 지정된 클래스의 객체가 자동 생성되어 할당
  
  public FCateCont() {
    System.out.println("-> FCateCont created.");
    // System.out.println("-> CateCont: " + (fcateProc == null));
  }
  
  // 등록 폼
  // http://localhost:9091/fcate/create.do
  @RequestMapping(value="/fcate/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    System.out.println("-> create()");
    
    ModelAndView mav = new ModelAndView();
//    JSP View path
//    spring.mvc.view.prefix=/WEB-INF/views/
//    spring.mvc.view.suffix=.jsp
    mav.setViewName("/fcate/create"); // /webapp/WEB-INF/views/fcate/create.jsp
    
    return mav;
  }

  // 등록 처리
  // <FORM name='frm' method='POST' action='./create.do'>
  // http://localhost:9091/fcate/create.do
  @RequestMapping(value="/fcate/create.do", method = RequestMethod.POST)
  public ModelAndView create(FCateVO fcateVO) {
    // System.out.println("-> fcateVO name: " + fcateVO.getName());
    
//    System.out.println("-> create(CateVO fcateVO)");
//    System.out.println("-> CateCont create post: " + (fcateProc == null));
    
    // fcateVO 객체 자동 생성, <FORM> 태그의 값이 자동 저장됨.
    // CateVO fcateVO = new CateVO();
    // fcateVO.setName(request.getParameter("name"));
    
    ModelAndView mav = new ModelAndView();
    
    int cnt = this.fcateProc.create(fcateVO);
    
    if (cnt == 1) {
      mav.addObject("code", "create_success");
      // request.setAttribute("code", "create_success");
    } else {
      mav.addObject("code", "create_fail");
    }
    
    mav.addObject("cnt", cnt);
    // mav.addObject("code", "create_fail"); // 실패 테스트
    // mav.addObject("cnt", 0);  // 실패 테스트
    // request.setAttribute("cnt", cnt);
    
//    JSP View path
//    spring.mvc.view.prefix=/WEB-INF/views/
//    spring.mvc.view.suffix=.jsp
    
    if (cnt > 0) { // 정상 등록
      mav.setViewName("redirect:/fcate/list_all.do"); // 콘트롤러의 주소 요청, 자동 이동
      // mav.setViewName("/fcate/list_all"); // /webapp/WEB-INF/views/fcate/list_all.jsp X
    } else { // 등록 실패
      mav.setViewName("/fcate/msg"); // /webapp/WEB-INF/views/fcate/msg.jsp      
    }
    
    return mav;
  }
  
  /**
   * 모든 레코드 목록, http://localhost:9091/fcate/list_all.do
   * @return
   */
  @RequestMapping(value="/fcate/list_all.do", method=RequestMethod.GET)
  public ModelAndView list_all() {
    ModelAndView mav = new ModelAndView();
    
    ArrayList<FCateVO> list = this.fcateProc.list_all();
    mav.addObject("list", list);
    // request.setAttribute("list", list);
    
    // System.out.println("-> list size: " + list.size());
    
    // mav.setViewName("/fcate/list_all"); // /webapp/WEB-INF/views/fcate/list_all.jsp
    mav.setViewName("/fcate/list_all_ajax"); // /webapp/WEB-INF/views/fcate/list_all_ajax.jsp
    
    return mav;
  }
  
  /**
   * Ajax, JSON 지원 읽기, http://localhost:9091/fcate/read_ajax_json.do?cateno=1
   * {"visible":"Y","seqno":1,"name":"고전","cnt":100,"cateno":1}
   * @return
   */
  @ResponseBody
  @RequestMapping(value="/fcate/read_ajax_json.do", method=RequestMethod.GET)
  public String read_ajax_json(int cateno) {
    
    try {
      Thread.sleep(2000);
    } catch (InterruptedException e) {
      e.printStackTrace();
    }
    
    FCateVO fcateVO = this.fcateProc.read(cateno);
    // cateno, name, cnt, rdate, udate, seqno, visible
    
    JSONObject json = new JSONObject();
    json.put("cateno", fcateVO.getCateno());
    json.put("name", fcateVO.getName());
    json.put("cnt", fcateVO.getCnt());
    json.put("seqno", fcateVO.getSeqno());
    json.put("visible", fcateVO.getVisible());
    
    return json.toString();
  }
  
  /**
   * cateno를 FK로 사용하는 레코드 갯수 읽기, http://localhost:9091/fcate/read_ajax_json_fk.do?cateno=1
   * {"visible":"Y","seqno":1,"name":"고전","cnt":100,"cateno":1}
   * @return
   */
  @ResponseBody
  @RequestMapping(value="/fcate/read_ajax_json_fk.do", method=RequestMethod.GET)
  public String read_ajax_json_fk(int cateno) {
    
    try {
      Thread.sleep(2000);
    } catch (InterruptedException e) {
      e.printStackTrace();
    }
    
    FCateVO fcateVO = this.fcateProc.read(cateno);
    // cateno, name, cnt, rdate, udate, seqno, visible
    
    JSONObject json = new JSONObject();
    json.put("cateno", fcateVO.getCateno());
    json.put("name", fcateVO.getName());
    json.put("cnt", fcateVO.getCnt());
    json.put("seqno", fcateVO.getSeqno());
    json.put("visible", fcateVO.getVisible());
    
    int count_by_cateno = this.frcontentsProc.count_by_cateno(cateno); // cateno가 사용되는 레코드 갯수 파악
    json.put("count_by_cateno", count_by_cateno);
    
    return json.toString();
  }
  
  // 수정 처리
  // <FORM name='frm' method='POST' action='./read_update.do'>
  // http://localhost:9091/fcate/read_update.do
  @RequestMapping(value="/fcate/read_update.do", method = RequestMethod.POST)
  public ModelAndView read_update(FCateVO fcateVO) {
//    System.out.println("-> cateno: " + fcateVO.getCateno());
//    System.out.println("-> name: " + fcateVO.getName());
//    System.out.println("-> cnt: " + fcateVO.getCnt());
    
    ModelAndView mav = new ModelAndView();
    
    int cnt = this.fcateProc.update(fcateVO);
    
    if (cnt == 0) {
      mav.addObject("code", "update_fail");
    }
    
    mav.addObject("cnt", cnt);
    
    if (cnt > 0) { // 정상 등록
      mav.setViewName("redirect:/fcate/list_all.do"); // 콘트롤러의 주소 요청, 자동 이동
      // mav.setViewName("/fcate/list_all"); // /webapp/WEB-INF/views/fcate/list_all.jsp X
    } else { // 등록 실패
      mav.setViewName("/fcate/msg"); // /webapp/WEB-INF/views/fcate/msg.jsp      
    }
    
    return mav;
  }
  
  // 삭제 처리
  // <FORM name='frm' method='POST' action='./read_delete.do'>
  // http://localhost:9091/fcate/read_delete.do
  @RequestMapping(value="/fcate/read_delete.do", method = RequestMethod.POST)
  public ModelAndView delete(int cateno) {
    ModelAndView mav = new ModelAndView();
    
    int cnt = this.fcateProc.delete(cateno);
    
    if (cnt == 0) {
      mav.addObject("code", "delete_fail");
    }
    
    mav.addObject("cnt", cnt);
    
    if (cnt > 0) { // 정상 삭제
      mav.setViewName("redirect:/fcate/list_all.do"); // 콘트롤러의 주소 요청, 자동 이동
      // mav.setViewName("/fcate/list_all"); // /webapp/WEB-INF/views/fcate/list_all.jsp X
    } else { // 등록 실패
      mav.setViewName("/fcate/msg"); // /webapp/WEB-INF/views/fcate/msg.jsp      
    }
    
    return mav;
  }

  // 출력 순서 올림(상향, 10 등 -> 1 등), seqno: 10 -> 1
  // http://localhost:9091/fcate/update_seqno_up.do?cateno=1
  @RequestMapping(value="/fcate/update_seqno_up.do", method = RequestMethod.GET)
  public ModelAndView update_seqno_up(int cateno) {
    ModelAndView mav = new ModelAndView();

    System.out.println("-> update_seqno_up: " + cateno);
    int cnt = this.fcateProc.update_seqno_up(cateno);
    System.out.println("-> cnt: " + cnt);
    
    mav.setViewName("redirect:/fcate/list_all.do"); // 콘트롤러의 주소 요청, 자동 이동
    
    return mav;
  }

  // 출력 순서 내림(상향, 1 등 -> 10 등), seqno: 1 -> 10
  // http://localhost:9091/fcate/update_seqno_down.do?cateno=2
  @RequestMapping(value="/fcate/update_seqno_down.do", method = RequestMethod.GET)
  public ModelAndView update_seqno_down(int cateno) {
    ModelAndView mav = new ModelAndView();

    System.out.println("-> update_seqno_down: " + cateno);
    int cnt = this.fcateProc.update_seqno_down(cateno);
    System.out.println("-> cnt: " + cnt);
    
    mav.setViewName("redirect:/fcate/list_all.do"); // 콘트롤러의 주소 요청, 자동 이동
    
    return mav;
  }

  // 출력 모드 Y로 변경
  // http://localhost:9091/fcate/update_visible_y.do?cateno=1
  @RequestMapping(value="/fcate/update_visible_y.do", method = RequestMethod.GET)
  public ModelAndView update_visible_y(int cateno) {
    ModelAndView mav = new ModelAndView();

//    System.out.println("-> update_visible_y: " + cateno);
    int cnt = this.fcateProc.update_visible_y(cateno);
    
    mav.setViewName("redirect:/fcate/list_all.do"); // 콘트롤러의 주소 요청, 자동 이동
    
    return mav;
  }
  
  // 출력 모드 N로 변경
  // http://localhost:9091/fcate/update_visible_n.do?cateno=1
  @RequestMapping(value="/fcate/update_visible_n.do", method = RequestMethod.GET)
  public ModelAndView update_visible_n(int cateno) {
    ModelAndView mav = new ModelAndView();

    int cnt = this.fcateProc.update_visible_n(cateno);
    
    mav.setViewName("redirect:/fcate/list_all.do"); // 콘트롤러의 주소 요청, 자동 이동
    
    return mav;
  }
  
  // 글수 증가
  // http://localhost:9091/fcate/update_cnt_add.do?cateno=1
  @RequestMapping(value="/fcate/update_cnt_add.do", method = RequestMethod.GET)
  public String update_cnt_add(int cateno) {
    int cnt = this.fcateProc.update_cnt_add(cateno);
    return "변경된 글수: " + cnt;
  }

  // 글수 감소
  // http://localhost:9091/fcate/update_cnt_sub.do?cateno=1
  @RequestMapping(value="/fcate/update_cnt_sub.do", method = RequestMethod.GET)
  public String update_cnt_sub(int cateno) {
    int cnt = this.fcateProc.update_cnt_sub(cateno);
    return "변경된 글수: " + cnt;
  }
  
}





