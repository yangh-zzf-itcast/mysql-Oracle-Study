create table employee(id int,
                  name varchar(20),
                  sex int,
                  birthday date,
                  salary double,
                  entry_date date,
                  resume text
);
insert into employee values(1,'叶开',1,'1983-04-27',15000,'2012-06-24','一个大牛');
insert into employee(id,name,sex,birthday,salary,entry_date,resume) values(2,'张三',1,'1984-02-22',10000,'2012-07-24','一个中牛');
insert into employee(id,name,sex,birthday,salary,entry_date,resume) values(3,'李美',0,'1984-08-28',10000,'2012-08-24','一个小牛');


create table student(id int,
                  name varchar(20),
                  chinese int,
                  english int,
                  math int
);

insert into student values(1,'杨航',95,95,98);
insert into student values(2,'李凡',86,95,94);
insert into student values(3,'吕葛亮',97,93,96);
insert into student values(4,'周盼',88,86,89);
insert into student values(5,'何必峰',85,86,89);
insert into student values(6,'何晶',94,98,97);
insert into student values(7,'李学双',86,89,93);
insert into student values(8,'蓝师伟',87,99,97);

alter table student add class_id int;
update student set class_id=ceil(id/4);

select avg(math),class_id from student group by class_id;   
