------------------------------------------------------------------
--                          ����ڸ��                            --
------------------------------------------------------------------
------------------------------------------------------------------
--                           ȸ������                            --
------------------------------------------------------------------
-- ID�ߺ�Ȯ��
SELECT * FROM MEMBER WHERE MID = 'aaa';
commit;
-- ����
INSERT INTO MEMBER (mId, mGrade, mPw, mName, mEmail, mBirth)
    VALUES ('ddd', 1, '444', 'ȫ�浿', 'tj@tj.com', '1993-05-09');
    
-- �α���
SELECT * FROM MEMBER WHERE MJOIN=1 AND MID = 'aaa' AND MPW = '123';

-- �α��� ���� ���� �Ѹ��� ���� DTO ��������
SELECT * FROM MEMBER WHERE MID = 'aaa';

-- ȸ������ ���� �� ��й�ȣ �´��� Ȯ��
SELECT * FROM MEMBER WHERE MID = 'aaa' AND MPW = '123';

-- ȸ������ ����
UPDATE MEMBER SET MPW    = '123', 
                  MNAME  = 'ȫ���', 
                  MEMAIL = 'tjtj@tj.com', 
                  MBIRTH = '2001-12-23'
            WHERE MID    = 'aaa';
            
-- ȸ��Ż��
UPDATE MEMBER SET MJOIN=0 WHERE MID='aaa';
SELECT * FROM MEMBER;

------------------------------------------------------------------
--                          ���� �Խù�                           --
------------------------------------------------------------------
-- ���� �� �Խù�(REVIEW)
SELECT COUNT(*) FROM REVIEW WHERE MID='aaa' AND RDELETE = 1;
SELECT * FROM (SELECT ROWNUM RN, A.*, MNAME FROM
    (SELECT R.*,
    (SELECT COUNT(*) FROM R_COMMENT WHERE R.RNUM=R_COMMENT.RNUM) COMMENTCNT,
    (SELECT COUNT(*) FROM R_LIKE WHERE R.RNUM=R_LIKE.RNUM) LIKECNT 
    FROM REVIEW R WHERE RDELETE = 1 AND R.MID='aaa' ORDER BY RNUM DESC)A, MEMBER
    WHERE A.MID=MEMBER.MID)
    WHERE RN BETWEEN 1 AND 3;
    
-- ���� �� �Խù�(QnA)
SELECT * FROM 
    (SELECT ROWNUM RN, A.* FROM
        (SELECT Q.*, M.MNAME FROM QnA Q, MEMBER M 
            WHERE Q.MID=M.MID AND Q.MID='aaa' AND QDELETE = 1
            ORDER BY QGROUP DESC, QSTEP)A)
    WHERE RN BETWEEN 1 AND 5;
SELECT COUNT(*) FROM QnA WHERE MID='aaa' AND QDELETE = 1;

-- ���� �� ���(REVIEW)
SELECT * FROM
    (SELECT ROWNUM RN, A.* FROM
    (SELECT R.*, MNAME FROM R_COMMENT R, MEMBER M 
        WHERE R.MID=M.MID AND R.MID = 'aaa' 
        ORDER BY RNUM DESC, CGROUP DESC, CSTEP)A)
    WHERE RN BETWEEN 1 AND 5;
SELECT COUNT(*) FROM R_COMMENT WHERE MID='aaa';

-- ���� �� ���(NOTICE)
SELECT * FROM
    (SELECT ROWNUM RN, A.* FROM
    (SELECT N.*, MNAME FROM N_COMMENT N, MEMBER M 
        WHERE N.MID=M.MID AND N.MID = 'aaa' 
        ORDER BY NNUM DESC, NCGROUP DESC, NCSTEP)A)
    WHERE RN BETWEEN 1 AND 5;
SELECT COUNT(*) FROM N_COMMENT WHERE MID='aaa';
select * from member;   

------------------------------------------------------------------
--                          ���� �Խ���                           --
------------------------------------------------------------------
--�ڡڡڡڡڡڡڡڡڡڡڡڡڡڡ���ü �� ��ϡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ�--
-- ������(�۸��)
SELECT * FROM
    (SELECT ROWNUM RN, A.* FROM
    (SELECT R.*,
    (SELECT COUNT(*) FROM R_COMMENT WHERE R.RNUM=R_COMMENT.RNUM) COMMENTCNT,
    (SELECT COUNT(*) FROM R_LIKE WHERE R.RNUM=R_LIKE.RNUM) LIKECNT, MNAME
    FROM REVIEW R, MEMBER M WHERE R.MID = M.MID AND RDELETE = 1 
    ORDER BY RNUM DESC)A)
    WHERE RN BETWEEN 2 AND 3;

    
-- ���� �� ����
SELECT COUNT(*) FROM REVIEW WHERE RDELETE = 1;
    
-- ���� �˻�
SELECT * FROM
    (SELECT ROWNUM RN, A.* FROM
    (SELECT R.*,
    (SELECT COUNT(*) FROM R_COMMENT WHERE R.RNUM=R_COMMENT.RNUM) COMMENTCNT,
    (SELECT COUNT(*) FROM R_LIKE WHERE R.RNUM=R_LIKE.RNUM) LIKECNT, MNAME
    FROM REVIEW R, MEMBER M WHERE R.MID = M.MID AND RDELETE = 1 
    AND RTITLE LIKE '%' || '1' || '%'
    ORDER BY RNUM DESC)A)
    WHERE RN BETWEEN 1 AND 2;

-- �˻��� ���� �� ����
SELECT COUNT(*) FROM REVIEW WHERE RDELETE = 1 AND RTITLE LIKE '%' || '1' || '%';

-- ��� 
SELECT COMMENTCNT FROM
    (SELECT ROWNUM RN, A.* FROM
        (SELECT R.*, (SELECT COUNT(*) FROM R_COMMENT C WHERE C.RNUM=R.RNUM) COMMENTCNT
    FROM REVIEW R WHERE RDELETE = 1 ORDER BY RNUM DESC)A)
    WHERE RN BETWEEN 1 AND 3;

-- ��õ
SELECT LIKECNT FROM
    (SELECT ROWNUM RN, A.* FROM
        (SELECT R.*, (SELECT COUNT(*) FROM R_LIKE L WHERE L.RNUM=R.RNUM) LIKECNT
    FROM REVIEW R WHERE RDELETE = 1 ORDER BY RNUM DESC)A)
    WHERE RN BETWEEN 1 AND 3;
    
-- ���� �����ľ�(����¡�� ���)
SELECT COUNT(*) FROM REVIEW WHERE RDELETE = 1;
 
--�ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڱۺ���ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ�--
-- �����Ǿ����� Ȯ��
SELECT * FROM REVIEW WHERE RNUM = 3 AND RDELETE = 1;

-- ��ȸ�� �ø���
UPDATE REVIEW SET RHIT = RHIT + 1 WHERE RNUM = 3;

-- ����
SELECT R.*,
    (SELECT COUNT(*) FROM R_COMMENT WHERE R.RNUM=R_COMMENT.RNUM) COMMENTCNT,
    (SELECT COUNT(*) FROM R_LIKE WHERE R.RNUM=R_LIKE.RNUM) LIKECNT, MNAME
    FROM REVIEW R, MEMBER M WHERE R.MID = M.MID AND RNUM = 6;
    
-- ��õ
SELECT COUNT(*) FROM R_LIKE WHERE RNUM = 3;

-- ���
SELECT R.*, MNAME FROM R_COMMENT R, MEMBER M 
    WHERE R.MID = M.MID AND  RNUM = 1 
    ORDER BY CGROUP DESC, CSTEP;
    
SELECT ROWNUM RN, A.CNUM, A.MID, A.CCONTENT, A.CDATE, A.CGROUP, 
    A.CSTEP, A.CINDENT, A.CIP FROM
    (SELECT R.*, MNAME FROM R_COMMENT R, MEMBER M 
    WHERE R.MID = M.MID AND  RNUM = 1 
    ORDER BY CGROUP DESC, CSTEP)A; -- ��������
    
SELECT * FROM 
    (SELECT ROWNUM RN, A.CNUM, A.RNUM, A.MID, A.CCONTENT, A.CDATE, A.CGROUP, 
    A.CSTEP, A.CINDENT, A.CIP, A.MNAME FROM
    (SELECT R.*, MNAME FROM R_COMMENT R, MEMBER M 
    WHERE R.MID = M.MID AND  RNUM = 1 
    ORDER BY CGROUP DESC, CSTEP)A)
    WHERE RN BETWEEN 11 AND 20; -- ����� ��
    
SELECT * FROM R_COMMENT;

-- ��۰���
SELECT COUNT(*) FROM R_COMMENT WHERE RNUM = 1;

--�ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڴ�ۡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ�--
-- ��۾���
INSERT INTO R_COMMENT (cNum, rNum, mId, cContent, 
    cGroup, cStep, cIndent, cIp)
    VALUES (R_COMMENT_SEQ.NEXTVAL, 1, 'bbb', '��۳���7', 
    R_COMMENT_SEQ.CURRVAL, 0, 0, '192.168.12.151');

-- ����� ��� ó���� ���� STEP A
UPDATE R_COMMENT SET CSTEP = CSTEP + 1
    WHERE CGROUP = 1 AND CSTEP > 0;
-- ����� ��� ����
INSERT INTO R_COMMENT (cNum, rNum, mId, cContent, 
    cGroup, cStep, cIndent, cIp)
    VALUES (R_COMMENT_SEQ.NEXTVAL, 1, 'aaa', '1�� ����� ���1', 
    1, 1, 1, '192.168.10.153');

--�ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ���õ�ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ�--
-- ��õ �������� Ȯ��
SELECT * FROM R_LIKE WHERE RNUM = 2 AND MID = 'aaa';

-- ��õ ������
INSERT INTO R_LIKE (lNum, rNum, mId)
    VALUES(R_LIKE_SEQ.NEXTVAL, 2, 'aaa');

--�ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڱ۾���ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ�--
-- �����ۼ�
INSERT INTO REVIEW (rNum, mId, rTitle, rContent, rFileName_1, rFileName_2, 
    rFileName_3, rFileName_4, rFileName_5, rIp)
    VALUES (REVIEW_SEQ.NEXTVAL, 'bbb', '����6', '����6', NULL, NULL,
    NULL, NULL, NULL, '192.168.0.151');

INSERT INTO REVIEW (rNum, mId, rTitle, rContent, rFileName_1, rFileName_2, 
    rFileName_3, rFileName_4, rFileName_5, rIp)
    VALUES (REVIEW_SEQ.NEXTVAL, 'sana', '����6', '����6', 'irene.jpg', NULL,
    NULL, NULL, NULL, '192.168.0.151');
SELECT * FROM REVIEW;

--�ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڱۼ����ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ�--
-- ���� �� RNUM ���� DTO ��������
SELECT R.*,
    (SELECT COUNT(*) FROM R_COMMENT WHERE R.RNUM=R_COMMENT.RNUM) COMMENTCNT,
    (SELECT COUNT(*) FROM R_LIKE WHERE R.RNUM=R_LIKE.RNUM) LIKECNT, MNAME
    FROM REVIEW R, MEMBER M WHERE R.MID = M.MID AND RNUM = 7    ;

-- ����
UPDATE REVIEW SET RTITLE      = '����2 ���� ��', 
                  RCONTENT    = '����2 ���� ��', 
                  RFILENAME_1 = NULL, 
                  RFILENAME_2 = NULL, 
                  RFILENAME_3 = 'irene.jpg', 
                  RFILENAME_4 = NULL, 
                  RFILENAME_5 = NULL, 
                  RDATE       = SYSDATE, 
                  RIP         = '192.168.0.152'
            WHERE RNUM        = 1;
COMMIT;
--�ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڱۻ����ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ�--            
-- �������
UPDATE REVIEW SET RDELETE = 0 WHERE RNUM = 2;

------------------------------------------------------------------
--                              QnA                             --
------------------------------------------------------------------
--�ڡڡڡڡڡڡڡڡڡڡڡڡڡڡ���ü �� ��ϡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ�--
-- QnA���(�۸��)
SELECT * FROM 
    (SELECT ROWNUM RN, A.* FROM
        (SELECT Q.*, M.MNAME FROM QnA Q, MEMBER M 
            WHERE Q.MID=M.MID AND QDELETE = 1 ORDER BY QGROUP DESC, QSTEP)A)
    WHERE RN BETWEEN 1 AND 10; -- ����� ��
    
-- QnA �����ľ�(����¡�� ���)
SELECT COUNT(*) FROM QnA WHERE QDELETE = 1;

-- QnA �˻�(���� ����)
SELECT * FROM 
    (SELECT ROWNUM RN, A.* FROM
        (SELECT Q.*, M.MNAME FROM QnA Q, MEMBER M 
            WHERE Q.MID=M.MID AND QDELETE = 1 
            AND QTITLE LIKE '%' || '��3' || '%' ORDER BY QGROUP DESC, QSTEP)A)
    WHERE RN BETWEEN 1 AND 5;    
select * from qna;

-- �˻��� QnA ����
SELECT COUNT(*) FROM QnA WHERE QDELETE = 1 AND QTITLE LIKE '%' || '����' || '%';

--�ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڱۺ���ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ�--
-- �����Ǿ����� Ȯ��
SELECT * FROM QnA WHERE QNUM = 3 AND QDELETE = 1;

-- ��ȸ�� �ø���
UPDATE QnA SET QHIT = QHIT + 1 WHERE QNUM = 3;

-- ����
SELECT Q.*, MNAME FROM QnA Q, MEMBER M 
    WHERE Q.MID = M.MID AND QNUM = 2;
    
--�ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڴ�ۡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ�--
-- ��۾���
INSERT INTO QnA (qNum, mId, qTitle, qContent, 
    qGroup, qStep, qIndent, qIp)
    VALUES (QnA_SEQ.NEXTVAL, 'ccc', '������3', '����3', 
    QnA_SEQ.CURRVAL, 0, 0, '192.168.13.151');
    
-- QnA�� ��� ó���� ���� STEP A----------
UPDATE QnA SET QSTEP = QSTEP + 1
    WHERE QGROUP = 1 AND QSTEP > 0;
---------------------------------------
INSERT INTO QnA (qNum, mId, qTitle, qContent, 
    qGroup, qStep, qIndent, qIp)
    VALUES (QnA_SEQ.NEXTVAL, 'aaa', '������1�� ���1', '���1�� ����',
    1, 1, 1, '192.168.10.155');
SELECT * FROM QnA ORDER BY QGROUP DESC, QSTEP;
    
--�ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڱ۾���ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ�--
-- QnA�ۼ�
INSERT INTO QnA (qNum, mId, qTitle, qContent, 
    qGroup, qStep, qIndent, qIp)
    VALUES (QnA_SEQ.NEXTVAL, 'aaa', '������10', '����10', 
    QnA_SEQ.CURRVAL, 0, 0, '192.168.13.151');

--�ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڱۼ����ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ�--
-- ���� �� QNUM ���� DTO ��������
SELECT * FROM QnA WHERE QNUM = 2;
SELECT Q.*, MNAME FROM QnA Q, MEMBER M WHERE Q.MID = M.MID AND QNUM = 2;
-- ����
UPDATE QnA SET QTITLE      = '����2 ���� ��', 
               QCONTENT    = '����2 ���� ��', 
               QDATE       = SYSDATE, 
               QIP         = '192.168.0.152'
        WHERE QNUM        = 2;
--�ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڱۻ����ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ�--            
-- QnA ����
UPDATE QnA SET QDELETE = 0 WHERE QNUM = 2;
------------------------------------------------------------------
--                           ��������                             --
------------------------------------------------------------------
--�ڡڡڡڡڡڡڡڡڡڡڡڡڡڡ���ü �� ��ϡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ�--
-- �������� ���(�۸��)
SELECT * FROM (SELECT ROWNUM RN, A.*, ANAME FROM
    (SELECT N.*,
    (SELECT COUNT(*) FROM N_COMMENT WHERE N.NNUM=N_COMMENT.NNUM) COMMENTCNT
    FROM NOTICE N WHERE NDELETE = 1 ORDER BY NNUM DESC)A, ADMIN
    WHERE A.AID=ADMIN.AID)
    WHERE RN BETWEEN 1 AND 3; -- ����� ��
    
-- �������� �����ľ�(����¡�� ���)
SELECT COUNT(*) FROM NOTICE WHERE NDELETE = 1;

-- �������� �˻�
SELECT * FROM (SELECT ROWNUM RN, A.*, ANAME FROM
    (SELECT N.*,
    (SELECT COUNT(*) FROM N_COMMENT WHERE N.NNUM=N_COMMENT.NNUM) COMMENTCNT
    FROM NOTICE N WHERE NDELETE = 1 ORDER BY NNUM DESC)A, ADMIN
    WHERE A.AID=ADMIN.AID AND NTITLE LIKE '%' || '1' || '%')
    WHERE RN BETWEEN 1 AND 3;

-- �˻��� �������� ����
SELECT COUNT(*) FROM NOTICE WHERE NDELETE = 1 AND NTITLE LIKE '%' || '1' || '%';


-- ��� 
SELECT COMMENTCNT FROM
    (SELECT ROWNUM RN, A.* FROM
        (SELECT N.*, (SELECT COUNT(*) FROM N_COMMENT C WHERE C.NNUM=N.NNUM) COMMENTCNT
    FROM NOTICE N WHERE NDELETE = 1 ORDER BY NNUM DESC)A)
    WHERE RN BETWEEN 1 AND 3;
    
--�ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڱۺ���ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ�--
-- �����Ǿ����� Ȯ��
SELECT * FROM NOTICE WHERE NNUM = 3 AND NDELETE = 1;

-- ��ȸ�� �ø���
UPDATE NOTICE SET NHIT = NHIT + 1 WHERE NNUM = 3;

-- ����
SELECT N.*, ANAME, 
    (SELECT COUNT(*) FROM N_COMMENT WHERE N.NNUM=N_COMMENT.NNUM) COMMENTCNT
    FROM NOTICE N, ADMIN A WHERE N.AID = A.AID AND NNUM = 1;
    
-- ���
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
    WHERE RN BETWEEN 1 AND 6; -- ����� ��
SELECT COUNT(*) FROM N_COMMENT WHERE NNUM = 1; -- ����¡ó��

SELECT C.*, MNAME
    FROM MEMBER M, N_COMMENT C
    WHERE M.MID=C.MID AND NNUM = 1;
    
-- ���
SELECT R.*, MNAME 
    FROM R_COMMENT R, MEMBER M 
    WHERE R.MID = M.MID AND  RNUM = 3;

--�ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڴ�ۡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ�--
-- ��۾���
INSERT INTO N_COMMENT (ncNum, nNum, mId, ncContent, 
    ncGroup, ncStep, ncIndent, ncIp)
    VALUES (N_COMMENT_SEQ.NEXTVAL, 2, 'bbb', '��۳���7', 
    N_COMMENT_SEQ.CURRVAL, 0, 0, '192.168.12.151');
    
-- ����� ��� ó���� ���� STEP A
UPDATE N_COMMENT SET NCSTEP = NCSTEP + 1
    WHERE NCGROUP = 1 AND NCSTEP > 0;
-- ����� ��� ����
INSERT INTO N_COMMENT (ncNum, nNum, mId, ncContent, 
    ncGroup, ncStep, ncIndent, ncIp)
    VALUES (N_COMMENT_SEQ.NEXTVAL, 1, 'aaa', '1�� ����� ���1', 
    1, 1, 1, '192.168.10.153');
    
--����� ���
--���� ���(���� ����)
SELECT * FROM
    (SELECT ROWNUM RN, A.* FROM
    (SELECT R.*,
    (SELECT COUNT(*) FROM R_COMMENT WHERE R.RNUM=R_COMMENT.RNUM) COMMENTCNT,
    (SELECT COUNT(*) FROM R_LIKE WHERE R.RNUM=R_LIKE.RNUM) LIKECNT, MNAME
    FROM REVIEW R, MEMBER M WHERE R.MID = M.MID AND RDELETE = 1 
    ORDER BY RNUM DESC)A)
    WHERE RN BETWEEN 2 AND 3;
--���� ���(���� ���� �� ����)
SELECT COUNT(*) FROM REVIEW WHERE RDELETE = 1;

--���� �˻� ���(���� ����)
SELECT * FROM
    (SELECT ROWNUM RN, A.* FROM
    (SELECT R.*,
    (SELECT COUNT(*) FROM R_COMMENT WHERE R.RNUM=R_COMMENT.RNUM) COMMENTCNT,
    (SELECT COUNT(*) FROM R_LIKE WHERE R.RNUM=R_LIKE.RNUM) LIKECNT, MNAME
    FROM REVIEW R, MEMBER M WHERE R.MID = M.MID AND RDELETE = 1 
    AND RTITLE LIKE '%' || '1' || '%'
    ORDER BY RNUM DESC)A)
    WHERE RN BETWEEN 1 AND 2;
--���� �˻� ���(���� ���� �� ����)
SELECT COUNT(*) FROM REVIEW WHERE RDELETE = 1 AND RTITLE LIKE '%' || '1' || '%';

--QnA ���(���� ����)
SELECT * FROM 
    (SELECT ROWNUM RN, A.* FROM
        (SELECT Q.*, M.MNAME FROM QnA Q, MEMBER M 
            WHERE Q.MID=M.MID AND QDELETE = 1 ORDER BY QNUM DESC)A)
    WHERE RN BETWEEN 1 AND 5;
--QnA ���(���� ���� �� ����)
SELECT COUNT(*) FROM QnA WHERE QDELETE = 1;

--QnA �˻� ���(���� ����)
SELECT * FROM 
    (SELECT ROWNUM RN, A.* FROM
        (SELECT Q.*, M.MNAME FROM QnA Q, MEMBER M 
            WHERE Q.MID=M.MID AND QDELETE = 1 
            AND QTITLE LIKE '%' || '��3' || '%' ORDER BY QNUM DESC)A)
    WHERE RN BETWEEN 1 AND 5; 
--QnA �˻� ���(���� ���� �� ����)
SELECT COUNT(*) FROM QnA WHERE QDELETE = 1 AND QTITLE LIKE '%' || '����' || '%';

--���� ���(���� ����)
SELECT * FROM (SELECT ROWNUM RN, A.*, ANAME FROM
    (SELECT N.*,
    (SELECT COUNT(*) FROM N_COMMENT WHERE N.NNUM=N_COMMENT.NNUM) COMMENTCNT
    FROM NOTICE N WHERE NDELETE = 1 ORDER BY NNUM DESC)A, ADMIN
    WHERE A.AID=ADMIN.AID)
    WHERE RN BETWEEN 1 AND 3;
--���� ���(���� ���� �� ����)
SELECT COUNT(*) FROM NOTICE WHERE NDELETE = 1;

--���� �˻� ���(���� ����)
SELECT * FROM (SELECT ROWNUM RN, A.*, ANAME FROM
    (SELECT N.*,
    (SELECT COUNT(*) FROM N_COMMENT WHERE N.NNUM=N_COMMENT.NNUM) COMMENTCNT
    FROM NOTICE N WHERE NDELETE = 1 ORDER BY NNUM DESC)A, ADMIN
    WHERE A.AID=ADMIN.AID AND NTITLE LIKE '%' || '1' || '%')
    WHERE RN BETWEEN 1 AND 3;
--���� �˻� ���(���� ���� �� ����)
SELECT COUNT(*) FROM NOTICE WHERE NDELETE = 1 AND NTITLE LIKE '%' || '1' || '%';