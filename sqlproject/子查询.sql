/*select * from emp where ename='SCOTT';
select * from emp where sal > 3000;*/

/*�Ӳ�ѯ
select * 
   from emp 
where sal > 
     (select sal 
        from emp 
      where ename='SCOTT');
*/

/*����1
select *
  from emp
 where deptno = (select deptno
                  from dept
                 where dname='SALES');
*/

/*����2
select e.empno Ա����, e.ename ����, e.deptno ���ű��, d.dname ��������
   from dept d, emp e
where e.deptno=d.deptno and e.deptno=10;    
*/

/*select ������Ӳ�ѯ
select empno Ա����, ename Ա������,deptno ���ű��,(select dname from dept where deptno=10) ��������
  from emp
where deptno=10;             
*/

/*from������Ӳ�ѯ
select *
   from (select ename ����, sal нˮ, sal*14 ��н from emp);
*/

/*����3 where������Ӳ�ѯ
select * 
   from emp
 where job=(select job from emp where ename='WARD') and sal > (select sal from emp where ename='WARD');
*/

/*����4 having ������Ӳ�ѯ*/
/*
select deptno, min(sal)
  from emp
 group by deptno
having min(sal) > (select min(sal) from emp where deptno = 30);
*/

/*����5*/
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

/*����6�����в�����any��all���÷�*/
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

/*����7,�Ӳ�ѯ����null*/
/*
select *
  from emp
 where empno not in
        (select mgr from emp where mgr is not null);
*/

select * from emp;
