/**********************************/
/* Table Name: 설문 제목 */
/**********************************/
CREATE TABLE survey(
		surveyno                      		NUMBER(8)		 NOT NULL		 PRIMARY KEY,
		topic                         		VARCHAR2(100)		 NOT NULL,
		yn                            		VARCHAR2(1)		 DEFAULT 'N'		 NOT NULL,
		rdate                         		DATE		 NOT NULL
);

COMMENT ON TABLE survey is '설문 제목';
COMMENT ON COLUMN survey.surveyno is '설문 제목 번호';
COMMENT ON COLUMN survey.topic is '제목';
COMMENT ON COLUMN survey.yn is '진행 여부';
COMMENT ON COLUMN survey.rdate is '등록일';

DROP SEQUENCE survey_seq;
CREATE SEQUENCE survey_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999999 --> NUMBER(8) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지
 
 
1. 등록 
INSERT INTO survey(surveyno, topic, yn, rdate)
VALUES (survey_seq.nextval, '주제1', 'Y', sysdate);

INSERT INTO survey(surveyno, topic, yn, rdate)
VALUES (survey_seq.nextval, '주제2', 'Y', sysdate);

COMMIT;
 
2. 목록
- 검색을 하지 않는 경우, 전체 목록 출력
 
SELECT surveyno, topic, yn, rdate
FROM survey
ORDER BY rdate ASC;
     
     
3. 조회
 
1) 주제 2번 보기
SELECT surveyno, topic, yn, rdate
FROM survey
WHERE topic = '월요일';
 
    
4. 수정
UPDATE survey
SET topic='하이3', yn='N'
WHERE surveyno=8;

COMMIT;

 
5. 삭제
1) 모두 삭제
DELETE FROM survey;
 
2) 특정 설문 삭제
DELETE FROM survey
WHERE surveyno=8;

COMMIT;

5. 레코드 갯수
SELECT COUNT(*) as cnt FROM survey;

6. 검색 목록(구현 권장)
SELECT surveyno, topic, yn, rdate
FROM survey
WHERE topic LIKE '%주제1%'
ORDER BY sysdate ASC;

7. -- 검색 + 페이징 목록(구현 권장)
-- 검색, 정렬 -> rownum -> 분할
SELECT surveyno, topic, yn, rdate, r
FROM(
     SELECT surveyno, topic, yn, rdate, rownum as r
     FROM (
          SELECT surveyno, topic, yn, rdate
          FROM survey
          WHERE topic LIKE '%주제1%'
          ORDER BY rdate ASC
     )  
)
WHERE r >= 1 AND r <= 2;