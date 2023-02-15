/**********************************/
/* Table Name: 설문 참여 */
/**********************************/
CREATE TABLE msurvey(
msurveyno                      NUMBER(8)  NOT NULL  PRIMARY KEY,
surveyno                       NUMBER(8)  NULL ,
MEMBERNO                       NUMBER(10)  NULL ,
surveyitemno                   NUMBER(8)  NULL ,
rdate                          DATE  NOT NULL,
  FOREIGN KEY (surveyitemno) REFERENCES surveyitem (surveyitemno),
  FOREIGN KEY (surveyno) REFERENCES survey (surveyno),
  FOREIGN KEY (MEMBERNO) REFERENCES member (MEMBERNO)
);

COMMENT ON TABLE msurvey is '설문 참여';
COMMENT ON COLUMN msurvey.mserveyno is '설문 참여 번호';
COMMENT ON COLUMN msurvey.surveyno is '설문 제목 번호';
COMMENT ON COLUMN msurvey.MEMBERNO is '회원 번호';
COMMENT ON COLUMN msurvey.surveyitemno is '설문 항목 번호';
COMMENT ON COLUMN msurvey.rdate is '참여날짜';

DROP SEQUENCE msurvey_seq;
CREATE SEQUENCE msurvey_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999999 --> NUMBER(8) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지

1. 등록

INSERT INTO msurvey(msurveyno, surveyno, MEMBERNO, surveyitemno, rdate)
VALUES (msurvey_seq.nextval, 1, 1, 1, sysdate);

COMMIT;
 
2. 목록
- 검색을 하지 않는 경우, 전체 목록 출력
 
SELECT msurveyno, surveyno, MEMBERNO, surveyitemno, rdate
FROM msurvey
ORDER BY rdate ASC;
     
     
3. 조회
 
1) 주제 1번 보기
SELECT msurveyno, surveyno, MEMBERNO, surveyitemno, rdate
FROM msurvey
WHERE surveyno = 1;
 
    
4. 수정
UPDATE msurvey
SET msurveyno='1', surveyno='1', MEMBERNO='1', surveyitemno='1', rdate=sysdate
WHERE msurveyno=1;

COMMIT;

 
5. 삭제
1) 모두 삭제
DELETE FROM msurvey;
 
2) 특정 설문 삭제
DELETE FROM msurvey
WHERE msurveyno=1;

COMMIT;

5. 레코드 갯수
SELECT COUNT(*) as cnt FROM msurvey;

6. 검색 목록(구현 권장)
SELECT msurveyno, surveyno, MEMBERNO, surveyitemno, rdate
FROM msurvey
WHERE surveyno LIKE '1'
ORDER BY rdate ASC;

7. -- 검색 + 페이징 목록(구현 권장)
-- 검색, 정렬 -> rownum -> 분할
SELECT msurveyno, surveyno, MEMBERNO, surveyitemno, rdate, r
FROM(
     SELECT msurveyno, surveyno, MEMBERNO, surveyitemno, rdate, rownum as r
     FROM (
          SELECT msurveyno, surveyno, MEMBERNO, surveyitemno, rdate
          FROM msurvey
          WHERE surveyno LIKE '%1%'
          ORDER BY rdate ASC
     )  
)
WHERE r >= 1 AND r <= 2;

