/*第1题Top-N问题，求工资前三的员工信息*/
/*select rownum,empno,ename,sal 
   from (select * from emp order by sal desc) 
 where rownum<=3;
*/

/*第一题扩展，分页问题，求工资5-8名的员工信息*/
/*
select *
   from (select rownum r,empno,ename,sal
            from (select * from emp order by sal desc)
          where rownum<=8)
 where r>4;
*/

/*第二题，各部门大于各部门平均薪水的员工信息*/
/*方法1.*/
/*
select empno,ename,sal,avgsal
 from (select deptno, avg(sal) avgsal
          from emp
       group by deptno) a,emp e
where a.deptno=e.deptno
 and e.sal>=a.avgsal;
*/
 
/*方法2.求10号部门大于该部门平均薪水的员工*/
/*
select empno,ename,sal,(select avg(sal) from emp where deptno=e.deptno) tenavgsal
   from emp e
 where sal>(select avg(sal) from emp where  deptno=e.deptno);
*/

/*第三题。统计每年入职员工*/
/*
select count(*) "Total", sum(decode(to_char(hiredate,'yyyy'),'1980',1,0)) "1980",
sum(decode(to_char(hiredate,'yyyy'),'1981',1,0)) "1981",
sum(decode(to_char(hiredate,'yyyy'),'1982',1,0)) "1982",
sum(decode(to_char(hiredate,'yyyy'),'1987',1,0)) "1987"   
 from emp;
*/
