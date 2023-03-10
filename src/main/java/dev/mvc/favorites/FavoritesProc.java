package dev.mvc.favorites;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import dev.mvc.frcontents.FRContentsVO;
import dev.mvc.tool.Tool;

@Component("dev.mvc.favorites.FavoritesProc")
public class FavoritesProc implements FavoritesProcInter {
  // SurveyDAOInter interface λ§? μ‘΄μ¬?κ³? κ΅¬ν class? μ‘΄μ¬?μ§? ??.
  // interface? κ°μ²΄λ₯? λ§λ€ ? ?κ³? ? ?Ήλ§? λ°μ ? ??.
  
  @Autowired
  private FavoritesDAOInter favoritesDAO;
  
  public FavoritesProc() {
    // System.out.println("-> SurveyProc created.");
    // System.out.println("-> SurveyProc: " + (surveyDAO == null));
  }
  
  @Override
  public int create(FavoritesVO favoritesVO) {
    int cnt = this.favoritesDAO.create(favoritesVO); // MyBATISκ°? μ²λ¦¬? ? μ½λ κ°??κ°? return?¨    
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

