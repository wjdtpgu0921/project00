package dev.mvc.favorites;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.favorites.FavoritesVO;
import dev.mvc.fcate.FCateProcInter;
import dev.mvc.fcate.FCateVO;
import dev.mvc.frcontents.FRContentsProcInter;
import dev.mvc.frcontents.FRContentsVO;
import dev.mvc.member.MemberProcInter;
import dev.mvc.member.MemberVO;

@Controller
public class FavoritesCont {
  @Autowired
  @Qualifier("dev.mvc.fcate.FCateProc") 
  private FCateProcInter fcateProc;
  @Autowired
  @Qualifier("dev.mvc.favorites.FavoritesProc") 
  private FavoritesProcInter favoritesProc;

  @Autowired
  @Qualifier("dev.mvc.member.MemberProc")
  private MemberProcInter memberProc = null;
  
  @Autowired
  @Qualifier("dev.mvc.frcontents.FRContentsProc") 
  private FRContentsProcInter frcontentsProc;
  
  public FavoritesCont() {
    System.out.println("-> created.");
  }
  
  
  /**
   * 목록 출력 가능
   * http://localhost:9091/member/list.do
   * @param session
   * @return
   */
   @RequestMapping(value="/favorites/list.do", method=RequestMethod.GET)
   public ModelAndView list(HttpSession session, 
		   @RequestParam(value = "cateno", defaultValue = "1") int cateno,
           @RequestParam(value = "fr_word", defaultValue = "") String fr_word,
           @RequestParam(value = "now_page", defaultValue = "1") int now_page) {
     ModelAndView mav = new ModelAndView();
     int memberno = (int)session.getAttribute("memberno");
     ArrayList<FRContentsVO> llist = new ArrayList<>();
     if (this.memberProc.isMember(session)) {

       ArrayList<FavoritesVO> list = this.favoritesProc.read(memberno);
       for(int i=0; i < list.size(); i++) {
      	 // frno가 여려개 저장되있는 list1 크기만큼
      	 // frno를 넣어서 frcontentVO를 리스트 안에 넣어야됨
      	 

      	 llist.add(this.frcontentsProc.read(list.get(i).getFrno()));
      	 mav.addObject("list", llist);
       }
       
       mav.setViewName("/favorites/list");
   
     }
     
     return mav;
   }  
   
   
   /**
    * 삭제 폼
    * @param frno
    * @return
    */
   @RequestMapping(value="/favorites/favorites_delete.do", method=RequestMethod.GET )
   public ModelAndView delete(HttpSession session, int frno) { 
     ModelAndView mav = new  ModelAndView();
     
     int cnt = 0;
     int memberno = (int)session.getAttribute("memberno");
     ArrayList<FRContentsVO> llist = new ArrayList<>();
     // 삭제할 정보를 조회하여 확인
     ArrayList<FavoritesVO> list = this.favoritesProc.read(memberno);
     cnt = this.favoritesProc.delete(frno); // DBMS 삭제
     for(int i=0; i < list.size(); i++) {
      	 // frno가 여려개 저장되있는 list1 크기만큼
      	 // frno를 넣어서 frcontentVO를 리스트 안에 넣어야됨
      	 

      	 llist.add(this.frcontentsProc.read(list.get(i).getFrno()));
      	 mav.addObject("list", llist);
       }
       
       mav.setViewName("redirect:/favorites/list.do");
   

     
     
     return mav; 
   }
   

}



