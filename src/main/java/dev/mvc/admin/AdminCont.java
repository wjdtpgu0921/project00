package dev.mvc.admin;

import java.util.HashMap;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AdminCont {
  @Autowired
  @Qualifier("dev.mvc.admin.AdminProc")
  private AdminProcInter adminProc = null;
  
  public AdminCont(){
    System.out.println("-> AdminCont created.");
  }
  
  /**
   * 濡쒓렇�씤 �뤌
   * @return
   */
  // http://localhost:9091/admin/login.do 
  @RequestMapping(value = "/admin/login.do", 
                             method = RequestMethod.GET)
  public ModelAndView login_cookie(HttpServletRequest request) {
    ModelAndView mav = new ModelAndView();
    
    Cookie[] cookies = request.getCookies();
    Cookie cookie = null;
  
    String ck_admin_id = ""; // id ���옣
    String ck_admin_id_save = ""; // id ���옣 �뿬遺�瑜� 泥댄겕
    String ck_admin_passwd = ""; // passwd ���옣
    String ck_admin_passwd_save = ""; // passwd ���옣 �뿬遺�瑜� 泥댄겕
  
    if (cookies != null) { // 荑좏궎媛� 議댁옱�븳�떎硫�
      for (int i=0; i < cookies.length; i++){
        cookie = cookies[i]; // 荑좏궎 媛앹껜 異붿텧
      
        if (cookie.getName().equals("ck_admin_id")){
          ck_admin_id = cookie.getValue(); 
        }else if(cookie.getName().equals("ck_admin_id_save")){
          ck_admin_id_save = cookie.getValue();  // Y, N
        }else if (cookie.getName().equals("ck_admin_passwd")){
          ck_admin_passwd = cookie.getValue();         // 1234
        }else if(cookie.getName().equals("ck_admin_passwd_save")){
          ck_admin_passwd_save = cookie.getValue();  // Y, N
        }
      }
    }
  
    //    <input type='text' class="form-control" name='id' id='id' 
    //            value='${ck_admin_id }' required="required" 
    //            style='width: 30%;' placeholder="�븘�씠�뵒" autofocus="autofocus">
    mav.addObject("ck_admin_id", ck_admin_id);
  
    //    <input type='checkbox' name='id_save' value='Y' 
    //            ${ck_admin_id_save == 'Y' ? "checked='checked'" : "" }> ���옣
    mav.addObject("ck_admin_id_save", ck_admin_id_save);
  
    mav.addObject("ck_admin_passwd", ck_admin_passwd);
    mav.addObject("ck_admin_passwd_save", ck_admin_passwd_save);
  
    mav.setViewName("/admin/login_form_ck"); // /admin/login_form_ck.jsp
    return mav;
  }
   
  /**
  * Cookie 湲곕컲 濡쒓렇�씤 泥섎━
  * @param request Cookie瑜� �씫湲곗쐞�빐 �븘�슂
  * @param response Cookie瑜� �벐湲곗쐞�빐 �븘�슂
  * @param session 濡쒓렇�씤 �젙蹂대�� 硫붾え由ъ뿉 湲곕줉
  * @param id  �쉶�썝 �븘�씠�뵒
  * @param passwd �쉶�썝 �뙣�뒪�썙�뱶
  * @param id_save �쉶�썝 �븘�씠�뵒 Cookie�뿉 ���옣 �뿬遺�
  * @param passwd_save �뙣�뒪�썙�뱶 Cookie�뿉 ���옣 �뿬遺�
  * @return
  */
  // http://localhost:9091/admin/login.do 
  @RequestMapping(value = "/admin/login.do", 
                            method = RequestMethod.POST)
  public ModelAndView login_cookie_proc(
                            HttpServletRequest request,
                            HttpServletResponse response,
                            HttpSession session,
                            String id,
                            String passwd,
                            @RequestParam(value="id_save", defaultValue="") String id_save,
                            @RequestParam(value="passwd_save", defaultValue="") String passwd_save) {
    ModelAndView mav = new ModelAndView();
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("id", id);
    map.put("passwd", passwd);
   
    int cnt = adminProc.login(map);
    if (cnt == 1) { // 濡쒓렇�씤 �꽦怨�
      // System.out.println(id + " 濡쒓렇�씤 �꽦怨�");
      AdminVO adminVO = adminProc.readById(id);
      session.setAttribute("adminno", adminVO.getAdminno()); // �꽌踰꾩쓽 硫붾え由ъ뿉 湲곕줉
      session.setAttribute("admin_id", id);
      session.setAttribute("admin_mname", adminVO.getMname());
      session.setAttribute("admin_grade", adminVO.getGrade());
   
      // -------------------------------------------------------------------
      // id 愿��젴 荑좉린 ���옣
      // -------------------------------------------------------------------
      if (id_save.equals("Y")) { // id瑜� ���옣�븷 寃쎌슦, Checkbox瑜� 泥댄겕�븳 寃쎌슦
        Cookie ck_admin_id = new Cookie("ck_admin_id", id);
        ck_admin_id.setPath("/");  // root �뤃�뜑�뿉 荑좏궎瑜� 湲곕줉�븿�쑝濡� 紐⑤뱺 寃쎈줈�뿉�꽌 荑좉린 �젒洹� 媛��뒫
        ck_admin_id.setMaxAge(60 * 60 * 24 * 30); // 30 day, 珥덈떒�쐞
        response.addCookie(ck_admin_id); // id ���옣
      } else { // N, id瑜� ���옣�븯吏� �븡�뒗 寃쎌슦, Checkbox瑜� 泥댄겕 �빐�젣�븳 寃쎌슦
        Cookie ck_admin_id = new Cookie("ck_admin_id", "");
        ck_admin_id.setPath("/");
        ck_admin_id.setMaxAge(0);
        response.addCookie(ck_admin_id); // id ���옣
      }
      
      // id瑜� ���옣�븷吏� �꽑�깮�븯�뒗  CheckBox 泥댄겕 �뿬遺�
      Cookie ck_admin_id_save = new Cookie("ck_admin_id_save", id_save);
      ck_admin_id_save.setPath("/");
      ck_admin_id_save.setMaxAge(60 * 60 * 24 * 30); // 30 day
      response.addCookie(ck_admin_id_save);
      // -------------------------------------------------------------------
  
      // -------------------------------------------------------------------
      // Password 愿��젴 荑좉린 ���옣
      // -------------------------------------------------------------------
      if (passwd_save.equals("Y")) { // �뙣�뒪�썙�뱶 ���옣�븷 寃쎌슦
        Cookie ck_admin_passwd = new Cookie("ck_admin_passwd", passwd);
        ck_admin_passwd.setPath("/");
        ck_admin_passwd.setMaxAge(60 * 60 * 24 * 30); // 30 day
        response.addCookie(ck_admin_passwd);
      } else { // N, �뙣�뒪�썙�뱶瑜� ���옣�븯吏� �븡�쓣 寃쎌슦
        Cookie ck_admin_passwd = new Cookie("ck_admin_passwd", "");
        ck_admin_passwd.setPath("/");
        ck_admin_passwd.setMaxAge(0);
        response.addCookie(ck_admin_passwd);
      }
      // passwd瑜� ���옣�븷吏� �꽑�깮�븯�뒗  CheckBox 泥댄겕 �뿬遺�
      Cookie ck_admin_passwd_save = new Cookie("ck_admin_passwd_save", passwd_save);
      ck_admin_passwd_save.setPath("/");
      ck_admin_passwd_save.setMaxAge(60 * 60 * 24 * 30); // 30 day
      response.addCookie(ck_admin_passwd_save);
      // -------------------------------------------------------------------
   
      mav.setViewName("redirect:/index.do");  
    } else {
      mav.addObject("url", "/admin/login_fail_msg");
      mav.setViewName("redirect:/admin/msg.do"); 
    }
       
    return mav;
  }
    
  /**
   * 濡쒓렇�븘�썐 泥섎━
   * @param session
   * @return
   */
  @RequestMapping(value="/admin/logout.do", 
                             method=RequestMethod.GET)
  public ModelAndView logout(HttpSession session){
    ModelAndView mav = new ModelAndView();
    session.invalidate(); // 紐⑤뱺 session 蹂��닔 �궘�젣
    
    mav.setViewName("redirect:/index.do"); 
    
    return mav;
  }
  
  /**
   * �깉濡쒓퀬移� 諛⑹�, EL�뿉�꽌 param�쑝濡� �젒洹�
   * @return
   */
  @RequestMapping(value="/admin/msg.do", method=RequestMethod.GET)
  public ModelAndView msg(String url){
    ModelAndView mav = new ModelAndView();

    mav.setViewName(url); // forward
    
    return mav; // forward
  }
  
}
