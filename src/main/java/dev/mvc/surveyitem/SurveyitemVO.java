package dev.mvc.surveyitem;

/*
surveyitemno                   NUMBER(8)  NOT NULL  PRIMARY KEY,
surveyno                       NUMBER(8)  DEFAULT 0  NOT NULL,
item                           VARCHAR2(200)  NOT NULL,
cnt                            NUMBER(8)  DEFAULT 0  NOT NULL,
rdate                          DATE  NOT NULL,
 */
public class SurveyitemVO {
    /** 설문 항목 번호 */
    private int surveyitemno;
    /** 설문 제목 번호 */
    private int surveyno;
    /** 항목 내용 */
    private String item = "";
    /** 선택 카운트 */
    private int cnt;
    /** 등록날짜 */
    private String rdate = "";    

    public SurveyitemVO() { // 기본 생성자
        
    }

    public int getSurveyitemno() {
        return surveyitemno;
    }

    public void setSurveyitemno(int surveyitemno) {
        this.surveyitemno = surveyitemno;
    }
    
    public int getSurveyno() {
      return surveyno;
    }

    public void setSurveyno(int surveyno) {
      this.surveyno = surveyno;
    }
    
    public String getItem() {
      return item;
    }

    public void setItem(String item) {
      this.item = item;
    }

    public int getCnt() {
        return cnt;
    }

    public void setCnt(int cnt) {
        this.cnt = cnt;
    }

    public String getRdate() {
        return rdate;
    }

    public void setRdate(String rdate) {
        this.rdate = rdate;
    }
  
}
