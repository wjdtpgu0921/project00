package dev.mvc.fcate;

import java.util.ArrayList;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

//import dev.mvc.contents.ContentsVO;

@Component("dev.mvc.fcate.FCateProc")
public class FCateProc implements FCateProcInter {
  // CateDAOInter interface 만 존재하고 구현 class는 존재하지 않음.
  // interface는 객체를 만들 수 없고 할당만 받을 수 있음.
  
  @Autowired
  private FCateDAOInter fcateDAO;
  
  public FCateProc() {
    // System.out.println("-> CateProc created.");
    // System.out.println("-> CateProc: " + (fcateDAO == null));
  }
  
  @Override
  public int create(FCateVO fcateVO) {
    int cnt = this.fcateDAO.create(fcateVO); // MyBATIS가 처리한 레코드 갯수가 return됨
    
    // System.out.println("-> CateProc create: " + (fcateDAO == null));
    return cnt;
  }

  @Override
  public ArrayList<FCateVO> list_all() {
    ArrayList<FCateVO> list = this.fcateDAO.list_all();
    
    return list;
  }

  @Override
  public FCateVO read(int cateno) {
    FCateVO cateVO = this.fcateDAO.read(cateno);
    return cateVO;
  }

  @Override
  public int update(FCateVO fcateVO) {
    int cnt = this.fcateDAO.update(fcateVO);
    return cnt;
  }

  @Override
  public int delete(int cateno) {
    int cnt = this.fcateDAO.delete(cateno);
    return cnt;
  }

  @Override
  public int update_seqno_up(int cateno) {
    int cnt = this.fcateDAO.update_seqno_up(cateno);
    
    return cnt;
  }

  @Override
  public int update_seqno_down(int cateno) {
    int cnt = this.fcateDAO.update_seqno_down(cateno);
    
    return cnt;
  }

  @Override
  public int update_visible_y(int cateno) {
    int cnt = this.fcateDAO.update_visible_y(cateno);
    return cnt;
  }

  @Override
  public int update_visible_n(int cateno) {
    int cnt = this.fcateDAO.update_visible_n(cateno);
    return cnt;
  }

  @Override
  public ArrayList<FCateVO> list_all_y() {
    ArrayList<FCateVO> list = this.fcateDAO.list_all_y();
    return list;
  }

  @Override
  public int update_cnt_add(int cateno) {
    int cnt = this.fcateDAO.update_cnt_add(cateno);
    return cnt;
  }

  @Override
  public int update_cnt_sub(int cateno) {
    int cnt = this.fcateDAO.update_cnt_sub(cateno);
    return cnt;
  }


}

