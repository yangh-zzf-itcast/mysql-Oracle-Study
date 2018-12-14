--1 创建表空间
--注意表空间的路径 根据实际安装环境进行调整D:\Oraclesql\app\oradata\orcl
create tablespace ts_myscott
       logging
       datafile 'D:/Oraclesql/app/oradata/orcl/ts_myscott.dbf' size 10M
       extent MANAGEMENT local; 
       
create tablespace ts_myscott2
       logging
       datafile 'D:/Oraclesql/app/oradata/orcl/ts_myscott2.dbf' size 20M
       extent MANAGEMENT local; 

--大小可扩展    
alter database datafile 'D:/Oraclesql/app/oradata/orcl/ts_myscott.dbf' autoextend on next  10M maxsize unlimited;
alter database datafile 'D:/Oraclesql/app/oradata/orcl/ts_myscott2.dbf' autoextend on next  20M maxsize unlimited;

commit;

--2 创建方案（创建用户）
--users 当然oracle默认表空间
create user myscott profile default
       identified by myscott default tablespace users
       account unlock;

-- 资源和登录权限
grant resource to myscott;
grant create session to myscott;

--3 创建表
--  创建部门表并且赋值，整个环境实在dba环境下执行
create table myscott.DEPT(
       DEPTNO   number(2) primary key,  --主键
       DNAME    varchar2(14) not null,  --非空限制条件
       LOC      varchar2(13)
)tablespace ts_myscott;

--  插入数据
insert into myscott.DEPT values(10,'ACCOUNTING','NEW YORK');
insert into myscott.DEPT values(20,'RESEARCH','DALLAS');
insert into myscott.DEPT values(30,'SALES','CHICAGO');
insert into myscott.DEPT values(40,'OPERATIONS','BOSTON');

commit;

--  创建员工表并且赋值
create table myscott.EMP(
       EMPNO    number(4) constraint emp_empno_pk primary key,
       ENAME    varchar2(10) constraint emp_ename_notnull not null,
       JOB      varchar2(9),
       MGR      number(4),
       HIREDATE date,
       SAL      number(7,2) constraint emp_sal_check check (sal>0),
       COMM     number(7,2),
       DEPTNO   number(2) constraint emp_deptno_fk references myscott.DEPT(deptno) --外键
)tablespace ts_myscott;

--  创建索引，在新的表空间上
create index myscott.IX_CAtbAuditOperInfo_OT on myscott.EMP(ENAME) tablespace ts_myscott2;

insert into myscott.EMP values(7069,'SMITH','CLARK',7902,'17-12月-80',800,NULL,20);
insert into myscott.EMP values(7499,'ALEEN','SALESMAN',7698,'20-2月-81',1600,300,30);
insert into myscott.EMP values(7521,'WARD','SALESMAN',7698,'22-2月-81',1250,500,30);

insert into myscott.EMP values(7566,'JONES','MANAGER',7839,'02-4月-81',2975,NULL,20);
insert into myscott.EMP values(7654,'MARTIN','SALESMAN',7698,'28-9月-81',1250,1400,30);
insert into myscott.EMP values(7698,'BALCK','MANAGER',7839,'01-5月-81',2850,NULL,30);

insert into myscott.EMP values(7782,'CLARK','MANAGER',7839,'09-6月-81',2450,NULL,10);
insert into myscott.EMP values(7788,'SCOTT','ANALYST',7566,'19-4月-87',3000,NULL,20);
insert into myscott.EMP values(7839,'KING','PRISIDENT',NULL,'17-11月-81',5000,NULL,10);

insert into myscott.EMP values(7844,'TURNER','SALESMAN',7698,'08-9月-81',1500,0,30);
insert into myscott.EMP values(7876,'ADAMS','CLARK',7788,'23-5月-87',1100,NULL,20);
insert into myscott.EMP values(7900,'JAMES','CLARK',7698,'03-12月-81',950,NULL,20);

insert into myscott.EMP values(7902,'FORD','ANALYST',7566,'03-12月-81',3000,NULL,20);
insert into myscott.EMP values(7934,'MILLER','CLARK',7782,'23-1月-82',1300,NULL,20);

commit;

--  创建工资级别表，并且赋值
create table myscott.SALGRADE(
       GRADE            number,
       LOSAL            number,
       HISAL            number
)tablespace ts_myscott;

--  创建奖金表，并且赋值
create table myscott.BONUS(
       ENAME            varchar2(10),
       JOB              varchar2(9),
       SAL              number,
       COMM             number
)tablespace ts_myscott;

------停止--------

--4 创建新用户方案    通过myscottuser1来访问数据库，权限配置演示
--  查询用户,      可以查询各个表
create user "MYSCOTTUSER1" profile DEFAULT
       identified by "123456" DEFAULT tablespace users
       account unlock;
/*
create user myscott profile default
       identified by myscott default tablespace users
       account unlock;     
*/   

grant "CONNECT" to "MYSCOTTUSER1";
grant select any table to "MYSCOTTUSER1";   --any , 可以查询任何表

grant delete on myscott.DEPT to "MYSCOTTUSER1";
grant insert on myscott.DEPT to "MYSCOTTUSER1";
grant update on myscott.DEPT to "MYSCOTTUSER1";

grant delete on myscott.EMP to "MYSCOTTUSER1";
grant insert on myscott.EMP to "MYSCOTTUSER1";
grant update on myscott.EMP to "MYSCOTTUSER1";

commit;

