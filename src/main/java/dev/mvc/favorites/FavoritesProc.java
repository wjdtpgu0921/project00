package dev.mvc.favorites;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import dev.mvc.frcontents.FRContentsVO;
import dev.mvc.tool.Tool;

@Component("dev.mvc.favorites.FavoritesProc")
public class FavoritesProc implements FavoritesProcInter {
  // SurveyDAOInter interface ë§? ì¡´ìž¬?•˜ê³? êµ¬í˜„ class?Š” ì¡´ìž¬?•˜ì§? ?•Š?Œ.
  // interface?Š” ê°ì²´ë¥? ë§Œë“¤ ?ˆ˜ ?—†ê³? ?• ?‹¹ë§? ë°›ì„ ?ˆ˜ ?žˆ?Œ.
  
  @Autowired
  private FavoritesDAOInter favoritesDAO;
  
  public FavoritesProc() {
    // System.out.println("-> SurveyProc created.");
    // System.out.println("-> SurveyProc: " + (surveyDAO == null));
  }
  
  @Override
  public int create(FavoritesVO favoritesVO) {
    int cnt = this.favoritesDAO.create(favoritesVO); // MyBATISê°? ì²˜ë¦¬?•œ ? ˆì½”ë“œ ê°??ˆ˜ê°? return?¨    
    // System.out.println("-> SurveyProc create: " + (surveyDAO == null));
    return cnt;
  }
  
  
  @Override
  public ArrayList<FavoritesVO> read(int memberno) {
	ArrayList<FavoritesVO> list = this.favoritesDAO.read(memberno);
	
	
	for (int i=0; i<list.size(); i++) {
		  FavoritesVO favoritesVO = list.get(i);	      
	      int temp = favoritesVO.getFrno();	            
	      favoritesVO.setFrno(temp);
	    }
	

	//System.out.println("-> ssss: " + list.get(0));
    //System.out.println("->->->->->" + list.size());
    return list;
  }

  
  @Override
  public int delete(int frno) {
    int cnt = this.favoritesDAO.delete(frno);
    return cnt;
  }
}

