/**********************************/
/* Table Name: �?리자 */
/**********************************/
DROP TABLE admin CASCADE CONSTRAINTS;
DROP TABLE admin;

CREATE TABLE admin(
    adminno    NUMBER(10)    NOT NULL,
    id         VARCHAR(20)   NOT NULL UNIQUE, -- ?��?��?��, 중복 ?��?��, ?��코드�? 구분 
    passwd     VARCHAR(15)   NOT NULL, -- ?��?��?��?��, ?��?��?�� 조합
    mname      VARCHAR(20)   NOT NULL, -- ?���?, ?���? 10?�� ???�� �??��
    mdate      DATE          NOT NULL, -- �??��?��    
    grade      NUMBER(2)     NOT NULL, -- ?���?(1~10: �?리자, 11~20: ?��?��, 비회?��: 30~39, ?���? ?��?��: 40~49, ?��?�� ?��?��: 99)    
    PRIMARY KEY (adminno)              -- ?���? ?��록된 값�? 중복 ?��?��
);

COMMENT ON TABLE admin is '�?리자';
COMMENT ON COLUMN admin.adminno is '�?리자 번호';
COMMENT ON COLUMN admin.id is '?��?��?��';
COMMENT ON COLUMN admin.PASSWD is '?��?��?��?��';
COMMENT ON COLUMN admin.MNAME is '?���?';
COMMENT ON COLUMN admin.MDATE is '�??��?��';
COMMENT ON COLUMN admin.GRADE is '?���?';

DROP SEQUENCE admin_seq;

CREATE SEQUENCE admin_seq
  START WITH 1                -- ?��?�� 번호
  INCREMENT BY 1            -- 증�?�?
  MAXVALUE 9999999999  -- 최�?�?: 9999999999 --> NUMBER(10) ???��
  CACHE 2                        -- 2번�? 메모리에?���? 계산
  NOCYCLE;                      -- ?��?�� 1�??�� ?��?��?��?�� 것을 방�?

INSERT INTO admin(adminno, id, passwd, mname, mdate, grade)
VALUES(admin_seq.nextval, 'admin1', '1234', 'ad1', sysdate, 1);

INSERT INTO admin(adminno, id, passwd, mname, mdate, grade)
VALUES(admin_seq.nextval, 'admin2', '1234', 'ad2', sysdate, 1);

INSERT INTO admin(adminno, id, passwd, mname, mdate, grade)
VALUES(admin_seq.nextval, 'admin3', '1234', 'ad3', sysdate, 1);

commit;

SELECT adminno, id, passwd, mname, mdate, grade FROM admin ORDER BY adminno ASC;
   ADMINNO ID                   PASSWD          MNAME                MDATE                    GRADE
---------- -------------------- --------------- -------------------- ------------------- ----------
         1 admin1               1234            �?리자1              2022-10-06 11:47:56          1
         2 admin2               1234            �?리자2              2022-10-06 11:47:56          1
         3 admin3               1234            �?리자3              2022-10-06 11:47:56          1
         
SELECT adminno, id, passwd, mname, mdate, grade 
FROM admin
WHERE adminno=1;
   ADMINNO ID                   PASSWD          MNAME                MDATE                    GRADE
---------- -------------------- --------------- -------------------- ------------------- ----------
         1 admin1               1234            �?리자1              2022-10-06 11:47:56          1

SELECT adminno, id, passwd, mname, mdate, grade 
FROM admin
WHERE id='admin1';
   ADMINNO ID                   PASSWD          MNAME                MDATE                    GRADE
---------- -------------------- --------------- -------------------- ------------------- ----------
         1 admin1               1234            �?리자1              2022-10-06 11:47:56          1

UPDATE admin
SET passwd='1234', mname='�?리자1', mdate=sysdate, grade=1
WHERE ADMINNO=1;

COMMIT;
         
DELETE FROM admin WHERE adminno=1;
-- ORA-02292: integrity constraint (KD.SYS_C007226) violated - child record found
-- ?��?�� ?��?��블에?�� adminno: 1?�� ?��?��?��고있�? ?��문에 ?��?�� 못함. 

-- 로그?��
SELECT COUNT(*) as cnt
FROM admin
WHERE id='admin1' AND passwd='1234';
  
  
  