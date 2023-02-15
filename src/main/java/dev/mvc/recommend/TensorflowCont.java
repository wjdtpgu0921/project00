package dev.mvc.recommend;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class TensorflowCont {
  // http://localhost:9091/type2_recommend_food/start.do
  @RequestMapping(value = {"/type2_recommend_food/start.do"}, method = RequestMethod.GET)
  public ModelAndView start() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/type2_recommend_food/start");  // /WEB-INF/views/type2_recommend_food/start.jsp
    
    return mav;
  }

  // http://localhost:9091/type2_recommend_food/form1.do
  @RequestMapping(value = {"/type2_recommend_food/form1.do"}, method = RequestMethod.GET)
  public ModelAndView form1() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/type2_recommend_food/form1");  // /WEB-INF/views/type2_recommend_food/form1.jsp
    
    return mav;
  }

  // http://localhost:9091/type2_recommend_food/form2.do
  @RequestMapping(value = {"/type2_recommend_food/form2.do"}, method = RequestMethod.GET)
  public ModelAndView form2() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/type2_recommend_food/form2");  // /WEB-INF/views/type2_recommend_food/form2.jsp
    
    return mav;
  }

  // http://localhost:9091/type2_recommend_food/form3.do
  @RequestMapping(value = {"/type2_recommend_food/form3.do"}, method = RequestMethod.GET)
  public ModelAndView form3() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/type2_recommend_food/form3");  // /WEB-INF/views/type2_recommend_food/form3.jsp
    
    return mav;
  }
  
  // http://localhost:9091/type2_recommend_food/form4.do
  @RequestMapping(value = {"/type2_recommend_food/form4.do"}, method = RequestMethod.GET)
  public ModelAndView form4() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/type2_recommend_food/form4");  // /WEB-INF/views/type2_recommend_food/form3.jsp
    
    return mav;
  }
  
  // http://localhost:9091/type2_recommend_food/form5.do
  @RequestMapping(value = {"/type2_recommend_food/form5.do"}, method = RequestMethod.GET)
  public ModelAndView form5() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/type2_recommend_food/form5");  // /WEB-INF/views/type2_recommend_food/form3.jsp
    
    return mav;
  }
  
  // http://localhost:9091/type2_recommend_food/form3.do
  @RequestMapping(value = {"/type2_recommend_food/form6.do"}, method = RequestMethod.GET)
  public ModelAndView form6() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/type2_recommend_food/form6");  // /WEB-INF/views/type2_recommend_food/form3.jsp
    
    return mav;
  }
  
  // http://localhost:9091/type2_recommend_food/end.do
  @RequestMapping(value = {"/type2_recommend_food/end.do"}, method = RequestMethod.GET)
  public ModelAndView end() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/type2_recommend_food/end");  // /WEB-INF/views/type2_recommend_food/end.jsp
    
    return mav;
  }
  
    
}
