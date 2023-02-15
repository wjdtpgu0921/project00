/**********************************/
/* Table Name: ê´?ë¦¬ì */
/**********************************/
DROP TABLE admin CASCADE CONSTRAINTS;
DROP TABLE admin;

CREATE TABLE admin(
    adminno    NUMBER(10)    NOT NULL,
    id         VARCHAR(20)   NOT NULL UNIQUE, -- ?•„?´?””, ì¤‘ë³µ ?•ˆ?¨, ? ˆì½”ë“œë¥? êµ¬ë¶„ 
    passwd     VARCHAR(15)   NOT NULL, -- ?Œ¨?Š¤?›Œ?“œ, ?˜?ˆ«? ì¡°í•©
    mname      VARCHAR(20)   NOT NULL, -- ?„±ëª?, ?•œê¸? 10? ???¥ ê°??Š¥
    mdate      DATE          NOT NULL, -- ê°??…?¼    
    grade      NUMBER(2)     NOT NULL, -- ?“±ê¸?(1~10: ê´?ë¦¬ì, 11~20: ?šŒ?›, ë¹„íšŒ?›: 30~39, ? •ì§? ?šŒ?›: 40~49, ?ƒˆ?‡´ ?šŒ?›: 99)    
    PRIMARY KEY (adminno)              -- ?•œë²? ?“±ë¡ëœ ê°’ì? ì¤‘ë³µ ?•ˆ?¨
);

COMMENT ON TABLE admin is 'ê´?ë¦¬ì';
COMMENT ON COLUMN admin.adminno is 'ê´?ë¦¬ì ë²ˆí˜¸';
COMMENT ON COLUMN admin.id is '?•„?´?””';
COMMENT ON COLUMN admin.PASSWD is '?Œ¨?Š¤?›Œ?“œ';
COMMENT ON COLUMN admin.MNAME is '?„±ëª?';
COMMENT ON COLUMN admin.MDATE is 'ê°??…?¼';
COMMENT ON COLUMN admin.GRADE is '?“±ê¸?';

DROP SEQUENCE admin_seq;

CREATE SEQUENCE admin_seq
  START WITH 1                -- ?‹œ?‘ ë²ˆí˜¸
  INCREMENT BY 1            -- ì¦ê?ê°?
  MAXVALUE 9999999999  -- ìµœë?ê°?: 9999999999 --> NUMBER(10) ???‘
  CACHE 2                        -- 2ë²ˆì? ë©”ëª¨ë¦¬ì—?„œë§? ê³„ì‚°
  NOCYCLE;                      -- ?‹¤?‹œ 1ë¶??„° ?ƒ?„±?˜?Š” ê²ƒì„ ë°©ì?

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
         1 admin1               1234            ê´?ë¦¬ì1              2022-10-06 11:47:56          1
         2 admin2               1234            ê´?ë¦¬ì2              2022-10-06 11:47:56          1
         3 admin3               1234            ê´?ë¦¬ì3              2022-10-06 11:47:56          1
         
SELECT adminno, id, passwd, mname, mdate, grade 
FROM admin
WHERE adminno=1;
   ADMINNO ID                   PASSWD          MNAME                MDATE                    GRADE
---------- -------------------- --------------- -------------------- ------------------- ----------
         1 admin1               1234            ê´?ë¦¬ì1              2022-10-06 11:47:56          1

SELECT adminno, id, passwd, mname, mdate, grade 
FROM admin
WHERE id='admin1';
   ADMINNO ID                   PASSWD          MNAME                MDATE                    GRADE
---------- -------------------- --------------- -------------------- ------------------- ----------
         1 admin1               1234            ê´?ë¦¬ì1              2022-10-06 11:47:56          1

UPDATE admin
SET passwd='1234', mname='ê´?ë¦¬ì1', mdate=sysdate, grade=1
WHERE ADMINNO=1;

COMMIT;
         
DELETE FROM admin WHERE adminno=1;
-- ORA-02292: integrity constraint (KD.SYS_C007226) violated - child record found
-- ??‹ ?…Œ?´ë¸”ì—?„œ adminno: 1?„ ?´?š©?•˜ê³ ìˆê¸? ?•Œë¬¸ì— ?‚­? œ ëª»í•¨. 

-- ë¡œê·¸?¸
SELECT COUNT(*) as cnt
FROM admin
WHERE id='admin1' AND passwd='1234';
  
  
  