-- ���̺� ����
DROP TABLE R_COMMENT;
DROP TABLE R_LIKE;
DROP TABLE REVIEW;
DROP TABLE QnA;
DROP TABLE N_COMMENT;
DROP TABLE NOTICE;
DROP TABLE ADMIN;
DROP TABLE MEMBER;
DROP TABLE LEVEL_INFO;

-- ������ ����
DROP SEQUENCE R_COMMENT_SEQ;
DROP SEQUENCE R_LIKE_SEQ;
DROP SEQUENCE REVIEW_SEQ;
DROP SEQUENCE QnA_SEQ;
DROP SEQUENCE N_COMMENT_SEQ;
DROP SEQUENCE NOTICE_SEQ;

-- ���̺� ����
------------------------------------------------------------------------
--                             MEMBER����                              --
------------------------------------------------------------------------
CREATE TABLE LEVEL_INFO(
    mGrade     NUMBER(1)   PRIMARY KEY, -- ��޹�ȣ
    mGradeName VARCHAR(30) NOT NULL     -- ��޸�
);

CREATE TABLE MEMBER(
    mId    VARCHAR2(30) PRIMARY KEY,                   -- ȸ��ID
    mGrade NUMBER(1)    REFERENCES LEVEL_INFO(mGrade), -- ��޹�ȣ
    mPw    VARCHAR2(30) NOT NULL,                      -- ��й�ȣ
    mName  VARCHAR2(30) NOT NULL,                      -- �̸�
    mEmail VARCHAR2(40),                               -- �̸���
    mBirth DATE,                                       -- �������
    mJoin  NUMBER(1)    DEFAULT 1                      -- Ż�𿩺�
);
------------------------------------------------------------------------
--                             REVIEW����                               --
------------------------------------------------------------------------
CREATE SEQUENCE REVIEW_SEQ 
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 999999 
    NOCACHE 
    NOCYCLE;
CREATE TABLE REVIEW(
    rNum      NUMBER(6)       PRIMARY KEY,            -- �� ��ȣ
    mId       VARCHAR2(30)    REFERENCES MEMBER(mId), -- ȸ��ID
    rTitle    VARCHAR2(100)   NOT NULL,               -- �� ����
    rContent  CLOB,                                   -- �� ����
    rFileName_1 VARCHAR2(50),                         -- ���ϸ�1
    rFileName_2 VARCHAR2(50),                         -- ���ϸ�2
    rFileName_3 VARCHAR2(50),                         -- ���ϸ�3
    rFileName_4 VARCHAR2(50),                         -- ���ϸ�4
    rFileName_5 VARCHAR2(50),                         -- ���ϸ�5
    rDate     DATE            DEFAULT SYSDATE,        -- �ۼ�����
    rHit      NUMBER(6)       DEFAULT 0,              -- ��ȸ��
    rIp       VARCHAR2(20)    NOT NULL,               -- �� �ۼ� IP
    rDelete   NUMBER(1)       DEFAULT 1               -- ��������
);

CREATE SEQUENCE R_COMMENT_SEQ 
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 999999 
    NOCACHE 
    NOCYCLE;
CREATE TABLE R_COMMENT(
    cNum     NUMBER(6)      PRIMARY KEY,            -- ��� ��ȣ
    rNum     NUMBER(6)      REFERENCES REVIEW(rNum), -- �� ��ȣ
    mId      VARCHAR2(30)   REFERENCES MEMBER(mId), -- ȸ��ID 
    cContent VARCHAR2(1000) NOT NULL,               -- ��� ���� 
    cDate    DATE           DEFAULT SYSDATE,        -- ��� �ۼ�����
    cGroup   NUMBER(6)      NOT NULL,               -- ��� �׷�
    cStep    NUMBER(3)      NOT NULL,               -- ��� �׷� �� ��¼���
    cIndent  NUMBER(3)      NOT NULL,               -- ��� �鿩���� ����
    cIp      VARCHAR2(20)   NOT NULL                -- ��� �ۼ� IP
);

CREATE SEQUENCE R_LIKE_SEQ 
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 999999 
    NOCACHE 
    NOCYCLE;
CREATE TABLE R_LIKE(
    lNum NUMBER(6)    PRIMARY KEY,             -- ��õ ��ȣ
    rNum NUMBER(6)    REFERENCES REVIEW(rNum), -- �� ��ȣ
    mId  VARCHAR2(30) REFERENCES MEMBER(mId)   -- ȸ��ID
);

CREATE SEQUENCE QnA_SEQ
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 999999 
    NOCACHE 
    NOCYCLE;
CREATE TABLE QnA(
    qNum     NUMBER(6)     PRIMARY KEY,            -- �۹�ȣ
    mId      VARCHAR2(30)  REFERENCES MEMBER(mId), -- ȸ��ID
    qTitle   VARCHAR2(100) NOT NULL,               -- ����
    qContent CLOB,                                 -- ����
    qDate    DATE          DEFAULT SYSDATE,        -- �ۼ�����
    qHit     NUMBER(6)     DEFAULT 0,              -- ��ȸ��
    qGroup   NUMBER(6)     NOT NULL,               -- �� �׷�
    qStep    NUMBER(3)     NOT NULL,               -- �׷� �� ��¼���
    qIndent  NUMBER(3)     NOT NULL,               -- �鿩���� ����
    qIp      VARCHAR2(20)  NOT NULL,               -- �� �ۼ� IP
    qDelete  NUMBER(1)     DEFAULT 1               -- ��������
);

------------------------------------------------------------------------
--                             ADMIN����                               --
------------------------------------------------------------------------
CREATE TABLE ADMIN(
    aId   VARCHAR2(30) PRIMARY KEY, -- ������ ID
    aPw   VARCHAR2(30) NOT NULL,    -- ������ ��й�ȣ
    aName VARCHAR2(30) NOT NULL     -- ������ �̸�
);

CREATE SEQUENCE NOTICE_SEQ
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 999999 
    NOCACHE 
    NOCYCLE;
CREATE TABLE NOTICE(
    nNum     NUMBER(6)    PRIMARY KEY,           -- ������ȣ
    aId      VARCHAR(30)  REFERENCES ADMIN(aId), -- ������ ID
    nTitle   VARCHAR(100) NOT NULL,              -- ����
    nContent CLOB,                               -- ����
    nDate    DATE         DEFAULT SYSDATE,       -- �ۼ�����
    nHit     NUMBER(6)    DEFAULT 0,             -- ��ȸ��
    nIp      VARCHAR(20)  NOT NULL,              -- IP
    nDelete  NUMBER(1)    DEFAULT 1              -- ��������
);

CREATE SEQUENCE N_COMMENT_SEQ
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 999999 
    NOCACHE 
    NOCYCLE;
CREATE TABLE N_COMMENT(
    ncNum     NUMBER(6)      PRIMARY KEY,             -- ���� ��۹�ȣ
    nNum      NUMBER(6)      REFERENCES NOTICE(nNum), -- ���� ��ȣ
    mId       VARCHAR2(30)   REFERENCES MEMBER(mId),  -- ȸ��ID
    ncContent VARCHAR2(1000) NOT NULL,                -- ��� ����
    ncDate    DATE           DEFAULT SYSDATE,         -- ��� �ۼ�����
    ncGroup   NUMBER(6)      NOT NULL,                -- ��� �׷�
    ncStep    NUMBER(3)      NOT NULL,                -- ��� �׷� �� ��¼���
    ncIndent  NUMBER(3)      NOT NULL,                -- ��� �鿩���� ����
    ncIp      VARCHAR2(20)   NOT NULL                 -- ��� �ۼ� IP
);

------------------------------------------------------------------------
--                        LEVEL_INFO ������ �Է�                        --
------------------------------------------------------------------------
INSERT INTO LEVEL_INFO VALUES (1, '�Ϲ�ȸ��');
INSERT INTO LEVEL_INFO VALUES (0, '�ҷ�ȸ��');

------------------------------------------------------------------------
--                        MEMBER ���� ������ �Է�                        --
------------------------------------------------------------------------
INSERT INTO MEMBER (mId, mGrade, mPw, mName, mEmail, mBirth)
    VALUES ('aaa', 1, '111', 'ȫ�浿', 'tj@tj.com', '1999-01-01');
INSERT INTO MEMBER (mId, mGrade, mPw, mName, mEmail, mBirth)
    VALUES ('bbb', 1, '222', '�ڱ浿', 'tj2@tj.com', '1995-01-01');
INSERT INTO MEMBER (mId, mGrade, mPw, mName, mEmail, mBirth)
    VALUES ('ccc', 0, '333', '��浿', 'tj3@tj.com', '1997-01-01');
SELECT * FROM MEMBER;

------------------------------------------------------------------------
--                        REVIEW ���� ������ �Է�                        --
------------------------------------------------------------------------
INSERT INTO REVIEW (rNum, mId, rTitle, rContent, rFileName_1, rFileName_2, 
    rFileName_3, rFileName_4, rFileName_5, rIp)
    VALUES (REVIEW_SEQ.NEXTVAL, 'aaa', '����1', '����1', NULL, NULL,
    NULL, NULL, NULL, '192.168.0.151');
INSERT INTO REVIEW (rNum, mId, rTitle, rContent, rFileName_1, rFileName_2, 
    rFileName_3, rFileName_4, rFileName_5, rIp)
    VALUES (REVIEW_SEQ.NEXTVAL, 'bbb', '����2', '����2', NULL, NULL,
    NULL, NULL, NULL, '192.168.0.153');
INSERT INTO REVIEW (rNum, mId, rTitle, rContent, rFileName_1, rFileName_2, 
    rFileName_3, rFileName_4, rFileName_5, rIp)
    VALUES (REVIEW_SEQ.NEXTVAL, 'ccc', '����3', '����3', NULL, NULL,
    NULL, NULL, NULL, '192.168.0.155');
SELECT * FROM REVIEW;

------------------------------------------------------------------------
--                        R_COMMENT ���� ������ �Է�                     --
------------------------------------------------------------------------
INSERT INTO R_COMMENT (cNum, rNum, mId, cContent, 
    cGroup, cStep, cIndent, cIp)
    VALUES (R_COMMENT_SEQ.NEXTVAL, 1, 'bbb', '��۳���1', 
    R_COMMENT_SEQ.CURRVAL, 0, 0, '192.168.12.151');
INSERT INTO R_COMMENT (cNum, rNum, mId, cContent, 
    cGroup, cStep, cIndent, cIp)
    VALUES (R_COMMENT_SEQ.NEXTVAL, 1, 'ccc', '��۳���2', 
    R_COMMENT_SEQ.CURRVAL, 0, 0, '192.168.1.159');
INSERT INTO R_COMMENT (cNum, rNum, mId, cContent, 
    cGroup, cStep, cIndent, cIp)
    VALUES (R_COMMENT_SEQ.NEXTVAL, 1, 'bbb', '��۳���3', 
    R_COMMENT_SEQ.CURRVAL, 0, 0, '192.168.1.155');
    
-- ����� ��� ó���� ���� STEP A----------
UPDATE R_COMMENT SET CSTEP = CSTEP + 1
    WHERE CGROUP = 1 AND CSTEP > 0;
---------------------------------------
INSERT INTO R_COMMENT (cNum, rNum, mId, cContent, 
    cGroup, cStep, cIndent, cIp)
    VALUES (R_COMMENT_SEQ.NEXTVAL, 1, 'aaa', '1�� ����� ���1', 
    1, 1, 1, '192.168.10.153');

-- ����� ��� ó���� ���� STEP A----------
UPDATE R_COMMENT SET CSTEP = CSTEP + 1
    WHERE CGROUP = 1 AND CSTEP > 0;
---------------------------------------
INSERT INTO R_COMMENT (cNum, rNum, mId, cContent, 
    cGroup, cStep, cIndent, cIp)
    VALUES (R_COMMENT_SEQ.NEXTVAL, 1, 'ccc', '1�� ����� ���2', 
    1, 1, 1, '192.168.10.159');
    
-- ����� ����� ��� ó���� ���� STEP A----
UPDATE R_COMMENT SET CSTEP = CSTEP + 1
    WHERE CGROUP = 1 AND CSTEP > 2;
---------------------------------------
INSERT INTO R_COMMENT (cNum, rNum, mId, cContent, 
    cGroup, cStep, cIndent, cIp)
    VALUES (R_COMMENT_SEQ.NEXTVAL, 1, 'bbb', '1�� ����� ���1�� ���1', 
    1, 3, 2, '192.168.10.152');
SELECT * FROM R_COMMENT ORDER BY CGROUP DESC, CSTEP;

------------------------------------------------------------------------
--                         B_LIKE ���� ������ �Է�                       --
------------------------------------------------------------------------
INSERT INTO R_LIKE (lNum, rNum, mId)
    VALUES (R_LIKE_SEQ.NEXTVAL, 1, 'aaa');
INSERT INTO R_LIKE (lNum, rNum, mId)
    VALUES (R_LIKE_SEQ.NEXTVAL, 1, 'bbb');
INSERT INTO R_LIKE (lNum, rNum, mId)
    VALUES (R_LIKE_SEQ.NEXTVAL, 1, 'ccc');

------------------------------------------------------------------------
--                           QnA ���� ������ �Է�                        --
------------------------------------------------------------------------
INSERT INTO QnA (qNum, mId, qTitle, qContent, 
    qGroup, qStep, qIndent, qIp)
    VALUES (QnA_SEQ.NEXTVAL, 'aaa', '������1', '����1', 
    QnA_SEQ.CURRVAL, 0, 0, '192.168.13.151');
INSERT INTO QnA (qNum, mId, qTitle, qContent, 
    qGroup, qStep, qIndent, qIp)
    VALUES (QnA_SEQ.NEXTVAL, 'bbb', '������2', '����2', 
    QnA_SEQ.CURRVAL, 0, 0, '192.168.13.151');
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

-- QnA�� ��� ó���� ���� STEP A----------
UPDATE QnA SET QSTEP = QSTEP + 1
    WHERE QGROUP = 1 AND QSTEP > 0;
---------------------------------------
INSERT INTO QnA (qNum, mId, qTitle, qContent, 
    qGroup, qStep, qIndent, qIp)
    VALUES (QnA_SEQ.NEXTVAL, 'bbb', '������1�� ���2', '���2�� ����', 
    1, 1, 1, '192.168.8.123');
    
-- ����� ����� ��� ó���� ���� STEP A----
UPDATE QnA SET QSTEP = QSTEP + 1
    WHERE QGROUP = 1 AND QSTEP > 2;
---------------------------------------
INSERT INTO QnA (qNum, mId, qTitle, qContent, 
    qGroup, qStep, qIndent, qIp)
    VALUES (QnA_SEQ.NEXTVAL, 'ccc', '������1�� ���1�� ���1', '���1�� ���1�� ����', 
    1, 3, 2, '192.168.10.142');
SELECT * FROM QnA ORDER BY QGROUP DESC, QSTEP;

------------------------------------------------------------------------
--                          ADMIN ������ �Է�                           --
------------------------------------------------------------------------
INSERT INTO ADMIN VALUES ('admin', '111', '������');

------------------------------------------------------------------------
--                        NOTICE ���� ������ �Է�                        --
------------------------------------------------------------------------
INSERT INTO NOTICE (nNum, aId, nTitle, nContent, nIp)
    VALUES (NOTICE_SEQ.NEXTVAL, 'admin', '����1', '����1','192.168.0.151');
INSERT INTO NOTICE (nNum, aId, nTitle, nContent, nIp)
    VALUES (NOTICE_SEQ.NEXTVAL, 'admin', '����2', '����2','192.168.0.151');
INSERT INTO NOTICE (nNum, aId, nTitle, nContent, nIp)
    VALUES (NOTICE_SEQ.NEXTVAL, 'admin', '����3', '����3','192.168.0.151');
SELECT * FROM NOTICE;

------------------------------------------------------------------------
--                        N_COMMENT ���� ������ �Է�                     --
------------------------------------------------------------------------
INSERT INTO N_COMMENT (ncNum, nNum, mId, ncContent, 
    ncGroup, ncStep, ncIndent, ncIp)
    VALUES (N_COMMENT_SEQ.NEXTVAL, 1, 'bbb', '��۳���1', 
    N_COMMENT_SEQ.CURRVAL, 0, 0, '192.168.12.151');
INSERT INTO N_COMMENT (ncNum, nNum, mId, ncContent, 
    ncGroup, ncStep, ncIndent, ncIp)
    VALUES (N_COMMENT_SEQ.NEXTVAL, 1, 'ccc', '��۳���2', 
    N_COMMENT_SEQ.CURRVAL, 0, 0, '192.168.1.159');
INSERT INTO N_COMMENT (ncNum, nNum, mId, ncContent, 
    ncGroup, ncStep, ncIndent, ncIp)
    VALUES (N_COMMENT_SEQ.NEXTVAL, 1, 'bbb', '��۳���3', 
    N_COMMENT_SEQ.CURRVAL, 0, 0, '192.168.1.155');
    
-- ����� ��� ó���� ���� STEP A----------
UPDATE N_COMMENT SET NCSTEP = NCSTEP + 1
    WHERE NCGROUP = 1 AND NCSTEP > 0;
---------------------------------------
INSERT INTO N_COMMENT (ncNum, nNum, mId, ncContent, 
    ncGroup, ncStep, ncIndent, ncIp)
    VALUES (R_COMMENT_SEQ.NEXTVAL, 1, 'aaa', '1�� ����� ���1',
    1, 1, 1, '192.168.10.153');

-- ����� ��� ó���� ���� STEP A----------
UPDATE N_COMMENT SET NCSTEP = NCSTEP + 1
    WHERE NCGROUP = 1 AND NCSTEP > 0;
---------------------------------------
INSERT INTO N_COMMENT (ncNum, nNum, mId, ncContent, 
    ncGroup, ncStep, ncIndent, ncIp)
    VALUES (N_COMMENT_SEQ.NEXTVAL, 1, 'ccc', '1�� ����� ���2', 
    1, 1, 1, '192.168.10.159');
    
-- ����� ����� ��� ó���� ���� STEP A----
UPDATE N_COMMENT SET NCSTEP = NCSTEP + 1
    WHERE NCGROUP = 1 AND NCSTEP > 2;
---------------------------------------
INSERT INTO N_COMMENT (ncNum, nNum, mId, ncContent, 
    ncGroup, ncStep, ncIndent, ncIp)
    VALUES (N_COMMENT_SEQ.NEXTVAL, 1, 'bbb', '1�� ����� ���1�� ���1', 
    1, 3, 2, '192.168.10.152');
SELECT * FROM N_COMMENT ORDER BY NCGROUP DESC, NCSTEP;

---------------------------------------------------------------------------
--               ����ȭ�鿡 ����Խ��� �ֱ� 8�� ���� DTO ��������               --
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





