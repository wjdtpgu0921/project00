/**********************************/
/* Table Name: 설문 항목 */
/**********************************/
CREATE TABLE surveyitem(
surveyitemno                   NUMBER(8)  NOT NULL  PRIMARY KEY,
surveyno                       NUMBER(8)  DEFAULT 0  NOT NULL,
item                           VARCHAR2(200)  NOT NULL,
cnt                            NUMBER(8)  DEFAULT 0  NOT NULL,
rdate                          DATE  NOT NULL,
  FOREIGN KEY (surveyno) REFERENCES survey (surveyno)
);

COMMENT ON TABLE surveyitem is '설문 항목';
COMMENT ON COLUMN surveyitem.surveyitemno is '설문 항목 번호';
COMMENT ON COLUMN surveyitem.surveyno is '설문 제목 번호';
COMMENT ON COLUMN surveyitem.item is '항목 내용';
COMMENT ON COLUMN surveyitem.cnt is '선택 카운트';
COMMENT ON COLUMN surveyitem.rdate is '등록날짜';

DROP SEQUENCE surveyitem_seq;
CREATE SEQUENCE surveyitem_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999999 --> NUMBER(8) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지
 

1. 등록

INSERT INTO surveyitem(surveyitemno, surveyno, item, cnt, rdate)
VALUES (surveyitem_seq.nextval, 1, '내용1', 1, sysdate);

INSERT INTO surveyitem(surveyitemno, surveyno, item, cnt, rdate)
VALUES (surveyitem_seq.nextval, 2, '내용2', 2, sysdate);

INSERT INTO surveyitem(surveyitemno, surveyno, item)
VALUES (surveyitem_seq.nextval, 2, '내용2');

COMMIT;
 
2. 목록
- 검색을 하지 않는 경우, 전체 목록 출력
 
SELECT surveyitemno, surveyno, item, cnt, rdate
FROM surveyitem
ORDER BY rdate ASC;

     
     
3. 조회
 
1) 주제 1번 보기
SELECT surveyitemno, surveyno, item, cnt, rdate
FROM surveyitem
WHERE surveyitemno = 4;

SELECT surveyitemno, surveyno, item, cnt, rdate
FROM surveyitem
WHERE surveyno = 6;
 
    
4. 수정
UPDATE surveyitem
SET surveyitemno=0, surveyno=1, item='내용0', cnt=0, rdate=sysdate
WHERE surveyitemno=1;

COMMIT;

 
5. 삭제
1) 모두 삭제
DELETE FROM surveyitem;
 
2) 특정 설문 삭제
DELETE FROM surveyitem
WHERE surveyitemno=1;

DELETE FROM surveyitem
WHERE surveyno=6;

COMMIT;

5. 레코드 갯수
SELECT COUNT(*) as cnt FROM surveyitem;

6. 검색 목록(구현 권장)
SELECT surveyitemno, surveyno, item, cnt, rdate
FROM surveyitem
WHERE item LIKE '%내용0%'
ORDER BY rdate ASC;

7. -- 검색 + 페이징 목록(구현 권장)
-- 검색, 정렬 -> rownum -> 분할
SELECT surveyitemno, surveyno, item, cnt, rdate, r
FROM(
     SELECT surveyitemno, surveyno, item, cnt, rdate, rownum as r
     FROM (
          SELECT surveyitemno, surveyno, item, cnt, rdate
          FROM surveyitem
          WHERE surveyitemno LIKE '%1%'
          ORDER BY rdate ASC
     )  
)
WHERE r >= 1 AND r <= 2;

8. 카운트 증가
UPDATE surveyitem
SET cnt = cnt + 1
WHERE surveyitemno = 1;

9. 설문 번호에 해당하는 카운트의 합
SELECT SUM(cnt)
FROM surveyitem
WHERE surveyno = 11;



