package dev.mvc.review;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.fcate.FCateVO;
import dev.mvc.frcontents.FRContentsProcInter;
import dev.mvc.frcontents.FRContentsVO;
import dev.mvc.member.MemberProcInter;
import dev.mvc.member.MemberVO;
import dev.mvc.tool.Tool;
import dev.mvc.tool.Upload;

@Controller
public class ReviewCont {
  @Autowired
  @Qualifier("dev.mvc.frcontents.FRContentsProc") 
  private FRContentsProcInter frcontentsProc;
  
  @Autowired
  @Qualifier("dev.mvc.review.ReviewProc") 
  private ReviewProcInter reviewProc;
  
  @Autowired
  @Qualifier("dev.mvc.member.MemberProc")
  private MemberProcInter memberProc = null;
  
  public ReviewCont() {
    System.out.println("-> ReviewCont created ");
  }
  
  /**
   * 새로고침 방지, POST -> POST 정보 삭제 -> GET -> msg.jsp
   * @return
   */
  @RequestMapping(value="/review/msg.do", method=RequestMethod.GET)
  public ModelAndView msg(String url){
    ModelAndView mav = new ModelAndView();

    mav.setViewName(url); // forward
    
    return mav; // forward
  }
  
  // 등록 폼
  //http://localhost:9093/review/create.do?frno=1
  @RequestMapping(value="/review/create.do", method = RequestMethod.GET)
  public ModelAndView create(int frno) {
//  public ModelAndView create(HttpServletRequest request,  int cateno) {
    ModelAndView mav = new ModelAndView();
    
    FRContentsVO frcontentsVO = this.frcontentsProc.read(frno);
    mav.addObject("frcontentsVO", frcontentsVO);
//    request.setAttribute("fcateVO", fcateVO);
    
    mav.setViewName("/review/create"); 
    return mav;
  }
  
  /**
   * 등록 처리 http://localhost:9093/frcontents/create.do
   * 
   * @return
   */
  @RequestMapping(value = "/review/create.do", method = RequestMethod.POST)
  public ModelAndView create(HttpSession session, HttpServletRequest request, ReviewVO reviewVO, FRContentsVO frcontentsVO) {
    ModelAndView mav = new ModelAndView();
    
    System.out.println("-> create POST execute.");
    
    if (this.memberProc.isMember(session)) {
      int memberno = (int)session.getAttribute("memberno");
      reviewVO.setMemberno(memberno);
      
      // Call By Reference: 메모리 공유, Hashcode 전달
      int cnt = this.reviewProc.create(reviewVO);
      System.out.println("-> cnt: " + cnt);
      
      // ------------------------------------------------------------------------------
      // PK의 return
      // ------------------------------------------------------------------------------
      // System.out.println("--> contentsno: " + contentsVO.getContentsno());
      // mav.addObject("contentsno", contentsVO.getContentsno()); // redirect parameter 적용
      // ------------------------------------------------------------------------------
      
      if (cnt == 1) {
          mav.addObject("code", "create_success");
          // fcateProc.increaseCnt(contentsVO.getCateno()); // 글수 증가
      } else {
          mav.addObject("code", "create_fail");
      }
      mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)
      
      // System.out.println("--> cateno: " + contentsVO.getCateno());
      // redirect시에 hidden tag로 보낸것들이 전달이 안됨으로 request에 다시 저장
//      mav.addObject("frno", reviewVO.getFrno()); // redirect parameter 적용

      // mav.setViewName("/contents/msg"); // POST -> msg.jsp -> top.do 파일이 호출이안됨
      
//      System.out.println("-> 리뷰 등록됨");
      
      // mav.addObject("url", "/review/msg"); // msg.jsp, redirect parameter 적용
      mav.setViewName("redirect:/review/list_by_cateno_search_paging.do?frno="+reviewVO.getFrno()); // GET
  } else {
      mav.addObject("url", "/member/login_need"); // login_need.jsp, redirect parameter 적용
      mav.setViewName("redirect:/review/msg.do"); // GET
   }
    
    
    return mav; // forward
  }
  
  /**
   * 목록 + 페이징 지원 + Cookie
   * http://localhost:9093/review/list_by_cateno_search_paging.do?frno=1&now_page=1
   * 
   * @param cateno
   * @param word
   * @param now_page
   * @return
   */
  @RequestMapping(value = "/review/list_by_cateno_search_paging.do", method = RequestMethod.GET)
  public ModelAndView list_by_cateno_search_paging_cookie(
                                                                  HttpServletRequest request, 
                                                                  @RequestParam(value = "frno", defaultValue = "1") int frno,
                                                                  @RequestParam(value = "now_page", defaultValue = "1") int now_page) {
    // System.out.println("--> now_page: " + now_page);

    ModelAndView mav = new ModelAndView();

    // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("frno", frno); // #{cateno}
    map.put("now_page", now_page); // 페이지에 출력할 레코드의 범위를 산출하기위해 사용
//    System.out.println("now->page"+now_page);
    // 검색 목록
    ArrayList<ReviewVO> list = reviewProc.list_by_cateno_search_paging(map);
    mav.addObject("list", list);
    //  // 검색된 레코드 갯수
    FRContentsVO frcontentsVO = this.frcontentsProc.read(frno);
    mav.addObject("frcontentsVO", frcontentsVO);
    int search_count = reviewProc.search_count(map);
     mav.addObject("search_count", search_count);
  
//       FRContentsVO frcontentsVO = frcontentsProc.read(frno);
//       mav.addObject("frcontentsVO", frcontentsVO);
//       MemberVO memberVO = memberProc.read(memberno);
//       mav.addObject("memberVO", memberVO);
       
      
//
//    /*
//     * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 현재 페이지: 11 / 22 [이전] 11 12 13 14 15 16 17
//     * 18 19 20 [다음]
//     * @param cateno 카테고리번호
//     * @param search_count 검색(전체) 레코드수
//     * @param now_page 현재 페이지
//     * @param word 검색어
//     * @return 페이징용으로 생성된 HTML/CSS tag 문자열
//     */
        String paging = reviewProc.pagingBox(frno, search_count, now_page);
         mav.addObject("paging", paging);

//    
//    // 로그인 Cookie + 쇼핑카트
        mav.setViewName("/review/list_by_cateno_search_paging");  

        return mav;
  }
  
  // 삭제 처리
  // <FORM name='frm' method='POST' action='./read_delete.do'>
  // http://localhost:9091/review/read_delete.do
  @RequestMapping(value="/review/read_delete.do", method = RequestMethod.POST)
  public ModelAndView delete(int reviewno) {
    ModelAndView mav = new ModelAndView();
    
    ReviewVO reviewVO = reviewProc.read(reviewno);
    int cnt = this.reviewProc.delete(reviewVO);
    if (cnt == 0) {
      mav.addObject("code", "delete_fail");
    }
    
    mav.addObject("frno", reviewVO.getFrno());
    mav.addObject("cnt", cnt);
    

    if (cnt > 0) { // 정상 삭제
      mav.setViewName("redirect:/review/list_by_cateno_search_paging.do?frno="+reviewVO.getFrno()); // GET
      
    } else { // 등록 실패
      mav.setViewName("/review/msg");    
    }
    
    return mav;
  }
  
  /**
   * Ajax, JSON 지원 읽기
   * @return
   */
  @ResponseBody
  @RequestMapping(value="/review/read_ajax_json.do", method=RequestMethod.GET)
  public String read_ajax_json(int reviewno) {
    
    try {
      Thread.sleep(2000);
    } catch (InterruptedException e) {
      e.printStackTrace();
    }
    
    ReviewVO reviewVO = this.reviewProc.read(reviewno);
    // cateno, name, cnt, rdate, udate, seqno, visible
    
    JSONObject json = new JSONObject();
    json.put("reviewno", reviewVO.getReviewno());
    json.put("frno", reviewVO.getFrno());
//    json.put("memberno", reviewVO.getMemberno());
//    json.put("rating", reviewVO.getRating());
//    json.put("review_content", reviewVO.getReview_content());
//    json.put("nickname", reviewVO.getNickname());
    
    return json.toString();
  }
 
}
