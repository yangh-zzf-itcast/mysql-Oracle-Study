/*��1��Top-N���⣬����ǰ����Ա����Ϣ*/
/*select rownum,empno,ename,sal 
   from (select * from emp order by sal desc) 
 where rownum<=3;
*/

/*��һ����չ����ҳ���⣬����5-8����Ա����Ϣ*/
/*
select *
   from (select rownum r,empno,ename,sal
            from (select * from emp order by sal desc)
          where rownum<=8)
 where r>4;
*/

/*�ڶ��⣬�����Ŵ��ڸ�����ƽ��нˮ��Ա����Ϣ*/
/*����1.*/
/*
select empno,ename,sal,avgsal
 from (select deptno, avg(sal) avgsal
          from emp
       group by deptno) a,emp e
where a.deptno=e.deptno
 and e.sal>=a.avgsal;
*/
 
/*����2.��10�Ų��Ŵ��ڸò���ƽ��нˮ��Ա��*/
/*
select empno,ename,sal,(select avg(sal) from emp where deptno=e.deptno) tenavgsal
   from emp e
 where sal>(select avg(sal) from emp where  deptno=e.deptno);
*/

/*�����⡣ͳ��ÿ����ְԱ��*/
/*
select count(*) "Total", sum(decode(to_char(hiredate,'yyyy'),'1980',1,0)) "1980",
sum(decode(to_char(hiredate,'yyyy'),'1981',1,0)) "1981",
sum(decode(to_char(hiredate,'yyyy'),'1982',1,0)) "1982",
sum(decode(to_char(hiredate,'yyyy'),'1987',1,0)) "1987"   
 from emp;
*/
