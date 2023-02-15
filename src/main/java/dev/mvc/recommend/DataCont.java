package dev.mvc.recommend;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class DataCont {
  public DataCont() {
    System.out.println("-> DataCont created.");
  }
  
  /**
   * 영화 추천
   * http://localhost:9093/recommend_food/mf_food.do
   * http://127.0.0.1:8000/recommend_food/mf_food?memberno=1
   * @return
   */
  @RequestMapping(value = "/recommend_food/mf_food.do", method = RequestMethod.GET)
  public ModelAndView json_list() {
    ModelAndView mav = new ModelAndView();
   
    // /WEB-INF/views/recommend_food/mf_food_list.jsp
    mav.setViewName("/recommend_food/mf_food_list");  

    return mav;
  }
  
}