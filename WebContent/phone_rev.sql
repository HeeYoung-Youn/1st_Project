-- 테이블 삭제
DROP TABLE R_COMMENT;
DROP TABLE R_LIKE;
DROP TABLE REVIEW;
DROP TABLE QnA;
DROP TABLE N_COMMENT;
DROP TABLE NOTICE;
DROP TABLE ADMIN;
DROP TABLE MEMBER;
DROP TABLE LEVEL_INFO;

-- 시퀀스 삭제
DROP SEQUENCE R_COMMENT_SEQ;
DROP SEQUENCE R_LIKE_SEQ;
DROP SEQUENCE REVIEW_SEQ;
DROP SEQUENCE QnA_SEQ;
DROP SEQUENCE N_COMMENT_SEQ;
DROP SEQUENCE NOTICE_SEQ;

-- 테이블 생성
------------------------------------------------------------------------
--                             MEMBER관련                              --
------------------------------------------------------------------------
CREATE TABLE LEVEL_INFO(
    mGrade     NUMBER(1)   PRIMARY KEY, -- 등급번호
    mGradeName VARCHAR(30) NOT NULL     -- 등급명
);

CREATE TABLE MEMBER(
    mId    VARCHAR2(30) PRIMARY KEY,                   -- 회원ID
    mGrade NUMBER(1)    REFERENCES LEVEL_INFO(mGrade), -- 등급번호
    mPw    VARCHAR2(30) NOT NULL,                      -- 비밀번호
    mName  VARCHAR2(30) NOT NULL,                      -- 이름
    mEmail VARCHAR2(40),                               -- 이메일
    mBirth DATE,                                       -- 생년월일
    mJoin  NUMBER(1)    DEFAULT 1                      -- 탈퇴여부
);
------------------------------------------------------------------------
--                             REVIEW관련                               --
------------------------------------------------------------------------
CREATE SEQUENCE REVIEW_SEQ 
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 999999 
    NOCACHE 
    NOCYCLE;
CREATE TABLE REVIEW(
    rNum      NUMBER(6)       PRIMARY KEY,            -- 글 번호
    mId       VARCHAR2(30)    REFERENCES MEMBER(mId), -- 회원ID
    rTitle    VARCHAR2(100)   NOT NULL,               -- 글 제목
    rContent  CLOB,                                   -- 글 본문
    rFileName_1 VARCHAR2(50),                         -- 파일명1
    rFileName_2 VARCHAR2(50),                         -- 파일명2
    rFileName_3 VARCHAR2(50),                         -- 파일명3
    rFileName_4 VARCHAR2(50),                         -- 파일명4
    rFileName_5 VARCHAR2(50),                         -- 파일명5
    rDate     DATE            DEFAULT SYSDATE,        -- 작성시점
    rHit      NUMBER(6)       DEFAULT 0,              -- 조회수
    rIp       VARCHAR2(20)    NOT NULL,               -- 글 작성 IP
    rDelete   NUMBER(1)       DEFAULT 1               -- 삭제여부
);

CREATE SEQUENCE R_COMMENT_SEQ 
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 999999 
    NOCACHE 
    NOCYCLE;
CREATE TABLE R_COMMENT(
    cNum     NUMBER(6)      PRIMARY KEY,            -- 댓글 번호
    rNum     NUMBER(6)      REFERENCES REVIEW(rNum), -- 글 번호
    mId      VARCHAR2(30)   REFERENCES MEMBER(mId), -- 회원ID 
    cContent VARCHAR2(1000) NOT NULL,               -- 댓글 내용 
    cDate    DATE           DEFAULT SYSDATE,        -- 댓글 작성시점
    cGroup   NUMBER(6)      NOT NULL,               -- 댓글 그룹
    cStep    NUMBER(3)      NOT NULL,               -- 댓글 그룹 내 출력순서
    cIndent  NUMBER(3)      NOT NULL,               -- 댓글 들여쓰기 정도
    cIp      VARCHAR2(20)   NOT NULL                -- 댓글 작성 IP
);

CREATE SEQUENCE R_LIKE_SEQ 
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 999999 
    NOCACHE 
    NOCYCLE;
CREATE TABLE R_LIKE(
    lNum NUMBER(6)    PRIMARY KEY,             -- 추천 번호
    rNum NUMBER(6)    REFERENCES REVIEW(rNum), -- 글 번호
    mId  VARCHAR2(30) REFERENCES MEMBER(mId)   -- 회원ID
);

CREATE SEQUENCE QnA_SEQ
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 999999 
    NOCACHE 
    NOCYCLE;
CREATE TABLE QnA(
    qNum     NUMBER(6)     PRIMARY KEY,            -- 글번호
    mId      VARCHAR2(30)  REFERENCES MEMBER(mId), -- 회원ID
    qTitle   VARCHAR2(100) NOT NULL,               -- 제목
    qContent CLOB,                                 -- 내용
    qDate    DATE          DEFAULT SYSDATE,        -- 작성시점
    qHit     NUMBER(6)     DEFAULT 0,              -- 조회수
    qGroup   NUMBER(6)     NOT NULL,               -- 글 그룹
    qStep    NUMBER(3)     NOT NULL,               -- 그룹 내 출력순서
    qIndent  NUMBER(3)     NOT NULL,               -- 들여쓰기 정도
    qIp      VARCHAR2(20)  NOT NULL,               -- 글 작성 IP
    qDelete  NUMBER(1)     DEFAULT 1               -- 삭제여부
);

------------------------------------------------------------------------
--                             ADMIN관련                               --
------------------------------------------------------------------------
CREATE TABLE ADMIN(
    aId   VARCHAR2(30) PRIMARY KEY, -- 관리자 ID
    aPw   VARCHAR2(30) NOT NULL,    -- 관리자 비밀번호
    aName VARCHAR2(30) NOT NULL     -- 관리자 이름
);

CREATE SEQUENCE NOTICE_SEQ
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 999999 
    NOCACHE 
    NOCYCLE;
CREATE TABLE NOTICE(
    nNum     NUMBER(6)    PRIMARY KEY,           -- 공지번호
    aId      VARCHAR(30)  REFERENCES ADMIN(aId), -- 관리자 ID
    nTitle   VARCHAR(100) NOT NULL,              -- 제목
    nContent CLOB,                               -- 내용
    nDate    DATE         DEFAULT SYSDATE,       -- 작성시점
    nHit     NUMBER(6)    DEFAULT 0,             -- 조회수
    nIp      VARCHAR(20)  NOT NULL,              -- IP
    nDelete  NUMBER(1)    DEFAULT 1              -- 삭제여부
);

CREATE SEQUENCE N_COMMENT_SEQ
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 999999 
    NOCACHE 
    NOCYCLE;
CREATE TABLE N_COMMENT(
    ncNum     NUMBER(6)      PRIMARY KEY,             -- 공지 댓글번호
    nNum      NUMBER(6)      REFERENCES NOTICE(nNum), -- 공지 번호
    mId       VARCHAR2(30)   REFERENCES MEMBER(mId),  -- 회원ID
    ncContent VARCHAR2(1000) NOT NULL,                -- 댓글 내용
    ncDate    DATE           DEFAULT SYSDATE,         -- 댓글 작성시점
    ncGroup   NUMBER(6)      NOT NULL,                -- 댓글 그룹
    ncStep    NUMBER(3)      NOT NULL,                -- 댓글 그룹 내 출력순서
    ncIndent  NUMBER(3)      NOT NULL,                -- 댓글 들여쓰기 정도
    ncIp      VARCHAR2(20)   NOT NULL                 -- 댓글 작성 IP
);

------------------------------------------------------------------------
--                        LEVEL_INFO 데이터 입력                        --
------------------------------------------------------------------------
INSERT INTO LEVEL_INFO VALUES (1, '일반회원');
INSERT INTO LEVEL_INFO VALUES (0, '불량회원');

------------------------------------------------------------------------
--                        MEMBER 더미 데이터 입력                        --
------------------------------------------------------------------------
INSERT INTO MEMBER (mId, mGrade, mPw, mName, mEmail, mBirth)
    VALUES ('aaa', 1, '111', '홍길동', 'tj@tj.com', '1999-01-01');
INSERT INTO MEMBER (mId, mGrade, mPw, mName, mEmail, mBirth)
    VALUES ('bbb', 1, '222', '박길동', 'tj2@tj.com', '1995-01-01');
INSERT INTO MEMBER (mId, mGrade, mPw, mName, mEmail, mBirth)
    VALUES ('ccc', 0, '333', '김길동', 'tj3@tj.com', '1997-01-01');
SELECT * FROM MEMBER;

------------------------------------------------------------------------
--                        REVIEW 더미 데이터 입력                        --
------------------------------------------------------------------------
INSERT INTO REVIEW (rNum, mId, rTitle, rContent, rFileName_1, rFileName_2, 
    rFileName_3, rFileName_4, rFileName_5, rIp)
    VALUES (REVIEW_SEQ.NEXTVAL, 'aaa', '제목1', '본문1', NULL, NULL,
    NULL, NULL, NULL, '192.168.0.151');
INSERT INTO REVIEW (rNum, mId, rTitle, rContent, rFileName_1, rFileName_2, 
    rFileName_3, rFileName_4, rFileName_5, rIp)
    VALUES (REVIEW_SEQ.NEXTVAL, 'bbb', '제목2', '본문2', NULL, NULL,
    NULL, NULL, NULL, '192.168.0.153');
INSERT INTO REVIEW (rNum, mId, rTitle, rContent, rFileName_1, rFileName_2, 
    rFileName_3, rFileName_4, rFileName_5, rIp)
    VALUES (REVIEW_SEQ.NEXTVAL, 'ccc', '제목3', '본문3', NULL, NULL,
    NULL, NULL, NULL, '192.168.0.155');
SELECT * FROM REVIEW;

------------------------------------------------------------------------
--                        R_COMMENT 더미 데이터 입력                     --
------------------------------------------------------------------------
INSERT INTO R_COMMENT (cNum, rNum, mId, cContent, 
    cGroup, cStep, cIndent, cIp)
    VALUES (R_COMMENT_SEQ.NEXTVAL, 1, 'bbb', '댓글내용1', 
    R_COMMENT_SEQ.CURRVAL, 0, 0, '192.168.12.151');
INSERT INTO R_COMMENT (cNum, rNum, mId, cContent, 
    cGroup, cStep, cIndent, cIp)
    VALUES (R_COMMENT_SEQ.NEXTVAL, 1, 'ccc', '댓글내용2', 
    R_COMMENT_SEQ.CURRVAL, 0, 0, '192.168.1.159');
INSERT INTO R_COMMENT (cNum, rNum, mId, cContent, 
    cGroup, cStep, cIndent, cIp)
    VALUES (R_COMMENT_SEQ.NEXTVAL, 1, 'bbb', '댓글내용3', 
    R_COMMENT_SEQ.CURRVAL, 0, 0, '192.168.1.155');
    
-- 댓글의 답글 처리를 위한 STEP A----------
UPDATE R_COMMENT SET CSTEP = CSTEP + 1
    WHERE CGROUP = 1 AND CSTEP > 0;
---------------------------------------
INSERT INTO R_COMMENT (cNum, rNum, mId, cContent, 
    cGroup, cStep, cIndent, cIp)
    VALUES (R_COMMENT_SEQ.NEXTVAL, 1, 'aaa', '1번 댓글의 답글1', 
    1, 1, 1, '192.168.10.153');

-- 댓글의 답글 처리를 위한 STEP A----------
UPDATE R_COMMENT SET CSTEP = CSTEP + 1
    WHERE CGROUP = 1 AND CSTEP > 0;
---------------------------------------
INSERT INTO R_COMMENT (cNum, rNum, mId, cContent, 
    cGroup, cStep, cIndent, cIp)
    VALUES (R_COMMENT_SEQ.NEXTVAL, 1, 'ccc', '1번 댓글의 답글2', 
    1, 1, 1, '192.168.10.159');
    
-- 댓글의 답글의 답글 처리를 위한 STEP A----
UPDATE R_COMMENT SET CSTEP = CSTEP + 1
    WHERE CGROUP = 1 AND CSTEP > 2;
---------------------------------------
INSERT INTO R_COMMENT (cNum, rNum, mId, cContent, 
    cGroup, cStep, cIndent, cIp)
    VALUES (R_COMMENT_SEQ.NEXTVAL, 1, 'bbb', '1번 댓글의 답글1의 답글1', 
    1, 3, 2, '192.168.10.152');
SELECT * FROM R_COMMENT ORDER BY CGROUP DESC, CSTEP;

------------------------------------------------------------------------
--                         B_LIKE 더미 데이터 입력                       --
------------------------------------------------------------------------
INSERT INTO R_LIKE (lNum, rNum, mId)
    VALUES (R_LIKE_SEQ.NEXTVAL, 1, 'aaa');
INSERT INTO R_LIKE (lNum, rNum, mId)
    VALUES (R_LIKE_SEQ.NEXTVAL, 1, 'bbb');
INSERT INTO R_LIKE (lNum, rNum, mId)
    VALUES (R_LIKE_SEQ.NEXTVAL, 1, 'ccc');

------------------------------------------------------------------------
--                           QnA 더미 데이터 입력                        --
------------------------------------------------------------------------
INSERT INTO QnA (qNum, mId, qTitle, qContent, 
    qGroup, qStep, qIndent, qIp)
    VALUES (QnA_SEQ.NEXTVAL, 'aaa', '질문글1', '내용1', 
    QnA_SEQ.CURRVAL, 0, 0, '192.168.13.151');
INSERT INTO QnA (qNum, mId, qTitle, qContent, 
    qGroup, qStep, qIndent, qIp)
    VALUES (QnA_SEQ.NEXTVAL, 'bbb', '질문글2', '내용2', 
    QnA_SEQ.CURRVAL, 0, 0, '192.168.13.151');
INSERT INTO QnA (qNum, mId, qTitle, qContent, 
    qGroup, qStep, qIndent, qIp)
    VALUES (QnA_SEQ.NEXTVAL, 'ccc', '질문글3', '내용3', 
    QnA_SEQ.CURRVAL, 0, 0, '192.168.13.151');
    
-- QnA의 답글 처리를 위한 STEP A----------
UPDATE QnA SET QSTEP = QSTEP + 1
    WHERE QGROUP = 1 AND QSTEP > 0;
---------------------------------------
INSERT INTO QnA (qNum, mId, qTitle, qContent, 
    qGroup, qStep, qIndent, qIp)
    VALUES (QnA_SEQ.NEXTVAL, 'aaa', '질문글1의 답글1', '답글1의 내용',
    1, 1, 1, '192.168.10.155');

-- QnA의 답글 처리를 위한 STEP A----------
UPDATE QnA SET QSTEP = QSTEP + 1
    WHERE QGROUP = 1 AND QSTEP > 0;
---------------------------------------
INSERT INTO QnA (qNum, mId, qTitle, qContent, 
    qGroup, qStep, qIndent, qIp)
    VALUES (QnA_SEQ.NEXTVAL, 'bbb', '질문글1의 답글2', '답글2의 내용', 
    1, 1, 1, '192.168.8.123');
    
-- 댓글의 답글의 답글 처리를 위한 STEP A----
UPDATE QnA SET QSTEP = QSTEP + 1
    WHERE QGROUP = 1 AND QSTEP > 2;
---------------------------------------
INSERT INTO QnA (qNum, mId, qTitle, qContent, 
    qGroup, qStep, qIndent, qIp)
    VALUES (QnA_SEQ.NEXTVAL, 'ccc', '질문글1의 답글1의 답글1', '답글1의 답글1의 내용', 
    1, 3, 2, '192.168.10.142');
SELECT * FROM QnA ORDER BY QGROUP DESC, QSTEP;

------------------------------------------------------------------------
--                          ADMIN 데이터 입력                           --
------------------------------------------------------------------------
INSERT INTO ADMIN VALUES ('admin', '111', '관리자');

------------------------------------------------------------------------
--                        NOTICE 더미 데이터 입력                        --
------------------------------------------------------------------------
INSERT INTO NOTICE (nNum, aId, nTitle, nContent, nIp)
    VALUES (NOTICE_SEQ.NEXTVAL, 'admin', '제목1', '본문1','192.168.0.151');
INSERT INTO NOTICE (nNum, aId, nTitle, nContent, nIp)
    VALUES (NOTICE_SEQ.NEXTVAL, 'admin', '제목2', '본문2','192.168.0.151');
INSERT INTO NOTICE (nNum, aId, nTitle, nContent, nIp)
    VALUES (NOTICE_SEQ.NEXTVAL, 'admin', '제목3', '본문3','192.168.0.151');
SELECT * FROM NOTICE;

------------------------------------------------------------------------
--                        N_COMMENT 더미 데이터 입력                     --
------------------------------------------------------------------------
INSERT INTO N_COMMENT (ncNum, nNum, mId, ncContent, 
    ncGroup, ncStep, ncIndent, ncIp)
    VALUES (N_COMMENT_SEQ.NEXTVAL, 1, 'bbb', '댓글내용1', 
    N_COMMENT_SEQ.CURRVAL, 0, 0, '192.168.12.151');
INSERT INTO N_COMMENT (ncNum, nNum, mId, ncContent, 
    ncGroup, ncStep, ncIndent, ncIp)
    VALUES (N_COMMENT_SEQ.NEXTVAL, 1, 'ccc', '댓글내용2', 
    N_COMMENT_SEQ.CURRVAL, 0, 0, '192.168.1.159');
INSERT INTO N_COMMENT (ncNum, nNum, mId, ncContent, 
    ncGroup, ncStep, ncIndent, ncIp)
    VALUES (N_COMMENT_SEQ.NEXTVAL, 1, 'bbb', '댓글내용3', 
    N_COMMENT_SEQ.CURRVAL, 0, 0, '192.168.1.155');
    
-- 댓글의 답글 처리를 위한 STEP A----------
UPDATE N_COMMENT SET NCSTEP = NCSTEP + 1
    WHERE NCGROUP = 1 AND NCSTEP > 0;
---------------------------------------
INSERT INTO N_COMMENT (ncNum, nNum, mId, ncContent, 
    ncGroup, ncStep, ncIndent, ncIp)
    VALUES (R_COMMENT_SEQ.NEXTVAL, 1, 'aaa', '1번 댓글의 답글1',
    1, 1, 1, '192.168.10.153');

-- 댓글의 답글 처리를 위한 STEP A----------
UPDATE N_COMMENT SET NCSTEP = NCSTEP + 1
    WHERE NCGROUP = 1 AND NCSTEP > 0;
---------------------------------------
INSERT INTO N_COMMENT (ncNum, nNum, mId, ncContent, 
    ncGroup, ncStep, ncIndent, ncIp)
    VALUES (N_COMMENT_SEQ.NEXTVAL, 1, 'ccc', '1번 댓글의 답글2', 
    1, 1, 1, '192.168.10.159');
    
-- 댓글의 답글의 답글 처리를 위한 STEP A----
UPDATE N_COMMENT SET NCSTEP = NCSTEP + 1
    WHERE NCGROUP = 1 AND NCSTEP > 2;
---------------------------------------
INSERT INTO N_COMMENT (ncNum, nNum, mId, ncContent, 
    ncGroup, ncStep, ncIndent, ncIp)
    VALUES (N_COMMENT_SEQ.NEXTVAL, 1, 'bbb', '1번 댓글의 답글1의 답글1', 
    1, 3, 2, '192.168.10.152');
SELECT * FROM N_COMMENT ORDER BY NCGROUP DESC, NCSTEP;

---------------------------------------------------------------------------
--               메인화면에 리뷰게시판 최근 8개 글의 DTO 가져오기               --
---------------------------------------------------------------------------
SELECT * FROM
    (SELECT ROWNUM RN, A.* FROM
    (SELECT R.*,
    (SELECT COUNT(*) FROM R_COMMENT WHERE R.RNUM=R_COMMENT.RNUM) COMMENTCNT,
    (SELECT COUNT(*) FROM R_LIKE WHERE R.RNUM=R_LIKE.RNUM) LIKECNT, MNAME
    FROM REVIEW R, MEMBER M WHERE R.MID = M.MID AND RDELETE = 1
    ORDER BY RNUM DESC)A)
    WHERE RN BETWEEN 1 AND 8;
commit;
select * from member;





