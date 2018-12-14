/*
create table testsql(tid number,tname varchar2(20));
insert into testsql values(1,'Tom');
insert into testsql values(2,'Mike');
savepoint aaa;
insert into testsql values(3,'Marry');
savepoint bbb;
select * from testsql;
*/
/*
delete from testsql where tid=3;
select * from testsql;
*/

/*
rollback to aaa;
select * from testsql;
*/

/*
rollback
select * from testsql;
*/
