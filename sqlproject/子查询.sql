/*select * from emp where ename='SCOTT';
select * from emp where sal > 3000;*/

/*子查询
select * 
   from emp 
where sal > 
     (select sal 
        from emp 
      where ename='SCOTT');
*/

/*例子1
select *
  from emp
 where deptno = (select deptno
                  from dept
                 where dname='SALES');
*/

/*例子2
select e.empno 员工号, e.ename 姓名, e.deptno 部门编号, d.dname 部门名称
   from dept d, emp e
where e.deptno=d.deptno and e.deptno=10;    
*/

/*select 后放置子查询
select empno 员工号, ename 员工姓名,deptno 部门编号,(select dname from dept where deptno=10) 部门名称
  from emp
where deptno=10;             
*/

/*from后放置子查询
select *
   from (select ename 姓名, sal 薪水, sal*14 年薪 from emp);
*/

/*例子3 where后放置子查询
select * 
   from emp
 where job=(select job from emp where ename='WARD') and sal > (select sal from emp where ename='WARD');
*/

/*例子4 having 后放置子查询*/
/*
select deptno, min(sal)
  from emp
 group by deptno
having min(sal) > (select min(sal) from emp where deptno = 30);
*/

/*例子5*/
/*
select * 
  from dept 
 where dname in('SALES','ACCOUNTING');
select * 
  from emp
 where deptno in(10,30); */
/*
select *
  from emp
 where deptno in
       (select deptno from dept where dname in ('SALES', 'ACCOUNTING'));
*/

/*例子6，多行操作符any和all的用法*/
/*
select * 
    from emp
  where sal>any 
         (select sal from emp where deptno=30);
select * 
   from emp
  where sal>all 
         (select sal from emp where deptno=30);
*/

/*例子7,子查询中有null*/
/*
select *
  from emp
 where empno not in
        (select mgr from emp where mgr is not null);
*/

select * from emp;
