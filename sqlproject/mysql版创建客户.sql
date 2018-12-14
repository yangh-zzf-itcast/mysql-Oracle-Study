--如果scott不存在就创建scott用户，字段为utf8类型
create database if not exists scott character set utf8;

--使用用户
use scott;

--创建bonus表
create table bonus
(
   ename VARCHAR(10),
   job   VARCHAR(9),
   sal   int,
   comm  int   
);

--创建dept表
create table dept
(
   deptno int not null,
   dname VARCHAR(10),
   loc   VARCHAR(9)  
);  

--设置约束
alter table dept 
   add constraint PK_DEPT primary key (deptno);  --主键为deptno

--创建emp表
create table emp
(
   empno int not null,
   ename VARCHAR(10),
   job   VARCHAR(9),
   mgr   int,
   hiredate DATE,
   sal   int,
   comm  int,
   deptno int     
);
--设置约束
alter table emp
  add constraint PK_RMP primary key (EMPNO);
alter table emp
  add constraint PK_DEPTNO foreign key (DEPTNO)    --字段名不区分大小写
  references dept(DEPTNO);
--references DEPT(DEPTNO);    在mysql中表名是区分大小写的，因此这样写是错误的

create table salgrade
(
   grade int,
   losal int,
   hisal int 
);  

insert into dept values(10,'ACCOUNTING','NEW YORK');
insert into dept values(20,'RESEARCH','DALLAS');
insert into dept values(30,'SALES','CHICAGO');
insert into dept values(40,'OPERATIONS','BOSTON');

insert into emp values(7069,'SMITH','CLARK',7902,'1980-12-17',800,NULL,20);
insert into emp values(7499,'ALEEN','SALESMAN',7698,'1981-02-20',1600,300,30);
insert into emp values(7521,'WARD','SALESMAN',7698,'1981-02-22',1250,500,30);

insert into emp values(7566,'JONES','MANAGER',7839,'1981-02-04',2975,NULL,20);
insert into emp values(7654,'MARTIN','SALESMAN',7698,'1981-09-18',1250,1400,30);
insert into emp values(7698,'BALCK','MANAGER',7839,'1981-05-01',2850,NULL,30);

insert into emp values(7782,'CLARK','MANAGER',7839,'1981-06-09',2450,NULL,10);
insert into emp values(7788,'SCOTT','ANALYST',7566,'1981-04-19',3000,NULL,20);
insert into emp values(7839,'KING','PRISIDENT',NULL,'1981-11-17',5000,NULL,10);

insert into emp values(7844,'TURNER','SALESMAN',7698,'1981-09-08',1500,0,30);
insert into emp values(7876,'ADAMS','CLARK',7788,'1987-05-23',1100,NULL,20);
insert into emp values(7900,'JAMES','CLARK',7698,'1981-12-03',950,NULL,20);

insert into emp values(7902,'FORD','ANALYST',7566,'1981-03-21',3000,NULL,20);
insert into emp values(7934,'MILLER','CLARK',7782,'1982-01-23',1300,NULL,20);

insert into salgrade values(1,700,1200);
insert into salgrade values(2,1201,1400);
insert into salgrade values(3,1401,2000);
insert into salgrade values(4,2001,3000);
insert into salgrade values(5,3001,9999);

 
