/**********************************/
/* Table Name: 맛집 카테고리 */
/**********************************/
CREATE TABLE FRCATE(
		CATENO                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		CATENAME                      		VARCHAR2(50)		 NOT NULL,
		CNT                           		NUMBER(7)		 NOT NULL,
		RDATE                         		DATE		 NOT NULL,
		SEQNO                         		INTEGER(10)		 NULL ,
		VISIBLE                       		INTEGER(10)		 NULL 
);
.3

COMMENT ON TABLE FRCATE is '맛집 카테고리';
COMMENT ON COLUMN FRCATE.CATENO is '카테고리번호';
COMMENT ON COLUMN FRCATE.CATENAME is '카테고리 이름';
COMMENT ON COLUMN FRCATE.CNT is '관련자료수';
COMMENT ON COLUMN FRCATE.RDATE is '등록일';
COMMENT ON COLUMN FRCATE.SEQNO is '출력 순서';
COMMENT ON COLUMN FRCATE.VISIBLE is '출력 모드';


/**********************************/
/* Table Name: 회원 */
/**********************************/
CREATE TABLE MEMBER(
		MEMBERNO                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY
);

COMMENT ON TABLE MEMBER is '회원';
COMMENT ON COLUMN MEMBER.MEMBERNO is '회원번호';


/**********************************/
/* Table Name: 맛집 */
/**********************************/
CREATE TABLE FRCONTENTS(
		FRNO                          		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		CATENO                        		NUMBER(10)		 NULL ,
		MEMBERNO                      		NUMBER(10)		 NULL ,
		FR_NAME                       		VARCHAR2(50)		 NULL ,
		FR_CONTENT                    		VARCHAR2(2000)		 NULL ,
		FK_ADDRESS                    		VARCHAR2(30)		 NULL ,
		FR_MAP                        		VARCHAR2(50)		 NULL ,
		FR_RDATE                      		DATE		 NULL ,
		FR_UDATE                      		DATE		 NULL ,
		RECOMMEND                     		NUMBER(10)		 NULL ,
		REVIEW_CNT                    		NUMBER(10)		 NULL ,
		PRICE                         		NUMBER(20)		 NULL ,
		FILE1                         		VARCHAR2(100)		 NULL ,
		FILE1SAVED                    		VARCHAR2(100)		 NULL ,
		THUMB1                        		VARCHAR2(100)		 NULL ,
		SIZE1                         		NUMBER(10)		 NULL ,
  FOREIGN KEY (CATENO) REFERENCES FRCATE (CATENO),
  FOREIGN KEY (MEMBERNO) REFERENCES MEMBER (MEMBERNO)
);

COMMENT ON TABLE FRCONTENTS is '맛집';
COMMENT ON COLUMN FRCONTENTS.FRNO is '맛집번호';
COMMENT ON COLUMN FRCONTENTS.CATENO is '카테고리번호';
COMMENT ON COLUMN FRCONTENTS.MEMBERNO is '회원번호';
COMMENT ON COLUMN FRCONTENTS.FR_NAME is '맛집이름';
COMMENT ON COLUMN FRCONTENTS.FR_CONTENT is '맛집설명';
COMMENT ON COLUMN FRCONTENTS.FK_ADDRESS is '맛집주소';
COMMENT ON COLUMN FRCONTENTS.FR_MAP is '맛집지도';
COMMENT ON COLUMN FRCONTENTS.FR_RDATE is '등록일';
COMMENT ON COLUMN FRCONTENTS.FR_UDATE is '수정일';
COMMENT ON COLUMN FRCONTENTS.RECOMMEND is '추천수';
COMMENT ON COLUMN FRCONTENTS.REVIEW_CNT is '리뷰수';
COMMENT ON COLUMN FRCONTENTS.PRICE is '가격';
COMMENT ON COLUMN FRCONTENTS.FILE1 is '메인 이미지';
COMMENT ON COLUMN FRCONTENTS.FILE1SAVED is '실제 저장된 메인 이미지';
COMMENT ON COLUMN FRCONTENTS.THUMB1 is '메인 이미지 Preview';
COMMENT ON COLUMN FRCONTENTS.SIZE1 is '메인 이미지 크기';


/**********************************/
/* Table Name: 리뷰 */
/**********************************/
CREATE TABLE REVIEW(
		REVIEWNO                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		FRNO                          		NUMBER(10)		 NULL ,
		MEMBERNO                      		NUMBER(10)		 NULL ,
		RATING                        		NUMBER(2)		 NULL ,
		REVIEW_CONTENTS               		VARCHAR2(100)		 NULL ,
  FOREIGN KEY (FRNO) REFERENCES FRCONTENTS (FRNO),
  FOREIGN KEY (MEMBERNO) REFERENCES MEMBER (MEMBERNO)
);

COMMENT ON TABLE REVIEW is '리뷰';
COMMENT ON COLUMN REVIEW.REVIEWNO is '리뷰번호';
COMMENT ON COLUMN REVIEW.FRNO is '맛집번호';
COMMENT ON COLUMN REVIEW.MEMBERNO is '회원번호';
COMMENT ON COLUMN REVIEW.RATING is '평점';
COMMENT ON COLUMN REVIEW.REVIEW_CONTENTS is '리뷰 내용';


