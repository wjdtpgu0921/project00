package dev.mvc.survey;

/*
    surveyno                          NUMBER(8)    NOT NULL    PRIMARY KEY,
    topic                             VARCHAR2(100)    NOT NULL,
    yn                                VARCHAR2(1)    DEFAULT 'N'     NOT NULL,
    rdate                             DATE     NOT NULL
 */

public class SurveyVO {
  /** 설문 번호 */
  private int surveyno;
  
  /** 설문 주제 */
  private String topic = "";
  
  /** 여부 */
  private String yn = "";
  
  /** 등록일 */
  private String rdate = "";
  
  public int getSurveyno() {
    return surveyno;
  }
  public void setSurveyno(int surveyno) {
    this.surveyno = surveyno;
  }
  
  public String getTopic() {
    return topic;
  }
  public void setTopic(String topic) {
    this.topic = topic;
  }
  
  public String getYn() {
    return yn;
  }
  public void setYn(String yn) {
    this.yn = yn;
  }
  
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
  }
  
}
