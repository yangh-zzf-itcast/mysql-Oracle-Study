--1 ������ռ�
--ע���ռ��·�� ����ʵ�ʰ�װ�������е���D:\Oraclesql\app\oradata\orcl
create tablespace ts_myscott
       logging
       datafile 'D:/Oraclesql/app/oradata/orcl/ts_myscott.dbf' size 10M
       extent MANAGEMENT local; 
       
create tablespace ts_myscott2
       logging
       datafile 'D:/Oraclesql/app/oradata/orcl/ts_myscott2.dbf' size 20M
       extent MANAGEMENT local; 

--��С����չ    
alter database datafile 'D:/Oraclesql/app/oradata/orcl/ts_myscott.dbf' autoextend on next  10M maxsize unlimited;
alter database datafile 'D:/Oraclesql/app/oradata/orcl/ts_myscott2.dbf' autoextend on next  20M maxsize unlimited;

commit;

--2 ���������������û���
--users ��ȻoracleĬ�ϱ�ռ�
create user myscott profile default
       identified by myscott default tablespace users
       account unlock;

-- ��Դ�͵�¼Ȩ��
grant resource to myscott;
grant create session to myscott;

--3 ������
--  �������ű��Ҹ�ֵ����������ʵ��dba������ִ��
create table myscott.DEPT(
       DEPTNO   number(2) primary key,  --����
       DNAME    varchar2(14) not null,  --�ǿ���������
       LOC      varchar2(13)
)tablespace ts_myscott;

--  ��������
insert into myscott.DEPT values(10,'ACCOUNTING','NEW YORK');
insert into myscott.DEPT values(20,'RESEARCH','DALLAS');
insert into myscott.DEPT values(30,'SALES','CHICAGO');
insert into myscott.DEPT values(40,'OPERATIONS','BOSTON');

commit;

--  ����Ա�����Ҹ�ֵ
create table myscott.EMP(
       EMPNO    number(4) constraint emp_empno_pk primary key,
       ENAME    varchar2(10) constraint emp_ename_notnull not null,
       JOB      varchar2(9),
       MGR      number(4),
       HIREDATE date,
       SAL      number(7,2) constraint emp_sal_check check (sal>0),
       COMM     number(7,2),
       DEPTNO   number(2) constraint emp_deptno_fk references myscott.DEPT(deptno) --���
)tablespace ts_myscott;

--  �������������µı�ռ���
create index myscott.IX_CAtbAuditOperInfo_OT on myscott.EMP(ENAME) tablespace ts_myscott2;

insert into myscott.EMP values(7069,'SMITH','CLARK',7902,'17-12��-80',800,NULL,20);
insert into myscott.EMP values(7499,'ALEEN','SALESMAN',7698,'20-2��-81',1600,300,30);
insert into myscott.EMP values(7521,'WARD','SALESMAN',7698,'22-2��-81',1250,500,30);

insert into myscott.EMP values(7566,'JONES','MANAGER',7839,'02-4��-81',2975,NULL,20);
insert into myscott.EMP values(7654,'MARTIN','SALESMAN',7698,'28-9��-81',1250,1400,30);
insert into myscott.EMP values(7698,'BALCK','MANAGER',7839,'01-5��-81',2850,NULL,30);

insert into myscott.EMP values(7782,'CLARK','MANAGER',7839,'09-6��-81',2450,NULL,10);
insert into myscott.EMP values(7788,'SCOTT','ANALYST',7566,'19-4��-87',3000,NULL,20);
insert into myscott.EMP values(7839,'KING','PRISIDENT',NULL,'17-11��-81',5000,NULL,10);

insert into myscott.EMP values(7844,'TURNER','SALESMAN',7698,'08-9��-81',1500,0,30);
insert into myscott.EMP values(7876,'ADAMS','CLARK',7788,'23-5��-87',1100,NULL,20);
insert into myscott.EMP values(7900,'JAMES','CLARK',7698,'03-12��-81',950,NULL,20);

insert into myscott.EMP values(7902,'FORD','ANALYST',7566,'03-12��-81',3000,NULL,20);
insert into myscott.EMP values(7934,'MILLER','CLARK',7782,'23-1��-82',1300,NULL,20);

commit;

--  �������ʼ�������Ҹ�ֵ
create table myscott.SALGRADE(
       GRADE            number,
       LOSAL            number,
       HISAL            number
)tablespace ts_myscott;

--  ������������Ҹ�ֵ
create table myscott.BONUS(
       ENAME            varchar2(10),
       JOB              varchar2(9),
       SAL              number,
       COMM             number
)tablespace ts_myscott;

------ֹͣ--------

--4 �������û�����    ͨ��myscottuser1���������ݿ⣬Ȩ��������ʾ
--  ��ѯ�û�,      ���Բ�ѯ������
create user "MYSCOTTUSER1" profile DEFAULT
       identified by "123456" DEFAULT tablespace users
       account unlock;
/*
create user myscott profile default
       identified by myscott default tablespace users
       account unlock;     
*/   

grant "CONNECT" to "MYSCOTTUSER1";
grant select any table to "MYSCOTTUSER1";   --any , ���Բ�ѯ�κα�

grant delete on myscott.DEPT to "MYSCOTTUSER1";
grant insert on myscott.DEPT to "MYSCOTTUSER1";
grant update on myscott.DEPT to "MYSCOTTUSER1";

grant delete on myscott.EMP to "MYSCOTTUSER1";
grant insert on myscott.EMP to "MYSCOTTUSER1";
grant update on myscott.EMP to "MYSCOTTUSER1";

commit;

