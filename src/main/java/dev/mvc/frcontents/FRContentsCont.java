package dev.mvc.frcontents;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;


import java.util.HashMap;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.favorites.FavoritesProcInter;
import dev.mvc.favorites.FavoritesVO;
import dev.mvc.fcate.FCateProcInter;
import dev.mvc.fcate.FCateVO;
import dev.mvc.member.MemberProcInter;
import dev.mvc.tool.Tool;
import dev.mvc.tool.Upload;

@Controller
public class FRContentsCont {
  @Autowired
  @Qualifier("dev.mvc.fcate.FCateProc") 
  private FCateProcInter fcateProc;
  
  @Autowired
  @Qualifier("dev.mvc.frcontents.FRContentsProc") 
  private FRContentsProcInter frcontentsProc;
  
  @Autowired
  @Qualifier("dev.mvc.member.MemberProc")
  private MemberProcInter memberProc = null;
  
  @Autowired
  @Qualifier("dev.mvc.favorites.FavoritesProc") 
  private FavoritesProcInter favoritesProc;
  
  public FRContentsCont () {
    System.out.println("-> FRContentsCont created.");
}

  /**
   * 새로고침 방지, POST -> POST 정보 삭제 -> GET -> msg.jsp
   * @return
   */
  @RequestMapping(value="/frcontents/msg.do", method=RequestMethod.GET)
  public ModelAndView msg(String url){
    ModelAndView mav = new ModelAndView();

    mav.setViewName(url); // forward
    
    return mav; // forward
  }
  
  // 등록 폼
  // http://localhost:9093/frcontents/create.do?cateno=1
  @RequestMapping(value="/frcontents/create.do", method = RequestMethod.GET)
  public ModelAndView create(int cateno) {
//  public ModelAndView create(HttpServletRequest request,  int cateno) {
    ModelAndView mav = new ModelAndView();

    FCateVO fcateVO = this.fcateProc.read(cateno);
    mav.addObject("fcateVO", fcateVO);
//    request.setAttribute("fcateVO", fcateVO);
    
    // 커뮤니티(공지사항, 게시판, 자료실, 갤러리,  Q/A...)글 등록 
    // mav.setViewName("/contents/create"); // /webapp/WEB-INF/views/contents/create.jsp
    
    // 쇼핑몰의 상품 정보 등록
    mav.setViewName("/frcontents/create_product"); // /webapp/WEB-INF/views/contents/create_product.jsp
    
    return mav;
  }
  
  /**
   * 등록 처리 http://localhost:9093/frcontents/create.do
   * 
   * @return
   */
  @RequestMapping(value = "/frcontents/create.do", method = RequestMethod.POST)
  public ModelAndView create(HttpSession session, HttpServletRequest request, FRContentsVO frcontentsVO) {
    ModelAndView mav = new ModelAndView();
    
    if (this.memberProc.isMember(session)) {
      int memberno = (int)session.getAttribute("memberno");
      frcontentsVO.setMemberno(memberno);
      
      // ------------------------------------------------------------------------------
      // 파일 전송 코드 시작
      // ------------------------------------------------------------------------------
      String file1 = "";          // 원본 파일명 image
      String file1saved = "";   // 저장된 파일명, image
      String thumb1 = "";     // preview image

      // 기준 경로 확인
      String user_dir = System.getProperty("user.dir"); // 시스템 제공
      // System.out.println("-> User dir: " + user_dir);
      //  --> User dir: C:\kd\ws_java\resort_v1sbm3c
      
      // 파일 접근임으로 절대 경로 지정, static 폴더 지정
      // 완성된 경로 C:/kd/ws_java/resort_v1sbm3c/src/main/resources/static/contents/storage
      String upDir =  user_dir + "/src/main/resources/static/frcontents/storage/"; // 절대 경로
      // System.out.println("-> upDir: " + upDir);
      
      // 전송 파일이 없어도 file1MF 객체가 생성됨.
      // <input type='file' class="form-control" name='file1MF' id='file1MF' 
      //           value='' placeholder="파일 선택">
      MultipartFile mf = frcontentsVO.getFile1MF();
      
      file1 = Tool.getFname(mf.getOriginalFilename()); // 원본 순수 파일명 산출
      System.out.println("-> file1: " + file1);
      
      long size1 = mf.getSize();  // 파일 크기
      
      if (size1 > 0) { // 파일 크기 체크
        // 파일 저장 후 업로드된 파일명이 리턴됨, spring.jsp, spring_1.jpg...
        file1saved = Upload.saveFileSpring(mf, upDir); 
        
        if (Tool.isImage(file1saved)) { // 이미지인지 검사
          // thumb 이미지 생성후 파일명 리턴됨, width: 200, height: 150
          thumb1 = Tool.preview(upDir, file1saved, 200, 150); 
        }
        
      }    
      
      frcontentsVO.setFile1(file1);   // 순수 원본 파일명
      frcontentsVO.setFile1saved(file1saved); // 저장된 파일명(파일명 중복 처리)
      frcontentsVO.setThumb1(thumb1);      // 원본이미지 축소판
      frcontentsVO.setSize1(size1);  // 파일 크기
      // ------------------------------------------------------------------------------
      // 파일 전송 코드 종료
      // ------------------------------------------------------------------------------
      
      // Call By Reference: 메모리 공유, Hashcode 전달
      int cnt = this.frcontentsProc.create(frcontentsVO); 
      
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
      mav.addObject("cateno", frcontentsVO.getCateno()); // redirect parameter 적용

      // mav.setViewName("/contents/msg"); // POST -> msg.jsp -> top.do 파일이 호출이안됨
      
      mav.addObject("url", "/frcontents/msg"); // msg.jsp, redirect parameter 적용
      mav.setViewName("redirect:/frcontents/msg.do"); // GET
  } else {
      mav.addObject("url", "/member/login_need"); // login_need.jsp, redirect parameter 적용
     mav.setViewName("redirect:/frcontents/msg.do"); // GET
   }
    

    return mav; // forward
  }
  
  /**
   * 목록 + 검색 + 페이징 지원 + Cookie
   * http://localhost:9093/frcontents/list_by_cateno_search_paging.do?cateno=1&word=스위스&now_page=1
   * 
   * @param cateno
   * @param word
   * @param now_page
   * @return
   */
  @RequestMapping(value = "/frcontents/list_by_cateno_search_paging.do", method = RequestMethod.GET)
  public ModelAndView list_by_cateno_search_paging_cookie(
                                                                  HttpServletRequest request,
                                                                  @RequestParam(value = "cateno", defaultValue = "1") int cateno,
                                                                  @RequestParam(value = "fr_word", defaultValue = "") String fr_word,
                                                                  @RequestParam(value = "now_page", defaultValue = "1") int now_page) {
    // System.out.println("--> now_page: " + now_page);

    ModelAndView mav = new ModelAndView();

    // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("cateno", cateno); // #{cateno}
    map.put("fr_word", fr_word); // #{word}
    map.put("now_page", now_page); // 페이지에 출력할 레코드의 범위를 산출하기위해 사용

    // 검색 목록
    ArrayList<FRContentsVO> list = frcontentsProc.list_by_cateno_search_paging(map);
    mav.addObject("list", list);

//    // 검색된 레코드 갯수
      int search_count = frcontentsProc.search_count(map);
       mav.addObject("search_count", search_count);
    
       FCateVO fcateVO = fcateProc.read(cateno);
       mav.addObject("fcateVO", fcateVO);
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
        String paging = frcontentsProc.pagingBox(cateno, search_count, now_page, fr_word);
//        System.out.println("paging1->"+paging);
         mav.addObject("paging", paging);
//
//    // mav.addObject("now_page", now_page);
//    
//    // 로그인 Cookie 지원
//    mav.setViewName("/contents/list_by_cateno_search_paging_cookie");  // /contents/list_by_cateno_search_paging_cookie.jsp ★
//    
//    // 로그인 Cookie + 쇼핑카트
        mav.setViewName("/frcontents/list_by_cateno_search_paging");  // /contents/list_by_cateno_search_paging.jsp ★ 

        return mav;
  }
  
  /**
   * 조회, http://localhost:9093/contents/read.do?cateno=12&contentsno=1
   * @return
   */
  @RequestMapping(value="/frcontents/read.do", method=RequestMethod.GET)
  public ModelAndView read(int cateno, int frno) {
    
    ModelAndView mav = new ModelAndView();
    
    FCateVO fcateVO = this.fcateProc.read(cateno);
    mav.addObject("fcateVO", fcateVO);
    
    FRContentsVO frcontentsVO = this.frcontentsProc.read(frno);
    
    long size1 = frcontentsVO.getSize1();
    frcontentsVO.setSize1_label(Tool.unit(size1)); 
    
    mav.addObject("frcontentsVO", frcontentsVO);
    
    mav.setViewName("/frcontents/read"); // /webapp/WEB-INF/views/contents/read.jsp
    
    return mav;
  }
  
  /**
   * 수정 폼
   * http://localhost:9093/frcontents/update_text.do?frno=1
   * 
   * @return
   */
  @RequestMapping(value = "/frcontents/update_text.do", method = RequestMethod.GET)
  public ModelAndView update_text(int frno) {
    ModelAndView mav = new ModelAndView();
    
    FRContentsVO frcontentsVO = this.frcontentsProc.read(frno);
    mav.addObject("frcontentsVO", frcontentsVO);
    
    FCateVO fcateVO = this.fcateProc.read(frcontentsVO.getCateno());
    mav.addObject("fcateVO", fcateVO);
    
    mav.setViewName("/frcontents/update_text"); // /WEB-INF/views/contents/update_text.jsp
    // String content = "장소:\n인원:\n준비물:\n비용:\n기타:\n";
    // mav.addObject("content", content);

    return mav; // forward
  }
  
  /**
   * 수정 처리
   * http://localhost:9093/frcontents/update_text.do?contentsno=1
   * 
   * @return
   */
  @RequestMapping(value = "/frcontents/update_text.do", method = RequestMethod.POST)
  public ModelAndView update_text(HttpSession session, HttpServletRequest request,FRContentsVO frcontentsVO) {
    ModelAndView mav = new ModelAndView();
    
    int memberno = (int)session.getAttribute("memberno");
    int memberno2 = frcontentsVO.getMemberno();
        
    int cnt = this.frcontentsProc.update_text(frcontentsVO);
    
    // URL에 파라미터의 전송
    // mav.setViewName("redirect:/contents/read.do?contentsno=" + contentsVO.getContentsno() + "&cateno=" + contentsVO.getCateno());             

    // mav 객체 이용
    mav.addObject("frno", frcontentsVO.getFrno());
    mav.addObject("cateno", frcontentsVO.getCateno());
    mav.setViewName("redirect:/frcontents/read.do");

    
    return mav;// forward
    
  }
  
  /**
   * 파일 수정 폼
   * http://localhost:9093/frcontents/update_file.do?frno=1
   * 
   * @return
   */
  @RequestMapping(value = "/frcontents/update_file.do", method = RequestMethod.GET)
  public ModelAndView update_file(int frno) {
    ModelAndView mav = new ModelAndView();
    
    FRContentsVO frcontentsVO = this.frcontentsProc.read(frno);
    mav.addObject("frcontentsVO", frcontentsVO);
    
    FCateVO fcateVO = this.fcateProc.read(frcontentsVO.getCateno());
    mav.addObject("fcateVO", fcateVO);
    
    mav.setViewName("/frcontents/update_file"); // /WEB-INF/views/contents/update_file.jsp

    return mav; // forward
  }
  
  /**
   * 파일 수정 처리 http://localhost:9093/frcontents/update_file.do
   * 
   * @return
   */
  @RequestMapping(value = "/frcontents/update_file.do", method = RequestMethod.POST)
  public ModelAndView update_file(FRContentsVO frcontentsVO) {
    ModelAndView mav = new ModelAndView();
    
    // 삭제할 파일 정보를 읽어옴, 기존에 등록된 레코드 저장용
    FRContentsVO frcontentsVO_old = frcontentsProc.read(frcontentsVO.getFrno());
    
    int cnt = 0;

    // -------------------------------------------------------------------
    // 파일 삭제 코드 시작
    // -------------------------------------------------------------------
    String file1saved = frcontentsVO_old.getFile1saved();  // 실제 저장된 파일명
    String thumb1 = frcontentsVO_old.getThumb1();       // 실제 저장된 preview 이미지 파일명
    long size1 = 0;
    boolean sw = false;
        
    // 완성된 경로 C:/kd/ws_java/resort_v1sbm3c/src/main/resources/static/contents/storage/
    String upDir =  System.getProperty("user.dir") + "/src/main/resources/static/frcontents/storage/"; // 절대 경로

    sw = Tool.deleteFile(upDir, file1saved);  // 실제 저장된 파일삭제
    sw = Tool.deleteFile(upDir, thumb1);     // preview 이미지 삭제
    // -------------------------------------------------------------------
    // 파일 삭제 종료 시작
    // -------------------------------------------------------------------
        
    // -------------------------------------------------------------------
    // 파일 전송 코드 시작
    // -------------------------------------------------------------------
    String file1 = "";          // 원본 파일명 image

    // 완성된 경로 C:/kd/ws_java/resort_v1sbm3c/src/main/resources/static/contents/storage/
    // String upDir =  System.getProperty("user.dir") + "/src/main/resources/static/contents/storage/"; // 절대 경로
        
    // 전송 파일이 없어도 file1MF 객체가 생성됨.
    // <input type='file' class="form-control" name='file1MF' id='file1MF' 
    //           value='' placeholder="파일 선택">
    MultipartFile mf = frcontentsVO.getFile1MF();
        
    file1 = mf.getOriginalFilename(); // 원본 파일명
    size1 = mf.getSize();  // 파일 크기
        
    if (size1 > 0) { // 파일 크기 체크
      // 파일 저장 후 업로드된 파일명이 리턴됨, spring.jsp, spring_1.jpg...
      file1saved = Upload.saveFileSpring(mf, upDir); 
      
      if (Tool.isImage(file1saved)) { // 이미지인지 검사
        // thumb 이미지 생성후 파일명 리턴됨, width: 250, height: 200
        thumb1 = Tool.preview(upDir, file1saved, 250, 200); 
      }
      
    } else { // 파일이 삭제만 되고 새로 올리지 않는 경우
      file1="";
      file1saved="";
      thumb1="";
      size1=0;
    }
        
    frcontentsVO.setFile1(file1);
    frcontentsVO.setFile1saved(file1saved);
    frcontentsVO.setThumb1(thumb1);
    frcontentsVO.setSize1(size1);
    // -------------------------------------------------------------------
    // 파일 전송 코드 종료
    // -------------------------------------------------------------------
        
    cnt = this.frcontentsProc.update_file(frcontentsVO); // Oracle 처리

    mav.addObject("frno", frcontentsVO.getFrno());
    mav.addObject("cateno", frcontentsVO.getCateno());
    mav.setViewName("redirect:/frcontents/read.do"); // request -> param으로 접근 전환
        
    return mav; // forward
  }

  /**
   * 삭제 폼
   * @param frno
   * @return
   */
  @RequestMapping(value="/frcontents/delete.do", method=RequestMethod.GET )
  public ModelAndView delete(int frno) { 
    ModelAndView mav = new  ModelAndView();
    
    // 삭제할 정보를 조회하여 확인
    FRContentsVO frcontentsVO = this.frcontentsProc.read(frno);
    mav.addObject("frcontentsVO", frcontentsVO);
    
    FCateVO fcateVO = this.fcateProc.read(frcontentsVO.getCateno());
    mav.addObject("fcateVO", fcateVO);
    
    mav.setViewName("/frcontents/delete");  // /webapp/WEB-INF/views/contents/delete.jsp
    
    return mav; 
  }
  
  /**
   * 삭제 처리 http://localhost:9093/frcontents/delete.do
   * 
   * @return
   */
  @RequestMapping(value = "/frcontents/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(int frno, String fr_word,
                                        @RequestParam(value="now_page", defaultValue="1") int now_page) {
    ModelAndView mav = new ModelAndView();
    
    int cnt = 0;
    // -------------------------------------------------------------------
    // 파일 삭제 코드 시작
    // -------------------------------------------------------------------
    // 삭제할 파일 정보를 읽어옴.
    FRContentsVO frcontentsVO = frcontentsProc.read(frno);
        
    String file1saved = frcontentsVO.getFile1saved();
    String thumb1 = frcontentsVO.getThumb1();
    long size1 = 0;
    boolean sw = false;
        
    // 완성된 경로 C:/kd/ws_java/resort_v1sbm3c/src/main/resources/static/contents/storage/
    String upDir =  System.getProperty("user.dir") + "/src/main/resources/static/frcontents/storage/"; // 절대 경로

    sw = Tool.deleteFile(upDir, file1saved);  // 실제 저장된 파일삭제
    sw = Tool.deleteFile(upDir, thumb1);     // preview 이미지 삭제
    // -------------------------------------------------------------------
    // 파일 삭제 종료 시작
    // -------------------------------------------------------------------
        
    cnt = this.frcontentsProc.delete(frno); // DBMS 삭제
        
    // -------------------------------------------------------------------------------------
    // 마지막 페이지의 마지막 레코드 삭제시의 페이지 번호 -1 처리
    // -------------------------------------------------------------------------------------    
    HashMap<String, Object> page_map = new HashMap<String, Object>();
    page_map.put("cateno", frcontentsVO.getCateno());
    page_map.put("fr_word", fr_word);
    // 마지막 페이지의 마지막 10번째 레코드를 삭제후
    // 하나의 페이지가 3개의 레코드로 구성되는 경우 현재 9개의 레코드가 남아 있으면
    // 페이지수를 4 -> 3으로 감소 시켜야함, 마지막 페이지의 마지막 레코드 삭제시 나머지는 0 발생
    if (frcontentsProc.search_count(page_map) % FRContents.RECORD_PER_PAGE == 0) {
      now_page = now_page - 1;
      if (now_page < 1) {
        now_page = 1; // 시작 페이지
      }
    }
    // -------------------------------------------------------------------------------------

    mav.addObject("cateno", frcontentsVO.getCateno());
    mav.addObject("now_page", now_page);
    mav.setViewName("redirect:/frcontents/list_by_cateno_search_paging.do"); 
    
    return mav;
  }   
  
  // MAP 등록/수정/삭제 폼
  // http://localhost:9093/frcontents/map.do?cateno=15&contentsno=6
  @RequestMapping(value="/frcontents/map.do", method = RequestMethod.GET)
  public ModelAndView map(int cateno, int frno) {
    ModelAndView mav = new ModelAndView();

    FCateVO fcateVO = this.fcateProc.read(cateno);
    mav.addObject("fcateVO", fcateVO);
    
    FRContentsVO frcontentsVO = this.frcontentsProc.read(frno);
    mav.addObject("frcontentsVO", frcontentsVO);
    
    mav.setViewName("/frcontents/map"); // /webapp/WEB-INF/views/contents/map.jsp
    
    return mav;
  }
  
  // MAP 등록/수정/삭제 처리
  @RequestMapping(value="/frcontents/map.do", method = RequestMethod.POST)
  public ModelAndView map_update(int cateno, int frno, String fr_map) {
    // System.out.println("-> contentsno: " + contentsno);
    
    ModelAndView mav = new ModelAndView();

    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("frno", frno);
    hashMap.put("fr_map", fr_map);
    
    this.frcontentsProc.map(hashMap);
    
    mav.setViewName("redirect:/frcontents/read.do?cateno=" + cateno + "&frno=" + frno); 
    // /webapp/WEB-INF/views/frcontents/read.jsp
    
    return mav;
  }
  
  // GET 요청
  public String mf_recommend(String django_url) throws MalformedURLException, IOException {
      URL url = new URL(django_url);
      HttpURLConnection httpConn = (HttpURLConnection) url.openConnection();
      
      int statusCode = httpConn.getResponseCode();        
      System.out.println((statusCode == 200) ? "success" : "fail");
      System.out.println("Response code: " + statusCode);
      
      BufferedReader br = new BufferedReader(new InputStreamReader(httpConn.getInputStream()));
      String line=br.readLine();
      br.close();
      
      return line;
  }
  
  /**
   * 추천 목록, http://localhost:9093/frcontents/mf_food_member.do
   * @return
   */
  @RequestMapping(value="/frcontents/mf_food_member.do", method=RequestMethod.GET)
  public ModelAndView mf_food_member(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    
    // Spring boot -> Django로 요청을 보냄 -> JSON 문자열 수신
    int memberno = (int)session.getAttribute("memberno");
//    memberno=1;
    // int userId = 1; // test
//    int userId = memberno;
    
    String source = "";
    try {
      source = mf_recommend("http://127.0.0.1:8000/recommend_food/mf_food?memberno=" + memberno);
    } catch (MalformedURLException e) {
      e.printStackTrace();
    } catch (IOException e) {
      e.printStackTrace();
    }        

    System.out.println("-> source: " + source);
    // -> source: [{"movie_id": 246, "movie_title": "Hoop Dreams (1994)", "movie_rating": 5}, 
    // {"movie_id": 318, "movie_title": "Shawshank Redemption, The (1994)", "movie_rating": 5}, 
    // {"movie_id": 720, "movie_title": "Wallace & Gromit: The Best of Aardman Animation (1996)", "movie_rating": 5}, {"movie_id": 741, "movie_title": "Ghost in the Shell (Kôkaku kidôtai) (1995)", "movie_rating": 5}, {"movie_id": 750, "movie_title": "Dr. Strangelove or: How I Learned to Stop Worrying and Love the Bomb (1964)", "movie_rating": 5}]
    
    // 영화 번호를 추출
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    
    JSONArray json = new JSONArray(source);
    ArrayList<String> frno_list = new ArrayList<String>();
    
    for (int index=0; index < json.length(); index++) {
      JSONObject obj = (JSONObject)json.opt(index);
      String frno = obj.optString("frno");
      System.out.println("-> frno: " + frno);
      frno_list.add(frno);
    }
    
    hashMap.put("frno_list", frno_list);
        
    // 추천 상품 목록 읽기
    ArrayList<FRContentsVO> list = this.frcontentsProc.mf_food_member(hashMap);
    mav.addObject("list", list);
    
    // 유형 1: 테이블
    // /webapp/WEB-INF/views/contents/mf_movie_member.jsp
    // mav.setViewName("/contents/mf_movie_member"); 

    // 유형 2: 그리드
    // /webapp/WEB-INF/views/contents/mf_movie_member_grid.jsp
    mav.setViewName("/frcontents/mf_food_member_grid"); 
    
    return mav;
  }
  
  /**
   * 추천 목록, http://localhost:9093/frcontents/mf_food_member.do
   * @return
   */
  @RequestMapping(value="/frcontents/mf_food_member_grid_index.do", method=RequestMethod.GET)
  public ModelAndView mf_food_member_main(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    
    // Spring boot -> Django로 요청을 보냄 -> JSON 문자열 수신
    int memberno = (int)session.getAttribute("memberno");
//    memberno=1;
    // int userId = 1; // test
//    int userId = memberno;
    
    String source = "";
    try {
      source = mf_recommend("http://127.0.0.1:8000/recommend_food/mf_food?memberno=" + memberno);
    } catch (MalformedURLException e) {
      e.printStackTrace();
    } catch (IOException e) {
      e.printStackTrace();
    }        

    System.out.println("-> source: " + source);
    // -> source: [{"movie_id": 246, "movie_title": "Hoop Dreams (1994)", "movie_rating": 5}, 
    // {"movie_id": 318, "movie_title": "Shawshank Redemption, The (1994)", "movie_rating": 5}, 
    // {"movie_id": 720, "movie_title": "Wallace & Gromit: The Best of Aardman Animation (1996)", "movie_rating": 5}, {"movie_id": 741, "movie_title": "Ghost in the Shell (Kôkaku kidôtai) (1995)", "movie_rating": 5}, {"movie_id": 750, "movie_title": "Dr. Strangelove or: How I Learned to Stop Worrying and Love the Bomb (1964)", "movie_rating": 5}]
    
    // 영화 번호를 추출
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    
    JSONArray json = new JSONArray(source);
    ArrayList<String> frno_list = new ArrayList<String>();
    
    for (int index=0; index < json.length(); index++) {
      JSONObject obj = (JSONObject)json.opt(index);
      String frno = obj.optString("frno");
      System.out.println("-> frno: " + frno);
      frno_list.add(frno);
    }
    
    hashMap.put("frno_list", frno_list);
        
    // 추천 상품 목록 읽기
    ArrayList<FRContentsVO> list = this.frcontentsProc.mf_food_member(hashMap);
    mav.addObject("list", list);
    
    // 유형 1: 테이블
    // /webapp/WEB-INF/views/contents/mf_movie_member.jsp
    // mav.setViewName("/contents/mf_movie_member"); 

    // 유형 2: 그리드
    // /webapp/WEB-INF/views/contents/mf_movie_member_grid.jsp
    mav.setViewName("/frcontents/mf_food_member_grid_index"); 
    
    return mav;
  }
  
  
  
  /**
   * 등록 처리 http://localhost:9093/frcontents/create.do
   * 
   * @return
   */
  @RequestMapping(value = "/frcontents/favorites_create.do", method = RequestMethod.GET)
  public ModelAndView favorites_create(HttpSession session, HttpServletRequest request, FRContentsVO frcontentsVO, 
		  @RequestParam(value = "cateno", defaultValue = "2") int cateno,
          @RequestParam(value = "fr_word", defaultValue = "") String fr_word,
          @RequestParam(value = "now_page", defaultValue = "1") int now_page) {
    ModelAndView mav = new ModelAndView();
 
 // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("cateno", cateno); // #{cateno}
    map.put("fr_word", fr_word); // #{word}
    map.put("now_page", now_page); // 페이지에 출력할 레코드의 범위를 산출하기위해 사용

    // 검색 목록
    ArrayList<FRContentsVO> list = frcontentsProc.list_by_cateno_search_paging(map);
    mav.addObject("list", list);

//    // 검색된 레코드 갯수
      int search_count = frcontentsProc.search_count(map);
       mav.addObject("search_count", search_count);
    
       FCateVO fcateVO = fcateProc.read(cateno);
       mav.addObject("fcateVO", fcateVO);
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
        String paging = frcontentsProc.pagingBox(cateno, search_count, now_page, fr_word);
         mav.addObject("paging", paging);

         if (this.memberProc.isMember(session)) {
             int memberno = (int)session.getAttribute("memberno");
             int frno = frcontentsVO.getFrno();
            
             FavoritesVO favoritesVO = new FavoritesVO();
             
             favoritesVO.setFrno(frno);
             favoritesVO.setMemberno(memberno);

             int cnt = this.favoritesProc.create(favoritesVO); 
                
          }
         System.out.println("->->->->->->->->->-> "  + cateno);
        mav.setViewName("/frcontents/list_by_cateno_search_paging");  // /contents/list_by_cateno_search_paging.jsp ★ 

    return mav; // forward
  }
  
  /**
   * 목록 + 검색 + 페이징 지원 + Cookie
   * http://localhost:9093/frcontents/list_by_cateno_search_paging.do?cateno=1&word=스위스&now_page=1
   * 
   * @param cateno
   * @param word
   * @param now_page
   * @return
   */
  @RequestMapping(value = "/frcontents/list_by_cateno_search_paging_all.do", method = RequestMethod.GET)
  public ModelAndView list_by_cateno_search_paging_all(
                                                                  HttpServletRequest request,
                                                                  @RequestParam(value = "fr_word", defaultValue = "") String fr_word,
                                                                  @RequestParam(value = "now_page", defaultValue = "1") int now_page) {
    // System.out.println("--> now_page: " + now_page);

    ModelAndView mav = new ModelAndView();

    // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("fr_word", fr_word); // #{word}
    map.put("now_page", now_page); // 페이지에 출력할 레코드의 범위를 산출하기위해 사용

    // 검색 목록
    ArrayList<FRContentsVO> list = frcontentsProc.list_by_cateno_search_paging_all(map);
    mav.addObject("list", list);

//    // 검색된 레코드 갯수
      int search_count_all = frcontentsProc.search_count_all(map);
       mav.addObject("search_count_all", search_count_all);
    
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
        String paging2 = frcontentsProc.pagingBox2(search_count_all, now_page, fr_word);
//        System.out.println("paging2->" + paging2);
         mav.addObject("paging2", paging2);
//
//    // mav.addObject("now_page", now_page);
//    
//    // 로그인 Cookie 지원
//    mav.setViewName("/contents/list_by_cateno_search_paging_cookie");  // /contents/list_by_cateno_search_paging_cookie.jsp ★
//    
//    // 로그인 Cookie + 쇼핑카트
        mav.setViewName("/frcontents/list_by_cateno_search_paging_all");  // /contents/list_by_cateno_search_paging.jsp ★ 

        return mav;
  }
 
  
}