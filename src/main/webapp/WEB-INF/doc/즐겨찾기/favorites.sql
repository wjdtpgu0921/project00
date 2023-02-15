/**********************************/
/**********************************/


CREATE TABLE favorites(
        frno                              NUMBER(10)     NOT NULL   PRIMARY KEY,
        memberno                                NUMBER(10)         NOT NULL , 
  FOREIGN KEY (frno) REFERENCES frcontents (frno),
  FOREIGN KEY (memberno) REFERENCES member (memberno)
);

COMMENT ON COLUMN review.frno is '맛집 번호';
COMMENT ON COLUMN review.memberno is '회원 번호';


DROP SEQUENCE favorites_seq;

CREATE SEQUENCE favorites_seq
  START WITH 1                -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2                        -- 2번은 메모리에서만 계산
  NOCYCLE;                      -- 다시 1부터 생성되는 것을 방지

-- 등록 화면 유형 1: 커뮤니티(공지사항, 게시판, 자료실, 갤러리,  Q/A...)글 등록
INSERT INTO favorites(frno, memberno)
VALUES(1, 3);

INSERT INTO favorites(frno, memberno)
VALUES(3, 1);

commit;

-- 맛집 리뷰 조회
SELECT frno, memberno
FROM favorites



