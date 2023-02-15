/**********************************/
/* Table Name: �������� */
/**********************************/
DROP TABLE NOTICE CASCADE CONSTRAINTS;
CREATE TABLE NOTICE(
NOTICENO                       NUMBER(10)  NOT NULL  PRIMARY KEY,
ADMINNO                             NUMBER(10)  NOT NULL,
TITLE                          VARCHAR2(300)          NOT NULL,
CONTENT                        CLOB                  NOT NULL,
RDATE                          DATE                  NOT NULL,
  FOREIGN KEY (ADMINNO) REFERENCES ADMIN (ADMINNO)
);

COMMENT ON TABLE NOTICE is '��������';
COMMENT ON COLUMN NOTICE.NOTICENO is '�������� ��ȣ';
COMMENT ON COLUMN NOTICE.ADMINNO is '������ ��ȣ';
COMMENT ON COLUMN NOTICE.TITLE is '����';
COMMENT ON COLUMN NOTICE.CONTENT is '����';
COMMENT ON COLUMN NOTICE.RDATE is '�����';

DROP SEQUENCE NOTICE_SEQ;
CREATE SEQUENCE NOTICE_SEQ
  START WITH 1              -- ���� ��ȣ
  INCREMENT BY 1            -- ������
  MAXVALUE 9999999999       -- �ִ밪: 9999999 --> NUMBER(7) ����
  CACHE 2                   -- 2���� �޸𸮿����� ���
  NOCYCLE;                  -- �ٽ� 1���� �����Ǵ� ���� ����
