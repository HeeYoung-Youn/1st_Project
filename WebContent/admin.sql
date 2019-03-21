------------------------------------------------------------------
--                          관리자모드                            --
------------------------------------------------------------------
------------------------------------------------------------------
--                           회원관리                            --
------------------------------------------------------------------
-- 로그인
SELECT * FROM ADMIN WHERE AID = 'admin' AND APW = '111';
-- 로그인 이후 정보 뿌리기 위해 DTO 가져오기
SELECT * FROM ADMIN WHERE AID = 'admin';
select * from member;
-- 회원리스트
SELECT * FROM
    (SELECT ROWNUM RN, A.* FROM
    (SELECT * FROM MEMBER ORDER BY MID)A)
    WHERE RN BETWEEN 2 AND 3;

-- 전체 회원수
SELECT COUNT(*) FROM MEMBER;

-- 회원검색
SELECT * FROM MEMBER WHERE MID = 'aaa';
SELECT M.*, L.MGRADENAME FROM MEMBER M, LEVEL_INFO L
    WHERE M.MGRADE = L.MGRADE AND MID LIKE '%' || 'a' || '%';
SELECT ROWNUM RN, A.* FROM
    (SELECT M.*, L.MGRADENAME FROM MEMBER M, LEVEL_INFO L
    WHERE M.MGRADE = L.MGRADE AND MID LIKE '%' || 'a' || '%'
    ORDER BY MID)A;
SELECT * FROM
    (SELECT ROWNUM RN, A.* FROM
    (SELECT M.*, L.MGRADENAME FROM MEMBER M, LEVEL_INFO L
    WHERE M.MGRADE = L.MGRADE AND MID LIKE '%' || 'a' || '%'
    ORDER BY MID)A)
    WHERE RN BETWEEN 1 AND 2;
SELECT * FROM
    (SELECT ROWNUM RN, A.* FROM
    (SELECT * FROM MEMBER WHERE MID LIKE '%' || 'a' || '%'
    ORDER BY MID)A)
    WHERE RN BETWEEN 1 AND 2;

    
-- 검색된 회원 수
SELECT COUNT(*) FROM MEMBER WHERE MID LIKE '%' || 'a' || '%';

-- 블랙리스트강등
UPDATE MEMBER SET MGRADE = 0 WHERE MID = 'aaa';
UPDATE MEMBER SET MGRADE = 1 WHERE MID = 'bbb';
select * from member;
commit;
select * from review;
delete review where rnum = 11;


------------------------------------------------------------------
--                           게시물관리                           --
------------------------------------------------------------------
-- 리뷰
-- 리뷰목록(글목록)
SELECT * FROM
    (SELECT ROWNUM RN, A.* FROM
    (SELECT R.*,
    (SELECT COUNT(*) FROM R_COMMENT WHERE R.RNUM=R_COMMENT.RNUM) COMMENTCNT,
    (SELECT COUNT(*) FROM R_LIKE WHERE R.RNUM=R_LIKE.RNUM) LIKECNT, MNAME
    FROM REVIEW R, MEMBER M WHERE R.MID = M.MID ORDER BY RNUM DESC)A)
    WHERE RN BETWEEN 2 AND 3;

-- 리뷰 갯수파악(페이징에 사용)
SELECT COUNT(*) FROM REVIEW;
SELECT * FROM REVIEW;

-- 리뷰 검색(삭제 포함)
SELECT * FROM
    (SELECT ROWNUM RN, A.* FROM
    (SELECT R.*,
    (SELECT COUNT(*) FROM R_COMMENT WHERE R.RNUM=R_COMMENT.RNUM) COMMENTCNT,
    (SELECT COUNT(*) FROM R_LIKE WHERE R.RNUM=R_LIKE.RNUM) LIKECNT, MNAME
    FROM REVIEW R, MEMBER M WHERE R.MID = M.MID 
    AND RTITLE LIKE '%' || '1' || '%'ORDER BY RNUM DESC)A)
    WHERE RN BETWEEN 1 AND 2;

-- 검색된 리뷰 총 갯수(삭제 포함)
SELECT COUNT(*) FROM REVIEW WHERE RTITLE LIKE '%' || '1' || '%';

-- 리뷰 복구
UPDATE REVIEW SET RDELETE = 1 WHERE RNUM = 1;

-- QnA
-- QnA목록(글목록)
SELECT * FROM 
    (SELECT ROWNUM RN, A.* FROM
        (SELECT Q.*, M.MNAME FROM QnA Q, MEMBER M 
            WHERE Q.MID=M.MID ORDER BY QNUM DESC)A)
    WHERE RN BETWEEN 1 AND 5; -- 사용할 것
    
-- QnA 갯수파악(페이징에 사용)
SELECT COUNT(*) FROM QnA;

-- QnA 검색
SELECT * FROM
    (SELECT ROWNUM RN, A.*, MNAME FROM
    (SELECT * FROM QnA WHERE QTITLE LIKE '%' || '글3' || '%' 
    ORDER BY QGROUP DESC, QSTEP)A, MEMBER M
    WHERE A.MID = M.MID)
    WHERE RN BETWEEN 1 AND 2;
-- 검색된 QnA 총 갯수
SELECT COUNT(*) FROM QnA WHERE QTITLE LIKE '%' || '3' || '%';

-- QnA 복구
UPDATE QnA SET QDELETE = 1 WHERE QNUM = 1;

-- 공지사항 목록(글목록)
SELECT * FROM
    (SELECT ROWNUM RN, A.* FROM
    (SELECT N.*, ANAME, 
    (SELECT COUNT(*) FROM N_COMMENT WHERE N.NNUM=N_COMMENT.NNUM) COMMENTCNT
    FROM NOTICE N, ADMIN A WHERE N.AID = A.AID ORDER BY NNUM DESC)A)
    WHERE RN BETWEEN 2 AND 3;

-- 공지사항 갯수파악(페이징에 사용)
SELECT COUNT(*) FROM NOTICE;

-- 공지사항 검색 목록
SELECT * FROM
    (SELECT ROWNUM RN, A.* FROM
    (SELECT N.*, ANAME, 
    (SELECT COUNT(*) FROM N_COMMENT WHERE N.NNUM=N_COMMENT.NNUM) COMMENTCNT
    FROM NOTICE N, ADMIN A WHERE N.AID = A.AID 
    AND NTITLE LIKE '%' || '제목2' || '%'
    ORDER BY NNUM DESC)A)
    WHERE RN BETWEEN 1 AND 3;

-- 검색된 공지사항 총 갯수
SELECT COUNT(*) FROM NOTICE WHERE NTITLE LIKE '%' || '제목2' || '%';

-- 공지사항 복구
UPDATE NOTICE SET NDELETE=1 WHERE NNUM = 1;

------------------------------------------------------------------
--                            공지사항                           --
------------------------------------------------------------------
--★★★★★★★★★★★★★★★★★전체목록★★★★★★★★★★★★★★★★★--
-- 공지사항 목록
SELECT * FROM 
    (SELECT ROWNUM RN, A.* 
    FROM (SELECT N.*, 
    (SELECT COUNT(*) FROM N_COMMENT WHERE N.NNUM=N_COMMENT.NNUM) COMMENTCNT
    FROM NOTICE N WHERE NDELETE = 1 ORDER BY NNUM DESC)A) 
    WHERE RN BETWEEN 2 AND 3; -- 사용할 것
-- 공지사항 갯수
SELECT COUNT(*) FROM NOTICE WHERE NDELETE = 1;

--★★★★★★★★★★★★★★★★★글작성★★★★★★★★★★★★★★★★★--
INSERT INTO NOTICE (nNum, aId, nTitle, nContent, nIp)
    VALUES (NOTICE_SEQ.NEXTVAL, 'admin', '제목1', '본문1','192.168.0.151');
    
--★★★★★★★★★★★★★★★★★글수정★★★★★★★★★★★★★★★★★--
-- 수정 전 NNUM 통해 DTO 가져오기
SELECT N.*, ANAME, 
    (SELECT COUNT(*) FROM N_COMMENT WHERE N.NNUM=N_COMMENT.NNUM) COMMENTCNT
    FROM NOTICE N, ADMIN A WHERE N.AID = A.AID AND NNUM = 2;    

-- 수정
UPDATE NOTICE SET NTITLE      = '제목2 수정 후', 
                  NCONTENT    = '본문2 수정 후', 
                  NDATE       = SYSDATE, 
                  NIP         = '192.168.0.152'
            WHERE NNUM        = 2;
            
--★★★★★★★★★★★★★★★★★글삭제★★★★★★★★★★★★★★★★★--
UPDATE NOTICE SET NDELETE = 0 WHERE NNUM = 1;

--관리자 모드
--리뷰 목록(전체)
SELECT * FROM
    (SELECT ROWNUM RN, A.* FROM
    (SELECT R.*,
    (SELECT COUNT(*) FROM R_COMMENT WHERE R.RNUM=R_COMMENT.RNUM) COMMENTCNT,
    (SELECT COUNT(*) FROM R_LIKE WHERE R.RNUM=R_LIKE.RNUM) LIKECNT, MNAME
    FROM REVIEW R, MEMBER M WHERE R.MID = M.MID ORDER BY RNUM DESC)A)
    WHERE RN BETWEEN 2 AND 3;

--리뷰 목록(전체 총 갯수)
SELECT COUNT(*) FROM REVIEW;

--리뷰 검색 목록(전체)
SELECT * FROM
    (SELECT ROWNUM RN, A.* FROM
    (SELECT R.*,
    (SELECT COUNT(*) FROM R_COMMENT WHERE R.RNUM=R_COMMENT.RNUM) COMMENTCNT,
    (SELECT COUNT(*) FROM R_LIKE WHERE R.RNUM=R_LIKE.RNUM) LIKECNT, MNAME
    FROM REVIEW R, MEMBER M WHERE R.MID = M.MID 
    AND RTITLE LIKE '%' || '1' || '%'ORDER BY RNUM DESC)A)
    WHERE RN BETWEEN 1 AND 2;
--리뷰 검색 목록(전체 총 갯수)
SELECT COUNT(*) FROM REVIEW WHERE RTITLE LIKE '%' || '1' || '%';

--QnA 목록(전체)
SELECT * FROM 
    (SELECT ROWNUM RN, A.* FROM
        (SELECT Q.*, M.MNAME FROM QnA Q, MEMBER M 
            WHERE Q.MID=M.MID ORDER BY QNUM DESC)A)
    WHERE RN BETWEEN 1 AND 5;
--QnA 목록(전체 총 갯수)
SELECT COUNT(*) FROM QnA;

--QnA 검색 목록(전체)
SELECT * FROM
    (SELECT ROWNUM RN, A.*, MNAME FROM
    (SELECT * FROM QnA WHERE QTITLE LIKE '%' || '글3' || '%' 
    ORDER BY QGROUP DESC, QSTEP)A, MEMBER M
    WHERE A.MID = M.MID)
    WHERE RN BETWEEN 1 AND 2;
--QnA 검색 목록(전체 총 갯수)
SELECT COUNT(*) FROM QnA WHERE QTITLE LIKE '%' || '3' || '%';

--공지 목록(전체)
SELECT * FROM
    (SELECT ROWNUM RN, A.* FROM
    (SELECT N.*, ANAME, 
    (SELECT COUNT(*) FROM N_COMMENT WHERE N.NNUM=N_COMMENT.NNUM) COMMENTCNT
    FROM NOTICE N, ADMIN A WHERE N.AID = A.AID ORDER BY NNUM DESC)A)
    WHERE RN BETWEEN 2 AND 3;
--공지 목록(전체 총 갯수)
SELECT COUNT(*) FROM NOTICE;

--공지 검색 목록(전체)
SELECT * FROM
    (SELECT ROWNUM RN, A.* FROM
    (SELECT N.*, ANAME, 
    (SELECT COUNT(*) FROM N_COMMENT WHERE N.NNUM=N_COMMENT.NNUM) COMMENTCNT
    FROM NOTICE N, ADMIN A WHERE N.AID = A.AID 
    AND NTITLE LIKE '%' || '제목2' || '%'
    ORDER BY NNUM DESC)A)
    WHERE RN BETWEEN 1 AND 3;
--공지 검색 목록(전체 총 갯수)
SELECT COUNT(*) FROM NOTICE WHERE NTITLE LIKE '%' || '제목2' || '%';