------------------------------------------------------------------
--                          �����ڸ��                            --
------------------------------------------------------------------
------------------------------------------------------------------
--                           ȸ������                            --
------------------------------------------------------------------
-- �α���
SELECT * FROM ADMIN WHERE AID = 'admin' AND APW = '111';
-- �α��� ���� ���� �Ѹ��� ���� DTO ��������
SELECT * FROM ADMIN WHERE AID = 'admin';
select * from member;
-- ȸ������Ʈ
SELECT * FROM
    (SELECT ROWNUM RN, A.* FROM
    (SELECT * FROM MEMBER ORDER BY MID)A)
    WHERE RN BETWEEN 2 AND 3;

-- ��ü ȸ����
SELECT COUNT(*) FROM MEMBER;

-- ȸ���˻�
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

    
-- �˻��� ȸ�� ��
SELECT COUNT(*) FROM MEMBER WHERE MID LIKE '%' || 'a' || '%';

-- ������Ʈ����
UPDATE MEMBER SET MGRADE = 0 WHERE MID = 'aaa';
UPDATE MEMBER SET MGRADE = 1 WHERE MID = 'bbb';
select * from member;
commit;
select * from review;
delete review where rnum = 11;


------------------------------------------------------------------
--                           �Խù�����                           --
------------------------------------------------------------------
-- ����
-- ������(�۸��)
SELECT * FROM
    (SELECT ROWNUM RN, A.* FROM
    (SELECT R.*,
    (SELECT COUNT(*) FROM R_COMMENT WHERE R.RNUM=R_COMMENT.RNUM) COMMENTCNT,
    (SELECT COUNT(*) FROM R_LIKE WHERE R.RNUM=R_LIKE.RNUM) LIKECNT, MNAME
    FROM REVIEW R, MEMBER M WHERE R.MID = M.MID ORDER BY RNUM DESC)A)
    WHERE RN BETWEEN 2 AND 3;

-- ���� �����ľ�(����¡�� ���)
SELECT COUNT(*) FROM REVIEW;
SELECT * FROM REVIEW;

-- ���� �˻�(���� ����)
SELECT * FROM
    (SELECT ROWNUM RN, A.* FROM
    (SELECT R.*,
    (SELECT COUNT(*) FROM R_COMMENT WHERE R.RNUM=R_COMMENT.RNUM) COMMENTCNT,
    (SELECT COUNT(*) FROM R_LIKE WHERE R.RNUM=R_LIKE.RNUM) LIKECNT, MNAME
    FROM REVIEW R, MEMBER M WHERE R.MID = M.MID 
    AND RTITLE LIKE '%' || '1' || '%'ORDER BY RNUM DESC)A)
    WHERE RN BETWEEN 1 AND 2;

-- �˻��� ���� �� ����(���� ����)
SELECT COUNT(*) FROM REVIEW WHERE RTITLE LIKE '%' || '1' || '%';

-- ���� ����
UPDATE REVIEW SET RDELETE = 1 WHERE RNUM = 1;

-- QnA
-- QnA���(�۸��)
SELECT * FROM 
    (SELECT ROWNUM RN, A.* FROM
        (SELECT Q.*, M.MNAME FROM QnA Q, MEMBER M 
            WHERE Q.MID=M.MID ORDER BY QNUM DESC)A)
    WHERE RN BETWEEN 1 AND 5; -- ����� ��
    
-- QnA �����ľ�(����¡�� ���)
SELECT COUNT(*) FROM QnA;

-- QnA �˻�
SELECT * FROM
    (SELECT ROWNUM RN, A.*, MNAME FROM
    (SELECT * FROM QnA WHERE QTITLE LIKE '%' || '��3' || '%' 
    ORDER BY QGROUP DESC, QSTEP)A, MEMBER M
    WHERE A.MID = M.MID)
    WHERE RN BETWEEN 1 AND 2;
-- �˻��� QnA �� ����
SELECT COUNT(*) FROM QnA WHERE QTITLE LIKE '%' || '3' || '%';

-- QnA ����
UPDATE QnA SET QDELETE = 1 WHERE QNUM = 1;

-- �������� ���(�۸��)
SELECT * FROM
    (SELECT ROWNUM RN, A.* FROM
    (SELECT N.*, ANAME, 
    (SELECT COUNT(*) FROM N_COMMENT WHERE N.NNUM=N_COMMENT.NNUM) COMMENTCNT
    FROM NOTICE N, ADMIN A WHERE N.AID = A.AID ORDER BY NNUM DESC)A)
    WHERE RN BETWEEN 2 AND 3;

-- �������� �����ľ�(����¡�� ���)
SELECT COUNT(*) FROM NOTICE;

-- �������� �˻� ���
SELECT * FROM
    (SELECT ROWNUM RN, A.* FROM
    (SELECT N.*, ANAME, 
    (SELECT COUNT(*) FROM N_COMMENT WHERE N.NNUM=N_COMMENT.NNUM) COMMENTCNT
    FROM NOTICE N, ADMIN A WHERE N.AID = A.AID 
    AND NTITLE LIKE '%' || '����2' || '%'
    ORDER BY NNUM DESC)A)
    WHERE RN BETWEEN 1 AND 3;

-- �˻��� �������� �� ����
SELECT COUNT(*) FROM NOTICE WHERE NTITLE LIKE '%' || '����2' || '%';

-- �������� ����
UPDATE NOTICE SET NDELETE=1 WHERE NNUM = 1;

------------------------------------------------------------------
--                            ��������                           --
------------------------------------------------------------------
--�ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ���ü��ϡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ�--
-- �������� ���
SELECT * FROM 
    (SELECT ROWNUM RN, A.* 
    FROM (SELECT N.*, 
    (SELECT COUNT(*) FROM N_COMMENT WHERE N.NNUM=N_COMMENT.NNUM) COMMENTCNT
    FROM NOTICE N WHERE NDELETE = 1 ORDER BY NNUM DESC)A) 
    WHERE RN BETWEEN 2 AND 3; -- ����� ��
-- �������� ����
SELECT COUNT(*) FROM NOTICE WHERE NDELETE = 1;

--�ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڱ��ۼ��ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ�--
INSERT INTO NOTICE (nNum, aId, nTitle, nContent, nIp)
    VALUES (NOTICE_SEQ.NEXTVAL, 'admin', '����1', '����1','192.168.0.151');
    
--�ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڱۼ����ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ�--
-- ���� �� NNUM ���� DTO ��������
SELECT N.*, ANAME, 
    (SELECT COUNT(*) FROM N_COMMENT WHERE N.NNUM=N_COMMENT.NNUM) COMMENTCNT
    FROM NOTICE N, ADMIN A WHERE N.AID = A.AID AND NNUM = 2;    

-- ����
UPDATE NOTICE SET NTITLE      = '����2 ���� ��', 
                  NCONTENT    = '����2 ���� ��', 
                  NDATE       = SYSDATE, 
                  NIP         = '192.168.0.152'
            WHERE NNUM        = 2;
            
--�ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڱۻ����ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ�--
UPDATE NOTICE SET NDELETE = 0 WHERE NNUM = 1;

--������ ���
--���� ���(��ü)
SELECT * FROM
    (SELECT ROWNUM RN, A.* FROM
    (SELECT R.*,
    (SELECT COUNT(*) FROM R_COMMENT WHERE R.RNUM=R_COMMENT.RNUM) COMMENTCNT,
    (SELECT COUNT(*) FROM R_LIKE WHERE R.RNUM=R_LIKE.RNUM) LIKECNT, MNAME
    FROM REVIEW R, MEMBER M WHERE R.MID = M.MID ORDER BY RNUM DESC)A)
    WHERE RN BETWEEN 2 AND 3;

--���� ���(��ü �� ����)
SELECT COUNT(*) FROM REVIEW;

--���� �˻� ���(��ü)
SELECT * FROM
    (SELECT ROWNUM RN, A.* FROM
    (SELECT R.*,
    (SELECT COUNT(*) FROM R_COMMENT WHERE R.RNUM=R_COMMENT.RNUM) COMMENTCNT,
    (SELECT COUNT(*) FROM R_LIKE WHERE R.RNUM=R_LIKE.RNUM) LIKECNT, MNAME
    FROM REVIEW R, MEMBER M WHERE R.MID = M.MID 
    AND RTITLE LIKE '%' || '1' || '%'ORDER BY RNUM DESC)A)
    WHERE RN BETWEEN 1 AND 2;
--���� �˻� ���(��ü �� ����)
SELECT COUNT(*) FROM REVIEW WHERE RTITLE LIKE '%' || '1' || '%';

--QnA ���(��ü)
SELECT * FROM 
    (SELECT ROWNUM RN, A.* FROM
        (SELECT Q.*, M.MNAME FROM QnA Q, MEMBER M 
            WHERE Q.MID=M.MID ORDER BY QNUM DESC)A)
    WHERE RN BETWEEN 1 AND 5;
--QnA ���(��ü �� ����)
SELECT COUNT(*) FROM QnA;

--QnA �˻� ���(��ü)
SELECT * FROM
    (SELECT ROWNUM RN, A.*, MNAME FROM
    (SELECT * FROM QnA WHERE QTITLE LIKE '%' || '��3' || '%' 
    ORDER BY QGROUP DESC, QSTEP)A, MEMBER M
    WHERE A.MID = M.MID)
    WHERE RN BETWEEN 1 AND 2;
--QnA �˻� ���(��ü �� ����)
SELECT COUNT(*) FROM QnA WHERE QTITLE LIKE '%' || '3' || '%';

--���� ���(��ü)
SELECT * FROM
    (SELECT ROWNUM RN, A.* FROM
    (SELECT N.*, ANAME, 
    (SELECT COUNT(*) FROM N_COMMENT WHERE N.NNUM=N_COMMENT.NNUM) COMMENTCNT
    FROM NOTICE N, ADMIN A WHERE N.AID = A.AID ORDER BY NNUM DESC)A)
    WHERE RN BETWEEN 2 AND 3;
--���� ���(��ü �� ����)
SELECT COUNT(*) FROM NOTICE;

--���� �˻� ���(��ü)
SELECT * FROM
    (SELECT ROWNUM RN, A.* FROM
    (SELECT N.*, ANAME, 
    (SELECT COUNT(*) FROM N_COMMENT WHERE N.NNUM=N_COMMENT.NNUM) COMMENTCNT
    FROM NOTICE N, ADMIN A WHERE N.AID = A.AID 
    AND NTITLE LIKE '%' || '����2' || '%'
    ORDER BY NNUM DESC)A)
    WHERE RN BETWEEN 1 AND 3;
--���� �˻� ���(��ü �� ����)
SELECT COUNT(*) FROM NOTICE WHERE NTITLE LIKE '%' || '����2' || '%';