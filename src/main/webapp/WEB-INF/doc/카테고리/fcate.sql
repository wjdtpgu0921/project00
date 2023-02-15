/* Table Name: 카테고리 */
/**********************************/

DROP TABLE fcate CASCADE CONSTRAINTS;
DROP TABLE fcate;

CREATE TABLE fcate(
    cateno                            NUMBER(10)   NOT NULL    PRIMARY KEY,
    name                              VARCHAR2(30) NOT NULL,
    cnt                               NUMBER(7)  DEFAULT 0     NOT NULL,
    rdate                               DATE     NOT NULL,
    udate                             DATE     NULL,
        seqno                            NUMBER(10)   DEFAULT 0       NOT NULL,
        visible                            CHAR(1)      DEFAULT 'N'     NOT NULL -- Y, N
);

COMMENT ON TABLE fcate is '카테고리';
COMMENT ON COLUMN fcate.cateno is '카테고리번호';
COMMENT ON COLUMN fcate.name is '카테고리 이름';
COMMENT ON COLUMN fcate.cnt is '관련 자료수';
COMMENT ON COLUMN fcate.rdate is '등록일';
COMMENT ON COLUMN fcate.udate is '수정일';
COMMENT ON COLUMN fcate.seqno is '출력 순서';
COMMENT ON COLUMN fcate.visible is '출력 모드';

-- SEQUENCE
DROP SEQUENCE fcate_seq;

CREATE SEQUENCE fcate_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 999999999 --> NUMBER(10) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지
  
-- CREATE
INSERT INTO fcate(cateno, name, cnt, rdate, seqno, visible)
VALUES (fcate_seq.nextval, '한식', 0, sysdate, 1, 'Y');

INSERT INTO fcate(cateno, name, cnt, rdate, seqno, visible)
VALUES (fcate_seq.nextval, '양식', 0, sysdate, 2, 'Y');


commit;

-- SELECT 목록
-- PK 컬럼은 최초 등록시 값이 sequence에의해 고정됨.
SELECT cateno, name, cnt, rdate, udate, seqno, visible
FROM fcate
ORDER BY cateno ASC;

-- SELECT 조회
SELECT cateno, name, cnt, rdate, udate, seqno, visible
FROM fcate
WHERE cateno = 1;

-- UPDATE
-- 최초 등록 날짜 유지, 수정 날짜 추가
UPDATE cate
SET name='고전', seqno=1, udate=sysdate
WHERE cateno=1;

commit;

-- DELETE
DELETE FROM cate
WHERE cateno=5;

commit;

-- 모든 레코드 삭제
DELETE FROM cate;
commit;

-- COUNT(*)
SELECT COUNT(*) as cnt
FROM cate;

-- seqno 출력 순서 기준 목록
SELECT cateno, name, cnt, rdate, udate, seqno
FROM fcate
ORDER BY seqno ASC;

-- 출력 순서 올림(상향, 10 등 -> 1 등), seqno: 10 -> 1
UPDATE cate
SET seqno = seqno - 1
WHERE cateno = 1;

commit;

-- 출력 순서 내림(하향, 1 등 -> 10 등), seqno: 1 -> 10
UPDATE cate
SET seqno = seqno + 1
WHERE cateno = 1;

commit;

-- 출력 모드의 변경
UPDATE cate
SET visible = 'Y'
WHERE cateno=1;

SELECT * FROM cate;

UPDATE cate
SET visible = 'N'
WHERE cateno=1;

SELECT * FROM cate;

commit;

-- seqno 출력 순서 기준 목록
SELECT cateno, name, cnt, rdate, udate, seqno, visible
FROM cate
ORDER BY seqno ASC;

-- visible이 'Y'인 카테고리 출력하기
SELECT cateno, name, cnt, rdate, udate, seqno, visible
FROM cate
WHERE visible='Y'
ORDER BY seqno ASC;

-- 글수의 증가
UPDATE cate
SET cnt = cnt + 1
WHERE cateno=1;

commit;

SELECT * FROM cate;

-- 글수의 감소
UPDATE cate
SET cnt = cnt - 1
WHERE cateno=1;

commit;

SELECT * FROM cate;


