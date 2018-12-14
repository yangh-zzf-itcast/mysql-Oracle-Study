create or replace view myview as
select e.empno,e.ename,e.sal,e.sal*12 annualsal,e.sal*12+nvl(comm,0) income,d.dname
   from emp e,dept d
  where e.deptno=d.deptno;
