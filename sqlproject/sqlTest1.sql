/* 等值连接
select d.deptno,d.dname,count(*)
  from dept d,emp e
where d.deptno=e.deptno(+)
group by d.deptno,d.dname
order by 1;
*/

/*外连接
select d.deptno,d.dname,count(e.empno)
  from dept d,emp e
where d.deptno=e.deptno(+)
group by d.deptno,d.dname
order by 1;
*/

/*自连接---特殊的外连接
select e.ename||'''s boss is '||nvl(b.ename,'himself')
   from emp e,emp b
where b.empno(+)=e.mgr
*/





