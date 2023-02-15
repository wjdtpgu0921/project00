package dev.mvc.msurvey;

/*
msurveyno                   NUMBER(8)  NOT NULL  PRIMARY KEY,
surveyno                       NUMBER(8)  DEFAULT 0  NOT NULL,
MEMBERNO                           VARCHAR2(200)  NOT NULL,
surveyitemno                           NUMBER(8)  DEFAULT 0  NOT NULL,
rdate                          DATE  NOT NULL,
 */
public class MsurveyVO {
    /** 설문 참여 번호 */
    private int msurveyno;
    /** 설문 번호 */
    private int surveyno;
    /** 멤버 번호 */
    private int MEMBERNO;
    /** 항목 번호 */
    private int surveyitemno;
    /** 등록날짜 */
    private String rdate = "";    

    public MsurveyVO() { // 기본 생성자
        
    }

    public int getMsurveyno() {
        return msurveyno;
    }

    public void setMsurveyno(int msurveyno) {
        this.msurveyno = msurveyno;
    }
    
    public int getSurveyno() {
      return surveyno;
    }

    public void setSurveyno(int surveyno) {
      this.surveyno = surveyno;
    }
    
    public int getMEMBERNO() {
      return MEMBERNO;
    }

    public void setMEMBERNO(int MEMBERNO) {
      this.MEMBERNO = MEMBERNO;
    }

    public int getSurveyitemno() {
        return surveyitemno;
    }

    public void setSurveyitemno(int surveyitemno) {
        this.surveyitemno = surveyitemno;
    }

    public String getRdate() {
        return rdate;
    }

    public void setRdate(String rdate) {
        this.rdate = rdate;
    }
  
}
