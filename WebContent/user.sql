------------------------------------------------------------------
--                          사용자모드                            --
------------------------------------------------------------------
------------------------------------------------------------------
--                           회원관리                            --
------------------------------------------------------------------
-- ID중복확인
SELECT * FROM MEMBER WHERE MID = 'aaa';
commit;
-- 가입
INSERT INTO MEMBER (mId, mGrade, mPw, mName, mEmail, mBirth)
    VALUES ('ddd', 1, '444', '홍길동', 'tj@tj.com', '1993-05-09');
    
-- 로그인
SELECT * FROM MEMBER WHERE MJOIN=1 AND MID = 'aaa' AND MPW = '123';

-- 로그인 이후 정보 뿌리기 위해 DTO 가져오기
SELECT * FROM MEMBER WHERE MID = 'aaa';

-- 회원정보 수정 전 비밀번호 맞는지 확인
SELECT * FROM MEMBER WHERE MID = 'aaa' AND MPW = '123';

-- 회원정보 수정
UPDATE MEMBER SET MPW    = '123', 
                  MNAME  = '홍길순', 
                  MEMAIL = 'tjtj@tj.com', 
                  MBIRTH = '2001-12-23'
            WHERE MID    = 'aaa';
            
-- 회원탈퇴
UPDATE MEMBER SET MJOIN=0 WHERE MID='aaa';
SELECT * FROM MEMBER;

------------------------------------------------------------------
--                          나의 게시물                           --
------------------------------------------------------------------
-- 내가 쓴 게시물(REVIEW)
SELECT COUNT(*) FROM REVIEW WHERE MID='aaa' AND RDELETE = 1;
SELECT * FROM (SELECT ROWNUM RN, A.*, MNAME FROM
    (SELECT R.*,
    (SELECT COUNT(*) FROM R_COMMENT WHERE R.RNUM=R_COMMENT.RNUM) COMMENTCNT,
    (SELECT COUNT(*) FROM R_LIKE WHERE R.RNUM=R_LIKE.RNUM) LIKECNT 
    FROM REVIEW R WHERE RDELETE = 1 AND R.MID='aaa' ORDER BY RNUM DESC)A, MEMBER
    WHERE A.MID=MEMBER.MID)
    WHERE RN BETWEEN 1 AND 3;
    
-- 내가 쓴 게시물(QnA)
SELECT * FROM 
    (SELECT ROWNUM RN, A.* FROM
        (SELECT Q.*, M.MNAME FROM QnA Q, MEMBER M 
            WHERE Q.MID=M.MID AND Q.MID='aaa' AND QDELETE = 1
            ORDER BY QGROUP DESC, QSTEP)A)
    WHERE RN BETWEEN 1 AND 5;
SELECT COUNT(*) FROM QnA WHERE MID='aaa' AND QDELETE = 1;

-- 내가 쓴 댓글(REVIEW)
SELECT * FROM
    (SELECT ROWNUM RN, A.* FROM
    (SELECT R.*, MNAME FROM R_COMMENT R, MEMBER M 
        WHERE R.MID=M.MID AND R.MID = 'aaa' 
        ORDER BY RNUM DESC, CGROUP DESC, CSTEP)A)
    WHERE RN BETWEEN 1 AND 5;
SELECT COUNT(*) FROM R_COMMENT WHERE MID='aaa';

-- 내가 쓴 댓글(NOTICE)
SELECT * FROM
    (SELECT ROWNUM RN, A.* FROM
    (SELECT N.*, MNAME FROM N_COMMENT N, MEMBER M 
        WHERE N.MID=M.MID AND N.MID = 'aaa' 
        ORDER BY NNUM DESC, NCGROUP DESC, NCSTEP)A)
    WHERE RN BETWEEN 1 AND 5;
SELECT COUNT(*) FROM N_COMMENT WHERE MID='aaa';
select * from member;   

------------------------------------------------------------------
--                          리뷰 게시판                           --
------------------------------------------------------------------
--★★★★★★★★★★★★★★★전체 글 목록★★★★★★★★★★★★★★★★--
-- 리뷰목록(글목록)
SELECT * FROM
    (SELECT ROWNUM RN, A.* FROM
    (SELECT R.*,
    (SELECT COUNT(*) FROM R_COMMENT WHERE R.RNUM=R_COMMENT.RNUM) COMMENTCNT,
    (SELECT COUNT(*) FROM R_LIKE WHERE R.RNUM=R_LIKE.RNUM) LIKECNT, MNAME
    FROM REVIEW R, MEMBER M WHERE R.MID = M.MID AND RDELETE = 1 
    ORDER BY RNUM DESC)A)
    WHERE RN BETWEEN 2 AND 3;

    
-- 리뷰 총 갯수
SELECT COUNT(*) FROM REVIEW WHERE RDELETE = 1;
    
-- 리뷰 검색
SELECT * FROM
    (SELECT ROWNUM RN, A.* FROM
    (SELECT R.*,
    (SELECT COUNT(*) FROM R_COMMENT WHERE R.RNUM=R_COMMENT.RNUM) COMMENTCNT,
    (SELECT COUNT(*) FROM R_LIKE WHERE R.RNUM=R_LIKE.RNUM) LIKECNT, MNAME
    FROM REVIEW R, MEMBER M WHERE R.MID = M.MID AND RDELETE = 1 
    AND RTITLE LIKE '%' || '1' || '%'
    ORDER BY RNUM DESC)A)
    WHERE RN BETWEEN 1 AND 2;

-- 검색된 리뷰 총 갯수
SELECT COUNT(*) FROM REVIEW WHERE RDELETE = 1 AND RTITLE LIKE '%' || '1' || '%';

-- 댓글 
SELECT COMMENTCNT FROM
    (SELECT ROWNUM RN, A.* FROM
        (SELECT R.*, (SELECT COUNT(*) FROM R_COMMENT C WHERE C.RNUM=R.RNUM) COMMENTCNT
    FROM REVIEW R WHERE RDELETE = 1 ORDER BY RNUM DESC)A)
    WHERE RN BETWEEN 1 AND 3;

-- 추천
SELECT LIKECNT FROM
    (SELECT ROWNUM RN, A.* FROM
        (SELECT R.*, (SELECT COUNT(*) FROM R_LIKE L WHERE L.RNUM=R.RNUM) LIKECNT
    FROM REVIEW R WHERE RDELETE = 1 ORDER BY RNUM DESC)A)
    WHERE RN BETWEEN 1 AND 3;
    
-- 리뷰 갯수파악(페이징에 사용)
SELECT COUNT(*) FROM REVIEW WHERE RDELETE = 1;
 
--★★★★★★★★★★★★★★★★★★글보기★★★★★★★★★★★★★★★★★--
-- 삭제되었는지 확인
SELECT * FROM REVIEW WHERE RNUM = 3 AND RDELETE = 1;

-- 조회수 올리기
UPDATE REVIEW SET RHIT = RHIT + 1 WHERE RNUM = 3;

-- 본문
SELECT R.*,
    (SELECT COUNT(*) FROM R_COMMENT WHERE R.RNUM=R_COMMENT.RNUM) COMMENTCNT,
    (SELECT COUNT(*) FROM R_LIKE WHERE R.RNUM=R_LIKE.RNUM) LIKECNT, MNAME
    FROM REVIEW R, MEMBER M WHERE R.MID = M.MID AND RNUM = 6;
    
-- 추천
SELECT COUNT(*) FROM R_LIKE WHERE RNUM = 3;

-- 댓글
SELECT R.*, MNAME FROM R_COMMENT R, MEMBER M 
    WHERE R.MID = M.MID AND  RNUM = 1 
    ORDER BY CGROUP DESC, CSTEP;
    
SELECT ROWNUM RN, A.CNUM, A.MID, A.CCONTENT, A.CDATE, A.CGROUP, 
    A.CSTEP, A.CINDENT, A.CIP FROM
    (SELECT R.*, MNAME FROM R_COMMENT R, MEMBER M 
    WHERE R.MID = M.MID AND  RNUM = 1 
    ORDER BY CGROUP DESC, CSTEP)A; -- 질문내용
    
SELECT * FROM 
    (SELECT ROWNUM RN, A.CNUM, A.RNUM, A.MID, A.CCONTENT, A.CDATE, A.CGROUP, 
    A.CSTEP, A.CINDENT, A.CIP, A.MNAME FROM
    (SELECT R.*, MNAME FROM R_COMMENT R, MEMBER M 
    WHERE R.MID = M.MID AND  RNUM = 1 
    ORDER BY CGROUP DESC, CSTEP)A)
    WHERE RN BETWEEN 11 AND 20; -- 사용할 것
    
SELECT * FROM R_COMMENT;

-- 댓글갯수
SELECT COUNT(*) FROM R_COMMENT WHERE RNUM = 1;

--★★★★★★★★★★★★★★★★★댓글★★★★★★★★★★★★★★★★★--
-- 댓글쓰기
INSERT INTO R_COMMENT (cNum, rNum, mId, cContent, 
    cGroup, cStep, cIndent, cIp)
    VALUES (R_COMMENT_SEQ.NEXTVAL, 1, 'bbb', '댓글내용7', 
    R_COMMENT_SEQ.CURRVAL, 0, 0, '192.168.12.151');

-- 댓글의 답글 처리를 위한 STEP A
UPDATE R_COMMENT SET CSTEP = CSTEP + 1
    WHERE CGROUP = 1 AND CSTEP > 0;
-- 댓글의 답글 쓰기
INSERT INTO R_COMMENT (cNum, rNum, mId, cContent, 
    cGroup, cStep, cIndent, cIp)
    VALUES (R_COMMENT_SEQ.NEXTVAL, 1, 'aaa', '1번 댓글의 답글1', 
    1, 1, 1, '192.168.10.153');

--★★★★★★★★★★★★★★★★★추천★★★★★★★★★★★★★★★★★--
-- 추천 눌렀는지 확인
SELECT * FROM R_LIKE WHERE RNUM = 2 AND MID = 'aaa';

-- 추천 누르기
INSERT INTO R_LIKE (lNum, rNum, mId)
    VALUES(R_LIKE_SEQ.NEXTVAL, 2, 'aaa');

--★★★★★★★★★★★★★★★★★★글쓰기★★★★★★★★★★★★★★★★★--
-- 리뷰작성
INSERT INTO REVIEW (rNum, mId, rTitle, rContent, rFileName_1, rFileName_2, 
    rFileName_3, rFileName_4, rFileName_5, rIp)
    VALUES (REVIEW_SEQ.NEXTVAL, 'bbb', '제목6', '본문6', NULL, NULL,
    NULL, NULL, NULL, '192.168.0.151');

INSERT INTO REVIEW (rNum, mId, rTitle, rContent, rFileName_1, rFileName_2, 
    rFileName_3, rFileName_4, rFileName_5, rIp)
    VALUES (REVIEW_SEQ.NEXTVAL, 'sana', '제목6', '본문6', 'irene.jpg', NULL,
    NULL, NULL, NULL, '192.168.0.151');
SELECT * FROM REVIEW;

--★★★★★★★★★★★★★★★★★★글수정★★★★★★★★★★★★★★★★★--
-- 수정 전 RNUM 통해 DTO 가져오기
SELECT R.*,
    (SELECT COUNT(*) FROM R_COMMENT WHERE R.RNUM=R_COMMENT.RNUM) COMMENTCNT,
    (SELECT COUNT(*) FROM R_LIKE WHERE R.RNUM=R_LIKE.RNUM) LIKECNT, MNAME
    FROM REVIEW R, MEMBER M WHERE R.MID = M.MID AND RNUM = 7    ;

-- 수정
UPDATE REVIEW SET RTITLE      = '제목2 수정 후', 
                  RCONTENT    = '본문2 수정 후', 
                  RFILENAME_1 = NULL, 
                  RFILENAME_2 = NULL, 
                  RFILENAME_3 = 'irene.jpg', 
                  RFILENAME_4 = NULL, 
                  RFILENAME_5 = NULL, 
                  RDATE       = SYSDATE, 
                  RIP         = '192.168.0.152'
            WHERE RNUM        = 1;
COMMIT;
--★★★★★★★★★★★★★★★★★★글삭제★★★★★★★★★★★★★★★★★--            
-- 리뷰삭제
UPDATE REVIEW SET RDELETE = 0 WHERE RNUM = 2;

------------------------------------------------------------------
--                              QnA                             --
------------------------------------------------------------------
--★★★★★★★★★★★★★★★전체 글 목록★★★★★★★★★★★★★★★★--
-- QnA목록(글목록)
SELECT * FROM 
    (SELECT ROWNUM RN, A.* FROM
        (SELECT Q.*, M.MNAME FROM QnA Q, MEMBER M 
            WHERE Q.MID=M.MID AND QDELETE = 1 ORDER BY QGROUP DESC, QSTEP)A)
    WHERE RN BETWEEN 1 AND 10; -- 사용할 것
    
-- QnA 갯수파악(페이징에 사용)
SELECT COUNT(*) FROM QnA WHERE QDELETE = 1;

-- QnA 검색(삭제 제외)
SELECT * FROM 
    (SELECT ROWNUM RN, A.* FROM
        (SELECT Q.*, M.MNAME FROM QnA Q, MEMBER M 
            WHERE Q.MID=M.MID AND QDELETE = 1 
            AND QTITLE LIKE '%' || '글3' || '%' ORDER BY QGROUP DESC, QSTEP)A)
    WHERE RN BETWEEN 1 AND 5;    
select * from qna;

-- 검색된 QnA 갯수
SELECT COUNT(*) FROM QnA WHERE QDELETE = 1 AND QTITLE LIKE '%' || '제목' || '%';

--★★★★★★★★★★★★★★★★★★글보기★★★★★★★★★★★★★★★★★--
-- 삭제되었는지 확인
SELECT * FROM QnA WHERE QNUM = 3 AND QDELETE = 1;

-- 조회수 올리기
UPDATE QnA SET QHIT = QHIT + 1 WHERE QNUM = 3;

-- 본문
SELECT Q.*, MNAME FROM QnA Q, MEMBER M 
    WHERE Q.MID = M.MID AND QNUM = 2;
    
--★★★★★★★★★★★★★★★★★답글★★★★★★★★★★★★★★★★★--
-- 답글쓰기
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
SELECT * FROM QnA ORDER BY QGROUP DESC, QSTEP;
    
--★★★★★★★★★★★★★★★★★★글쓰기★★★★★★★★★★★★★★★★★--
-- QnA작성
INSERT INTO QnA (qNum, mId, qTitle, qContent, 
    qGroup, qStep, qIndent, qIp)
    VALUES (QnA_SEQ.NEXTVAL, 'aaa', '질문글10', '내용10', 
    QnA_SEQ.CURRVAL, 0, 0, '192.168.13.151');

--★★★★★★★★★★★★★★★★★★글수정★★★★★★★★★★★★★★★★★--
-- 수정 전 QNUM 통해 DTO 가져오기
SELECT * FROM QnA WHERE QNUM = 2;
SELECT Q.*, MNAME FROM QnA Q, MEMBER M WHERE Q.MID = M.MID AND QNUM = 2;
-- 수정
UPDATE QnA SET QTITLE      = '제목2 수정 후', 
               QCONTENT    = '본문2 수정 후', 
               QDATE       = SYSDATE, 
               QIP         = '192.168.0.152'
        WHERE QNUM        = 2;
--★★★★★★★★★★★★★★★★★★글삭제★★★★★★★★★★★★★★★★★--            
-- QnA 삭제
UPDATE QnA SET QDELETE = 0 WHERE QNUM = 2;
------------------------------------------------------------------
--                           공지사항                             --
------------------------------------------------------------------
--★★★★★★★★★★★★★★★전체 글 목록★★★★★★★★★★★★★★★★--
-- 공지사항 목록(글목록)
SELECT * FROM (SELECT ROWNUM RN, A.*, ANAME FROM
    (SELECT N.*,
    (SELECT COUNT(*) FROM N_COMMENT WHERE N.NNUM=N_COMMENT.NNUM) COMMENTCNT
    FROM NOTICE N WHERE NDELETE = 1 ORDER BY NNUM DESC)A, ADMIN
    WHERE A.AID=ADMIN.AID)
    WHERE RN BETWEEN 1 AND 3; -- 사용할 것
    
-- 공지사항 갯수파악(페이징에 사용)
SELECT COUNT(*) FROM NOTICE WHERE NDELETE = 1;

-- 공지사항 검색
SELECT * FROM (SELECT ROWNUM RN, A.*, ANAME FROM
    (SELECT N.*,
    (SELECT COUNT(*) FROM N_COMMENT WHERE N.NNUM=N_COMMENT.NNUM) COMMENTCNT
    FROM NOTICE N WHERE NDELETE = 1 ORDER BY NNUM DESC)A, ADMIN
    WHERE A.AID=ADMIN.AID AND NTITLE LIKE '%' || '1' || '%')
    WHERE RN BETWEEN 1 AND 3;

-- 검색된 공지사항 갯수
SELECT COUNT(*) FROM NOTICE WHERE NDELETE = 1 AND NTITLE LIKE '%' || '1' || '%';


-- 댓글 
SELECT COMMENTCNT FROM
    (SELECT ROWNUM RN, A.* FROM
        (SELECT N.*, (SELECT COUNT(*) FROM N_COMMENT C WHERE C.NNUM=N.NNUM) COMMENTCNT
    FROM NOTICE N WHERE NDELETE = 1 ORDER BY NNUM DESC)A)
    WHERE RN BETWEEN 1 AND 3;
    
--★★★★★★★★★★★★★★★★★★글보기★★★★★★★★★★★★★★★★★--
-- 삭제되었는지 확인
SELECT * FROM NOTICE WHERE NNUM = 3 AND NDELETE = 1;

-- 조회수 올리기
UPDATE NOTICE SET NHIT = NHIT + 1 WHERE NNUM = 3;

-- 본문
SELECT N.*, ANAME, 
    (SELECT COUNT(*) FROM N_COMMENT WHERE N.NNUM=N_COMMENT.NNUM) COMMENTCNT
    FROM NOTICE N, ADMIN A WHERE N.AID = A.AID AND NNUM = 1;
    
-- 댓글
SELECT ROWNUM RN, A.NCNUM, A.MID, A.NCCONTENT, A.NCDATE, A.NCGROUP, 
    A.NCSTEP, A.NCINDENT, A.NCIP FROM
    (SELECT C.*, MNAME
    FROM MEMBER M, N_COMMENT C
    WHERE M.MID=C.MID AND NNUM = 1 ORDER BY NCGROUP DESC, NCSTEP) A;
SELECT * FROM 
    (SELECT ROWNUM RN, A.NCNUM, A.NNUM, A.MID, A.NCCONTENT, A.NCDATE, A.NCGROUP, 
    A.NCSTEP, A.NCINDENT, A.NCIP, A.MNAME FROM
    (SELECT C.*, MNAME
    FROM MEMBER M, N_COMMENT C
    WHERE M.MID=C.MID AND NNUM = 1 ORDER BY NCGROUP DESC, NCSTEP) A)
    WHERE RN BETWEEN 1 AND 6; -- 사용할 것
SELECT COUNT(*) FROM N_COMMENT WHERE NNUM = 1; -- 페이징처리

SELECT C.*, MNAME
    FROM MEMBER M, N_COMMENT C
    WHERE M.MID=C.MID AND NNUM = 1;
    
-- 댓글
SELECT R.*, MNAME 
    FROM R_COMMENT R, MEMBER M 
    WHERE R.MID = M.MID AND  RNUM = 3;

--★★★★★★★★★★★★★★★★★댓글★★★★★★★★★★★★★★★★★--
-- 댓글쓰기
INSERT INTO N_COMMENT (ncNum, nNum, mId, ncContent, 
    ncGroup, ncStep, ncIndent, ncIp)
    VALUES (N_COMMENT_SEQ.NEXTVAL, 2, 'bbb', '댓글내용7', 
    N_COMMENT_SEQ.CURRVAL, 0, 0, '192.168.12.151');
    
-- 댓글의 답글 처리를 위한 STEP A
UPDATE N_COMMENT SET NCSTEP = NCSTEP + 1
    WHERE NCGROUP = 1 AND NCSTEP > 0;
-- 댓글의 답글 쓰기
INSERT INTO N_COMMENT (ncNum, nNum, mId, ncContent, 
    ncGroup, ncStep, ncIndent, ncIp)
    VALUES (N_COMMENT_SEQ.NEXTVAL, 1, 'aaa', '1번 댓글의 답글1', 
    1, 1, 1, '192.168.10.153');
    
--사용자 모드
--리류 목록(삭제 제외)
SELECT * FROM
    (SELECT ROWNUM RN, A.* FROM
    (SELECT R.*,
    (SELECT COUNT(*) FROM R_COMMENT WHERE R.RNUM=R_COMMENT.RNUM) COMMENTCNT,
    (SELECT COUNT(*) FROM R_LIKE WHERE R.RNUM=R_LIKE.RNUM) LIKECNT, MNAME
    FROM REVIEW R, MEMBER M WHERE R.MID = M.MID AND RDELETE = 1 
    ORDER BY RNUM DESC)A)
    WHERE RN BETWEEN 2 AND 3;
--리류 목록(삭제 제외 총 갯수)
SELECT COUNT(*) FROM REVIEW WHERE RDELETE = 1;

--리뷰 검색 목록(삭제 제외)
SELECT * FROM
    (SELECT ROWNUM RN, A.* FROM
    (SELECT R.*,
    (SELECT COUNT(*) FROM R_COMMENT WHERE R.RNUM=R_COMMENT.RNUM) COMMENTCNT,
    (SELECT COUNT(*) FROM R_LIKE WHERE R.RNUM=R_LIKE.RNUM) LIKECNT, MNAME
    FROM REVIEW R, MEMBER M WHERE R.MID = M.MID AND RDELETE = 1 
    AND RTITLE LIKE '%' || '1' || '%'
    ORDER BY RNUM DESC)A)
    WHERE RN BETWEEN 1 AND 2;
--리뷰 검색 목록(삭제 제외 총 갯수)
SELECT COUNT(*) FROM REVIEW WHERE RDELETE = 1 AND RTITLE LIKE '%' || '1' || '%';

--QnA 목록(삭제 제외)
SELECT * FROM 
    (SELECT ROWNUM RN, A.* FROM
        (SELECT Q.*, M.MNAME FROM QnA Q, MEMBER M 
            WHERE Q.MID=M.MID AND QDELETE = 1 ORDER BY QNUM DESC)A)
    WHERE RN BETWEEN 1 AND 5;
--QnA 목록(삭제 제외 총 갯수)
SELECT COUNT(*) FROM QnA WHERE QDELETE = 1;

--QnA 검색 목록(삭제 제외)
SELECT * FROM 
    (SELECT ROWNUM RN, A.* FROM
        (SELECT Q.*, M.MNAME FROM QnA Q, MEMBER M 
            WHERE Q.MID=M.MID AND QDELETE = 1 
            AND QTITLE LIKE '%' || '글3' || '%' ORDER BY QNUM DESC)A)
    WHERE RN BETWEEN 1 AND 5; 
--QnA 검색 목록(삭제 제외 총 갯수)
SELECT COUNT(*) FROM QnA WHERE QDELETE = 1 AND QTITLE LIKE '%' || '제목' || '%';

--공지 목록(삭제 제외)
SELECT * FROM (SELECT ROWNUM RN, A.*, ANAME FROM
    (SELECT N.*,
    (SELECT COUNT(*) FROM N_COMMENT WHERE N.NNUM=N_COMMENT.NNUM) COMMENTCNT
    FROM NOTICE N WHERE NDELETE = 1 ORDER BY NNUM DESC)A, ADMIN
    WHERE A.AID=ADMIN.AID)
    WHERE RN BETWEEN 1 AND 3;
--공지 목록(삭제 제외 총 갯수)
SELECT COUNT(*) FROM NOTICE WHERE NDELETE = 1;

--공지 검색 목록(삭제 제외)
SELECT * FROM (SELECT ROWNUM RN, A.*, ANAME FROM
    (SELECT N.*,
    (SELECT COUNT(*) FROM N_COMMENT WHERE N.NNUM=N_COMMENT.NNUM) COMMENTCNT
    FROM NOTICE N WHERE NDELETE = 1 ORDER BY NNUM DESC)A, ADMIN
    WHERE A.AID=ADMIN.AID AND NTITLE LIKE '%' || '1' || '%')
    WHERE RN BETWEEN 1 AND 3;
--공지 검색 목록(삭제 제외 총 갯수)
SELECT COUNT(*) FROM NOTICE WHERE NDELETE = 1 AND NTITLE LIKE '%' || '1' || '%';