/**********************************/
/* Table Name: ���� ī�װ� */
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

COMMENT ON TABLE FRCATE is '���� ī�װ�';
COMMENT ON COLUMN FRCATE.CATENO is 'ī�װ���ȣ';
COMMENT ON COLUMN FRCATE.CATENAME is 'ī�װ� �̸�';
COMMENT ON COLUMN FRCATE.CNT is '�����ڷ��';
COMMENT ON COLUMN FRCATE.RDATE is '�����';
COMMENT ON COLUMN FRCATE.SEQNO is '��� ����';
COMMENT ON COLUMN FRCATE.VISIBLE is '��� ���';


/**********************************/
/* Table Name: ȸ�� */
/**********************************/
CREATE TABLE MEMBER(
		MEMBERNO                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY
);

COMMENT ON TABLE MEMBER is 'ȸ��';
COMMENT ON COLUMN MEMBER.MEMBERNO is 'ȸ����ȣ';


/**********************************/
/* Table Name: ���� */
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

COMMENT ON TABLE FRCONTENTS is '����';
COMMENT ON COLUMN FRCONTENTS.FRNO is '������ȣ';
COMMENT ON COLUMN FRCONTENTS.CATENO is 'ī�װ���ȣ';
COMMENT ON COLUMN FRCONTENTS.MEMBERNO is 'ȸ����ȣ';
COMMENT ON COLUMN FRCONTENTS.FR_NAME is '�����̸�';
COMMENT ON COLUMN FRCONTENTS.FR_CONTENT is '��������';
COMMENT ON COLUMN FRCONTENTS.FK_ADDRESS is '�����ּ�';
COMMENT ON COLUMN FRCONTENTS.FR_MAP is '��������';
COMMENT ON COLUMN FRCONTENTS.FR_RDATE is '�����';
COMMENT ON COLUMN FRCONTENTS.FR_UDATE is '������';
COMMENT ON COLUMN FRCONTENTS.RECOMMEND is '��õ��';
COMMENT ON COLUMN FRCONTENTS.REVIEW_CNT is '�����';
COMMENT ON COLUMN FRCONTENTS.PRICE is '����';
COMMENT ON COLUMN FRCONTENTS.FILE1 is '���� �̹���';
COMMENT ON COLUMN FRCONTENTS.FILE1SAVED is '���� ����� ���� �̹���';
COMMENT ON COLUMN FRCONTENTS.THUMB1 is '���� �̹��� Preview';
COMMENT ON COLUMN FRCONTENTS.SIZE1 is '���� �̹��� ũ��';


/**********************************/
/* Table Name: ���� */
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

COMMENT ON TABLE REVIEW is '����';
COMMENT ON COLUMN REVIEW.REVIEWNO is '�����ȣ';
COMMENT ON COLUMN REVIEW.FRNO is '������ȣ';
COMMENT ON COLUMN REVIEW.MEMBERNO is 'ȸ����ȣ';
COMMENT ON COLUMN REVIEW.RATING is '����';
COMMENT ON COLUMN REVIEW.REVIEW_CONTENTS is '���� ����';


