/**********************************/
/* Table Name: κ΄?λ¦¬μ */
/**********************************/
DROP TABLE admin CASCADE CONSTRAINTS;
DROP TABLE admin;

CREATE TABLE admin(
    adminno    NUMBER(10)    NOT NULL,
    id         VARCHAR(20)   NOT NULL UNIQUE, -- ??΄?, μ€λ³΅ ??¨, ? μ½λλ₯? κ΅¬λΆ 
    passwd     VARCHAR(15)   NOT NULL, -- ?¨?€??, ??«? μ‘°ν©
    mname      VARCHAR(20)   NOT NULL, -- ?±λͺ?, ?κΈ? 10? ???₯ κ°??₯
    mdate      DATE          NOT NULL, -- κ°???Ό    
    grade      NUMBER(2)     NOT NULL, -- ?±κΈ?(1~10: κ΄?λ¦¬μ, 11~20: ??, λΉν?: 30~39, ? μ§? ??: 40~49, ??΄ ??: 99)    
    PRIMARY KEY (adminno)              -- ?λ²? ?±λ‘λ κ°μ? μ€λ³΅ ??¨
);

COMMENT ON TABLE admin is 'κ΄?λ¦¬μ';
COMMENT ON COLUMN admin.adminno is 'κ΄?λ¦¬μ λ²νΈ';
COMMENT ON COLUMN admin.id is '??΄?';
COMMENT ON COLUMN admin.PASSWD is '?¨?€??';
COMMENT ON COLUMN admin.MNAME is '?±λͺ?';
COMMENT ON COLUMN admin.MDATE is 'κ°???Ό';
COMMENT ON COLUMN admin.GRADE is '?±κΈ?';

DROP SEQUENCE admin_seq;

CREATE SEQUENCE admin_seq
  START WITH 1                -- ?? λ²νΈ
  INCREMENT BY 1            -- μ¦κ?κ°?
  MAXVALUE 9999999999  -- μ΅λ?κ°?: 9999999999 --> NUMBER(10) ???
  CACHE 2                        -- 2λ²μ? λ©λͺ¨λ¦¬μ?λ§? κ³μ°
  NOCYCLE;                      -- ?€? 1λΆ??° ??±?? κ²μ λ°©μ?

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
         1 admin1               1234            κ΄?λ¦¬μ1              2022-10-06 11:47:56          1
         2 admin2               1234            κ΄?λ¦¬μ2              2022-10-06 11:47:56          1
         3 admin3               1234            κ΄?λ¦¬μ3              2022-10-06 11:47:56          1
         
SELECT adminno, id, passwd, mname, mdate, grade 
FROM admin
WHERE adminno=1;
   ADMINNO ID                   PASSWD          MNAME                MDATE                    GRADE
---------- -------------------- --------------- -------------------- ------------------- ----------
         1 admin1               1234            κ΄?λ¦¬μ1              2022-10-06 11:47:56          1

SELECT adminno, id, passwd, mname, mdate, grade 
FROM admin
WHERE id='admin1';
   ADMINNO ID                   PASSWD          MNAME                MDATE                    GRADE
---------- -------------------- --------------- -------------------- ------------------- ----------
         1 admin1               1234            κ΄?λ¦¬μ1              2022-10-06 11:47:56          1

UPDATE admin
SET passwd='1234', mname='κ΄?λ¦¬μ1', mdate=sysdate, grade=1
WHERE ADMINNO=1;

COMMIT;
         
DELETE FROM admin WHERE adminno=1;
-- ORA-02292: integrity constraint (KD.SYS_C007226) violated - child record found
-- ?? ??΄λΈμ? adminno: 1? ?΄?©?κ³ μκΈ? ?λ¬Έμ ?­?  λͺ»ν¨. 

-- λ‘κ·Έ?Έ
SELECT COUNT(*) as cnt
FROM admin
WHERE id='admin1' AND passwd='1234';
  
  
  