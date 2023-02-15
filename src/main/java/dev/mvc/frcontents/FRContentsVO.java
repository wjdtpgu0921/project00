package dev.mvc.frcontents;

import org.springframework.web.multipart.MultipartFile;

//CREATE TABLE frcontents(
//    frno                                  NUMBER(10)         NOT NULL         PRIMARY KEY,
//    cateno                                NUMBER(10)     NOT NULL , -- FK
//    memberno                              NUMBER(10)         NOT NULL , -- FK
//    fr_name                               VARCHAR2(60)         NOT NULL,
//    fr_content                            VARCHAR2(3000)                  NOT NULL,
//    fr_addres                             VARCHAR2(200)         DEFAULT 0         NOT NULL,
//    fr_map                                VARCHAR2(50)            NULL,
//    fr_word                                  VARCHAR2(100)         NULL ,
//    fr_rdate                              DATE               NOT NULL,
//    fr_udate                              DATE                NULL,
//    review_cnt                            NUMBER(10)      DEFAULT 0 NULL,
//    price                                 NUMBER(20)      NOT NULL,
//    file1                                 VARCHAR(100)          NULL,  -- 원본 파일명 image
//    file1saved                            VARCHAR(100)          NULL,  -- 저장된 파일명, image
//    thumb1                                VARCHAR(100)          NULL,   -- preview image
//    size1                                 NUMBER(10)      DEFAULT 0 NULL,
//    FOREIGN KEY (cateno) REFERENCES frcate (cateno),
//    FOREIGN KEY (memberno) REFERENCES member (memberno)
//);
public class FRContentsVO {
  /** 맛집번호 */
  private int frno;
  /** 카테고리 번호 */
  private int cateno;
  /** 회원 번호 */
  private int memberno;
  /** 맛집 이름 */
  private String fr_name = "";
  /** 맛집 설명 */
  private String fr_content = "";
  /** 맛집 주소 */
  private String fr_addres = "";
  
  /** 맛집 지도 */
  private String fr_map;
  
  /** 검색어 */
  private String fr_word = "";

  /** 등록일 */
  private String fr_rdate = "";
  /** 등록일 */
  private String fr_udate = "";

  /** 리뷰수 */
  private int review_cnt=0;
  /** 가격 */
  private String price="";
  
  /** 메인 이미지 */
  private String file1 = "";
  /** 실제 저장된 메인 이미지 */
  private String file1saved = "";
  /** 메인 이미지 preview */
  private String thumb1 = "";
  /** 메인 이미지 크기 */
  private long size1;
  /** 평점 */
  private double ratings;



public double getRatings() {
    return ratings;
  }

  public void setRatings(double ratings) {
    this.ratings = ratings;
  }

/**
   이미지 파일
   <input type='file' class="form-control" name='file1MF' id='file1MF' 
              value='' placeholder="파일 선택">
   */
  private MultipartFile file1MF;
  
  /** 메인 이미지 크기 단위, 파일 크기 */
  private String size1_label = "";

  public int getFrno() {
    return frno;
  }

  public void setFrno(int frno) {
    this.frno = frno;
  }

  public int getCateno() {
    return cateno;
  }

  public void setCateno(int cateno) {
    this.cateno = cateno;
  }

  public int getMemberno() {
    return memberno;
  }

  public void setMemberno(int memberno) {
    this.memberno = memberno;
  }

  public String getFr_name() {
    return fr_name;
  }

  public void setFr_name(String fr_name) {
    this.fr_name = fr_name;
  }

  public String getFr_content() {
    return fr_content;
  }

  public void setFr_content(String fr_content) {
    this.fr_content = fr_content;
  }

  public String getFr_addres() {
    return fr_addres;
  }

  public void setFr_addres(String fr_addres) {
    this.fr_addres = fr_addres;
  }

  public String getFr_map() {
    return fr_map;
  }

  public void setFr_map(String fr_map) {
    this.fr_map = fr_map;
  }

  public String getFr_word() {
    return fr_word;
  }

  public void setFr_word(String fr_word) {
    this.fr_word = fr_word;
  }

  public String getFr_rdate() {
    return fr_rdate;
  }

  public void setFr_rdate(String fr_rdate) {
    this.fr_rdate = fr_rdate;
  }

  public String getFr_udate() {
    return fr_udate;
  }

  public void setFr_udate(String fr_udate) {
    this.fr_udate = fr_udate;
  }

  public int getReview_cnt() {
    return review_cnt;
  }

  public void setReview_cnt(int review_cnt) {
    this.review_cnt = review_cnt;
  }

  public String getPrice() {
    return price;
  }

  public void setPrice(String price) {
    this.price = price;
  }

  public String getFile1() {
    return file1;
  }

  public void setFile1(String file1) {
    this.file1 = file1;
  }

  public String getFile1saved() {
    return file1saved;
  }

  public void setFile1saved(String file1saved) {
    this.file1saved = file1saved;
  }

  public String getThumb1() {
    return thumb1;
  }

  public void setThumb1(String thumb1) {
    this.thumb1 = thumb1;
  }

  public long getSize1() {
    return size1;
  }

  public void setSize1(long size1) {
    this.size1 = size1;
  }

  public MultipartFile getFile1MF() {
    return file1MF;
  }

  public void setFile1MF(MultipartFile file1mf) {
    file1MF = file1mf;
  }

  public String getSize1_label() {
    return size1_label;
  }

  public void setSize1_label(String size1_label) {
    this.size1_label = size1_label;
  }
  
  
}

