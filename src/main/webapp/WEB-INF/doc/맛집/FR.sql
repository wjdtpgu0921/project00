/**********************************/
/* Table Name: 맛집 */
/**********************************/
DROP TABLE frcontents CASCADE CONSTRAINTS;
DROP TABLE frcontents;

CREATE TABLE frcontents(
        frno                                  NUMBER(10)         NOT NULL         PRIMARY KEY,
        cateno                                NUMBER(10)     NOT NULL , -- FK
        memberno                              NUMBER(10)         NOT NULL , -- FK
        fr_name                               VARCHAR2(60)         NOT NULL,
        fr_content                            VARCHAR2(3000)                  NOT NULL,
        fr_addres                             VARCHAR2(200)         DEFAULT 0         NOT NULL,
        fr_map                                VARCHAR2(1000)            NULL,
        fr_word                               VARCHAR2(100)         NULL ,
        fr_rdate                              DATE               NOT NULL,
        fr_udate                              DATE                NULL,
        review_cnt                            NUMBER(10)      DEFAULT 0 NULL,
        price                                 VARCHAR2(50)      NOT NULL,
        file1                                 VARCHAR(100)          NULL,  -- 원본 파일명 image
        file1saved                            VARCHAR(100)          NULL,  -- 저장된 파일명, image
        thumb1                                VARCHAR(100)          NULL,   -- preview image
        size1                                 NUMBER(10)      DEFAULT 0 NULL,
        ratings                                NUMBER(3, 2)         DEFAULT 0         NULL, 
        FOREIGN KEY (cateno) REFERENCES fcate (cateno),
        FOREIGN KEY (memberno) REFERENCES member (memberno)
        
);

COMMENT ON TABLE frcontents is '맛집';
COMMENT ON COLUMN frcontents.frno is '맛집번호';
COMMENT ON COLUMN frcontents.cateno is '카테고리 번호';
COMMENT ON COLUMN frcontents.memberno is '회원 번호';
COMMENT ON COLUMN frcontents.fr_name is '맛집 이름';
COMMENT ON COLUMN frcontents.fr_content is '맛집 설명';
COMMENT ON COLUMN frcontents.fr_addres is '맛집 주소';
COMMENT ON COLUMN frcontents.fr_map is '맛집 지도';
COMMENT ON COLUMN frcontents.fr_word is '검색어';
COMMENT ON COLUMN frcontents.fr_rdate is '등록일';
COMMENT ON COLUMN frcontents.fr_udate is '수정일';
COMMENT ON COLUMN frcontents.review_cnt is '리뷰수';
COMMENT ON COLUMN frcontents.price is '가격';
COMMENT ON COLUMN frcontents.file1 is '메인 이미지';
COMMENT ON COLUMN frcontents.file1saved is '실제 저장된 메인 이미지';
COMMENT ON COLUMN frcontents.thumb1 is '메인 이미지 Preview';
COMMENT ON COLUMN frcontents.size1 is '메인 이미지 크기';
COMMENT ON COLUMN frcontents.ratings is '평점';

DROP SEQUENCE frcontents_seq;

CREATE SEQUENCE frcontents_seq
  START WITH 1                -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2                        -- 2번은 메모리에서만 계산
  NOCYCLE;                      -- 다시 1부터 생성되는 것을 방지

-- 등록: 1건 이상, adminno, noticecateno 컬럼에 등록되어 있는 값만 사용 가능
INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
                   price, file1, file1saved, thumb1, size1)
VALUES (frcontents_seq.nextval, 1, 1, 
        '플레이버즈', '호텔 해산물', '서울 서울특별시 서초구 신반포로 176 JW 메리어트 호텔 서울 2층', sysdate, '해산물',
        '10000원 이상', 'file1.jpg', 'file1saved.jpg', 'thumb1.jpg', 1000);

INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
<<<<<<< HEAD
                   price, file1, file1saved, thumb1, size1, favorites)
VALUES (frcontents_seq.nextval, 4, 1, 
=======
                   price, file1, file1saved, thumb1, size1)
VALUES (frcontents_seq.nextval, 2, 1, 
>>>>>>> 84e7311d7a4734885c61ec14f8a772cd6819ff6e
        '클레오', '지중해 요리', '서울 서울시 용산구 장문로 23 몬드리안 서울 이태원 1층 클레오', sysdate, '지중해',
        '10000원 이하', 'file1.jpg', 'file1saved.jpg', 'thumb1.jpg', 1000);

commit;

-- 전체 목록
SELECT frno, cateno, memberno,
       fr_name, fr_content, fr_addres, fr_map,fr_word, fr_rdate, fr_udate, review_cnt,
       price, file1, file1saved, thumb1, size1, ratings
FROM frcontents
ORDER BY frno ASC;

-- 조회

-- 조회
-- ----------------------------------------------------------------------------
SELECT frno, cateno, memberno,
       fr_name, fr_content, fr_addres, fr_map,fr_word, fr_rdate, fr_udate, review_cnt,
       price, file1, file1saved, thumb1, size1, ratings
FROM frcontents
WHERE frno = 14;

-- 카테고리별 목록
SELECT frno, cateno, memberno,
       fr_name, fr_content, fr_addres, fr_map,fr_word, fr_rdate, fr_udate, review_cnt,
       price, file1, file1saved, thumb1, size1
FROM frcontents
WHERE frno=5
 ORDER BY frno ASC;

-- 글 수정
UPDATE frcontents
SET fr_name='플레이버즈 2', fr_content='고기', fr_addres='경기도 화성', fr_word='고기00', fr_udate=sysdate, price='5000'
WHERE frno=2;

-- 파일 수정
UPDATE frcontents
SET file1='food.jpg', file1saved='food_1.jpg', thumb1='food_1_t.jpg', size1=5000
WHERE frno=2 and cateno=2

-- 즐겨찾기 수정
UPDATE frcontents
SET favorites='1'
WHERE frno=2;

commit;
-- 삭제
DELETE FROM frcontents
WHERE frno=11 and cateno=5;

-- 레코드 갯수
SELECT COUNT(*) as cnt FROM frcontents;

-- MAP 등록/수정
UPDATE frcontents SET fr_map='카페산 지도 스크립트' WHERE frno=5;

-- MAP 삭제
UPDATE frcontents SET fr_map='' WHERE frno=5;

-- 리뷰수 증가: review에서 구현 안됨
-- 사용: review 에서 리뷰 추가 또는 삭제시 ContentsProc.java class 를 호출하여 이용
UPDATE frcontents
SET review_cnt = review_cnt+1
WHERE frno=6

-- 리뷰수 감소
UPDATE frcontents
SET review_cnt = review_cnt-1
WHERE frno=6

-- *************** FK 자식 테이블일 경우 구현 시작 ***************
-- FK 컬럼 기준 카운트, 특정 그룹에 속한 레코드 갯수 산출
-- 1번 관리자가 등록한 공지사항 갯수는?
SELECT COUNT(*) as cnt FROM frcontents WHERE memberno=1;

-- 1번 공지사항 카테고리의 공지사항 등록 갯수는?
SELECT COUNT(*) as cnt FROM frcontents WHERE cateno=2;

-- FK 컬럼 기준 삭제, 특정 그룹에 속한 레코드 모두 삭제
-- 1번 관리자가 등록한 공지사항 삭제
DELETE FROM frcontents WHERE memberno=1;

-- 1번 공지사항 카테고리의 공지사항 삭제
DELETE FROM frcontents WHERE cateno=2;

-- *************** FK 자식 테이블일 경우 구현 종료 ***************

-- 검색 목록(구현 권장)
SELECT frno, cateno, memberno,
       fr_name, fr_content, fr_addres, fr_map,fr_word, fr_rdate, fr_udate, review_cnt,
       price, file1, file1saved, thumb1, size1
FROM frcontents
WHERE fr_name Like '%가게%' or fr_word Like'%고기%'
ORDER BY cateno DESC;

-- 검색 + 페이징 목록(구현 권장)
-- 검색, 정렬 -> rownum -> 분할

SELECT frno, cateno, memberno,
       fr_name, fr_content, fr_addres, fr_map,fr_word, fr_rdate, fr_udate, review_cnt,
       price, file1, file1saved, thumb1, size1
FROM(
     SELECT frno, cateno, memberno,
       fr_name, fr_content, fr_addres, fr_map,fr_word, fr_rdate, fr_udate, review_cnt,
       price, file1, file1saved, thumb1, size1, rownum as r
     FROM (
          SELECT frno, cateno, memberno,
                 fr_name, fr_content, fr_addres, fr_map,fr_word, fr_rdate, fr_udate, review_cnt,
                 price, file1, file1saved, thumb1, size1
          FROM frcontents
          WHERE (UPPER (fr_name) LIKE '%' || '' || '%' 
                                                OR UPPER(fr_content) LIKE '%' || '' || '%' 
                                              OR UPPER(fr_word) LIKE '%' || '' || '%')
          ORDER BY frno ASC
     )  
)
WHERE r >= 1 AND r <= 30;

		SELECT c.name,
		          t.frno, t.cateno, t.memberno,
                 t.fr_name, t.fr_content, t.fr_addres, t.fr_map,fr_word, t.fr_rdate, t.fr_udate, t.review_cnt,
                 t.price, t.file1, t.file1saved, t.thumb1, t.size1
		FROM cate c, frcontents t
		WHERE c.cateno = t.cateno
		ORDER BY t.frno DESC



--  <!-- 카테고리별 검색 레코드 갯수 -->
--  <select id="search_count" resultType="int" parameterType="HashMap">
SELECT COUNT(*) as cnt
 FROM frcontents;
--    <choose>
--      <when test="word == null or word == ''"> <!-- 검색하지 않는 경우의 레코드 갯수 -->
--        WHERE cateno=1
--      </when>
--      <otherwise> <!-- 검색하는 경우의 레코드 갯수 -->
--        WHERE cateno=1 AND (UPPER FR_NAME LIKE '%' || fr_word || '%' 
--                                                  OR UPPER(content) LIKE '%' || fr_word || '%' 
--                                                  OR UPPER(word) LIKE '%' || fr_word || '%')


--- 삭제
DELETE FROM frcontents
WHERE frno=1;

-- 지도
UPDATE frcontents 
SET fr_map='지도'
WHERE frno=1;
    
    
    
-- 레코드 수

    SELECT COUNT(*) as cnt
    FROM frcontents
    WHERE cateno=1;
    

-- -----------------------------------------------------------------------------
-- 추천 시스템 관련 시작
-- -----------------------------------------------------------------------------
INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
                   price, file1, file1saved, thumb1, size1, favorites)
VALUES (frcontents_seq.nextval, 1, 1, 
        '플레이버즈', '호텔 해산물', '서울 서울특별시 서초구 신반포로 176 JW 메리어트 호텔 서울 2층', sysdate, '해산물',
        '10000원 이상', 'file1.jpg', 'file1saved.jpg', 'thumb1.jpg', 1000, 1);

INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
                   price, file1, file1saved, thumb1, size1, favorites)
VALUES (frcontents_seq.nextval, 1, 1, 
        '플레이버즈', '호텔 해산물', '서울 서울특별시 서초구 신반포로 176 JW 메리어트 호텔 서울 2층', sysdate, '해산물',
        '10000원 이상', 'file1.jpg', 'file1saved.jpg', 'thumb1.jpg', 1000, 1);

-- & 입력: SET DEFINE OFF

SET DEFINE OFF
INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
                   price, file1, file1saved, thumb1, size1)
VALUES (frcontents_seq.nextval, 1, 1, 
        '호반', '호반', '서울 서울특별시 ', sysdate, '음식',
        '10000원 이상', '1.jpg', '1.jpg', '1.jpg', 1000);

INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
                   price, file1, file1saved, thumb1, size1)
VALUES (frcontents_seq.nextval, 1, 1, 
        '맛짱조개', '맛짱조개', '서울 서울특별시 ', sysdate, '음식',
        '10000원 이상', '2.jpg', '2.jpg', '2.jpg', 1000);

INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
                   price, file1, file1saved, thumb1, size1)
VALUES (frcontents_seq.nextval, 1, 1, 
        '모던샤브하우스', '모던샤브하우스', '서울 서울특별시 ', sysdate, '음식',
        '10000원 이상', '3.jpg', '3.jpg', '3.jpg', 1000);
    
INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
                   price, file1, file1saved, thumb1, size1)
VALUES (frcontents_seq.nextval, 1, 1, 
        '미영이네식당', '미영이네식당', '서울 서울특별시 ', sysdate, '음식',
        '10000원 이상', '4.jpg', '4.jpg', '4.jpg', 1000);

INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
                   price, file1, file1saved, thumb1, size1)
VALUES (frcontents_seq.nextval, 1, 1, 
        '진미평양냉면', '진미평양냉면', '서울 서울특별시 ', sysdate, '음식',
        '10000원 이상', '5.jpg', '5.jpg', '5.jpg', 1000);

INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
                   price, file1, file1saved, thumb1, size1)
VALUES (frcontents_seq.nextval, 1, 1, 
        '꿉당', '꿉당', '서울 서울특별시 ', sysdate, '음식',
        '10000원 이상', '6.jpg', '6.jpg', '6.jpg', 1000);

INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
                   price, file1, file1saved, thumb1, size1)
VALUES (frcontents_seq.nextval, 2, 1, 
        '페리지', '페리지', '서울 서울특별시 ', sysdate, '음식',
        '10000원 이상', '7.jpg', '7.jpg', '7.jpg', 1000);
        
INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
                   price, file1, file1saved, thumb1, size1)
VALUES (frcontents_seq.nextval, 2, 1, 
        '치즈플로', '치즈플로', '서울 서울특별시 ', sysdate, '음식',
        '10000원 이상', '8.jpg', '8.jpg', '8.jpg', 1000);
    
INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
                   price, file1, file1saved, thumb1, size1)
VALUES (frcontents_seq.nextval, 2, 1, 
        '메종조', '메종조', '서울 서울특별시 ', sysdate, '음식',
        '10000원 이상', '9.jpg', '9.jpg', '9.jpg', 1000);

INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
                   price, file1, file1saved, thumb1, size1)
VALUES (frcontents_seq.nextval, 2, 1, 
        '디핀옥수', '디핀옥수', '서울 서울특별시 ', sysdate, '음식',
        '10000원 이상', '10.jpg', '10.jpg', '10.jpg', 1000);
        
INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
                   price, file1, file1saved, thumb1, size1)
VALUES (frcontents_seq.nextval, 2, 1, 
        '노아', '노아', '서울 서울특별시 ', sysdate, '음식',
        '10000원 이상', '11.jpg', '11.jpg', '11.jpg', 1000);
        
INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
                   price, file1, file1saved, thumb1, size1)
VALUES (frcontents_seq.nextval, 2, 1, 
        '쿳사', '쿳사', '서울 서울특별시 ', sysdate, '음식',
        '10000원 이상', '12.jpg', '12.jpg', '12.jpg', 1000);
        
INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
                   price, file1, file1saved, thumb1, size1)
VALUES (frcontents_seq.nextval, 2, 1, 
        '알라프리마', '알라프리마', '서울 서울특별시 ', sysdate, '음식',
        '10000원 이상', '13.jpg', '13.jpg', '13.jpg', 1000);
        
INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
                   price, file1, file1saved, thumb1, size1)
VALUES (frcontents_seq.nextval, 3, 1, 
        '우육면관', '우육면관', '서울 서울특별시 ', sysdate, '음식',
        '10000원 이상', '14.jpg', '14.jpg', '14.jpg', 1000);
        
INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
                   price, file1, file1saved, thumb1, size1)
VALUES (frcontents_seq.nextval, 3, 1, 
        '팔레드신', '팔레드신', '서울 서울특별시 ', sysdate, '음식',
        '10000원 이상', '15.jpg', '15.jpg', '15.jpg', 1000);
        
INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
                   price, file1, file1saved, thumb1, size1)
VALUES (frcontents_seq.nextval, 3, 1, 
        'Sogak', 'Sogak', '서울 서울특별시 ', sysdate, '음식',
        '10000원 이상', '16.jpg', '16.jpg', '16.jpg', 1000);

INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
                   price, file1, file1saved, thumb1, size1)
VALUES (frcontents_seq.nextval, 3, 1, 
        '화양연가', '화양연가', '서울 서울특별시 ', sysdate, '음식',
        '10000원 이상', '17.jpg', '17.jpg', '17.jpg', 1000);
        
INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
                   price, file1, file1saved, thumb1, size1)
VALUES (frcontents_seq.nextval, 3, 1, 
        '모트', '모트', '서울 서울특별시 ', sysdate, '음식',
        '10000원 이상', '18.jpg', '18.jpg', '18.jpg', 1000);
        
INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
                   price, file1, file1saved, thumb1, size1)
VALUES (frcontents_seq.nextval, 3, 1, 
        '지우관', '지우관', '서울 서울특별시 ', sysdate, '음식',
        '10000원 이상', '19.jpg', '19.jpg', '19.jpg', 1000);
        
INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
                   price, file1, file1saved, thumb1, size1)
VALUES (frcontents_seq.nextval, 3, 1, 
        '쥬에', '쥬에', '서울 서울특별시 ', sysdate, '음식',
        '10000원 이상', '20.jpg', '20.jpg', '20.jpg', 1000);
        
INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
                   price, file1, file1saved, thumb1, size1)
VALUES (frcontents_seq.nextval, 4, 1, 
        '미라이', '미라이', '서울 서울특별시 ', sysdate, '음식',
        '10000원 이상', '21.jpg', '21.jpg', '21.jpg', 1000);
        
INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
                   price, file1, file1saved, thumb1, size1)
VALUES (frcontents_seq.nextval, 4, 1, 
        '시라카와', '시라카와', '서울 서울특별시 ', sysdate, '음식',
        '10000원 이상', '22.jpg', '22.jpg', '22.jpg', 1000);
        
INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
                   price, file1, file1saved, thumb1, size1)
VALUES (frcontents_seq.nextval, 4, 1, 
        '카와카츠', '카와카츠', '서울 서울특별시 ', sysdate, '음식',
        '10000원 이상', '23.jpg', '23.jpg', '23.jpg', 1000);
        
INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
                   price, file1, file1saved, thumb1, size1)
VALUES (frcontents_seq.nextval, 4, 1, 
        '야키토리나루토', '야키토리나루토', '서울 서울특별시 ', sysdate, '음식',
        '10000원 이상', '24.jpg', '24.jpg', '24.jpg', 1000);
        
INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
                   price, file1, file1saved, thumb1, size1)
VALUES (frcontents_seq.nextval, 4, 1, 
        '스시카나에', '스시카나에', '서울 서울특별시 ', sysdate, '음식',
        '10000원 이상', '25.jpg', '25.jpg', '25.jpg', 1000);
        
INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
                   price, file1, file1saved, thumb1, size1)
VALUES (frcontents_seq.nextval, 4, 1, 
        '스시아라타', '스시아라타', '서울 서울특별시 ', sysdate, '음식',
        '10000원 이상', '26.jpg', '26.jpg', '26.jpg', 1000);
        
INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
                   price, file1, file1saved, thumb1, size1)
VALUES (frcontents_seq.nextval, 4, 1, 
        '마루심', '마루심', '서울 서울특별시 ', sysdate, '음식',
        '10000원 이상', '27.jpg', '27.jpg', '27.jpg', 1000);
        
INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
                   price, file1, file1saved, thumb1, size1)
VALUES (frcontents_seq.nextval, 5, 1, 
        '팜티진쌀국수', '팜티진쌀국수', '서울 서울특별시 ', sysdate, '음식',
        '10000원 이상', '28.jpg', '28.jpg', '28.jpg', 1000);
        
INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
                   price, file1, file1saved, thumb1, size1)
VALUES (frcontents_seq.nextval, 5, 1, 
        '비엣꽌', '비엣꽌', '서울 서울특별시 ', sysdate, '음식',
        '10000원 이상', '29.jpg', '29.jpg', '29.jpg', 1000);
        
INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
                   price, file1, file1saved, thumb1, size1)
VALUES (frcontents_seq.nextval, 5, 1, 
        '사이공마켓(숙대점)', '사이공마켓(숙대점)', '서울 서울특별시 ', sysdate, '음식',
        '10000원 이상', '30.jpg', '30.jpg', '30.jpg', 1000);
        
INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
                   price, file1, file1saved, thumb1, size1)
VALUES (frcontents_seq.nextval, 5, 1, 
        '몬비엣', '몬비엣', '서울 서울특별시 ', sysdate, '음식',
        '10000원 이상', '31.jpg', '31.jpg', '31.jpg', 1000);
        
INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
                   price, file1, file1saved, thumb1, size1)
VALUES (frcontents_seq.nextval, 5, 1, 
        '르번미', '르번미', '서울 서울특별시 ', sysdate, '음식',
        '10000원 이상', '32.jpg', '32.jpg', '32.jpg', 1000);
        
INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
                   price, file1, file1saved, thumb1, size1)
VALUES (frcontents_seq.nextval, 5, 1, 
        '반포식스', '반포식스', '서울 서울특별시 ', sysdate, '음식',
        '10000원 이상', '33.jpg', '33.jpg', '33.jpg', 1000);
        
INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
                   price, file1, file1saved, thumb1, size1)
VALUES (frcontents_seq.nextval, 6, 1, 
        '툭툭누들타이', '툭툭누들타이', '서울 서울특별시 ', sysdate, '음식',
        '10000원 이상', '34.jpg', '34.jpg', '34.jpg', 1000);
        
INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
                   price, file1, file1saved, thumb1, size1)
VALUES (frcontents_seq.nextval, 6, 1, 
        '왕타이', '왕타이', '서울 서울특별시 ', sysdate, '음식',
        '10000원 이상', '35.jpg', '35.jpg', '35.jpg', 1000);
        
INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
                   price, file1, file1saved, thumb1, size1)
VALUES (frcontents_seq.nextval, 6, 1, 
        '방콕익스프레스(신촌점)', '방콕익스프레스(신촌점)', '서울 서울특별시 ', sysdate, '음식',
        '10000원 이상', '36.jpg', '36.jpg', '36.jpg', 1000);
        
INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
                   price, file1, file1saved, thumb1, size1)
VALUES (frcontents_seq.nextval, 6, 1, 
        '반타이', '반타이', '서울 서울특별시 ', sysdate, '음식',
        '10000원 이상', '37.jpg', '37.jpg', '37.jpg', 1000);
        
INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
                   price, file1, file1saved, thumb1, size1)
VALUES (frcontents_seq.nextval, 6, 1, 
        '팔람까오', '팔람까오', '서울 서울특별시 ', sysdate, '음식',
        '10000원 이상', '38.jpg', '38.jpg', '38.jpg', 1000);
        
INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
                   price, file1, file1saved, thumb1, size1)
VALUES (frcontents_seq.nextval, 6, 1, 
        '부다스벨리', '부다스벨리', '서울 서울특별시 ', sysdate, '음식',
        '10000원 이상', '39.jpg', '39.jpg', '39.jpg', 1000);
        
INSERT INTO frcontents(frno, cateno, memberno,
                   fr_name, fr_content, fr_addres, fr_rdate,fr_word,
                   price, file1, file1saved, thumb1, size1)
VALUES (frcontents_seq.nextval, 6, 1, 
        '타이가든', '타이가든', '서울 서울특별시 ', sysdate, '음식',
        '10000원 이상', '40.jpg', '40.jpg', '40.jpg', 1000);
        
-- 유형 1 전체 목록
SELECT frno, cateno, memberno,
       fr_name, fr_content, fr_addres, fr_map,fr_word, fr_rdate, fr_udate, review_cnt,
       price, file1, file1saved, thumb1, size1
FROM frcontents
ORDER BY frno ASC;

commit;

-- 추천 상품 목록 읽기
SELECT frno, cateno, memberno,
       fr_name, fr_content, fr_addres, fr_map,fr_word, fr_rdate, fr_udate, review_cnt,
       price, file1, file1saved, thumb1, size1, favorites
FROM frcontents
WHERE frno IN (3, 5, 10, 30, 40)
ORDER BY frno ASC;

-- -----------------------------------------------------------------------------
-- 추천 시스템 관련 종료
-- -----------------------------------------------------------------------------

----- 평점 업데이트
UPDATE frcontents
SET ratings= (SELECT AVG(rating) as rating FROM review WHERE frno=14)
WHERE frno=14;
commit;
    