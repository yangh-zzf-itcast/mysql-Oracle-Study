create table employee(id int,
                  name varchar(20),
                  sex int,
                  birthday date,
                  salary double,
                  entry_date date,
                  resume text
);
insert into employee values(1,'Ҷ��',1,'1983-04-27',15000,'2012-06-24','һ����ţ');
insert into employee(id,name,sex,birthday,salary,entry_date,resume) values(2,'����',1,'1984-02-22',10000,'2012-07-24','һ����ţ');
insert into employee(id,name,sex,birthday,salary,entry_date,resume) values(3,'����',0,'1984-08-28',10000,'2012-08-24','һ��Сţ');


create table student(id int,
                  name varchar(20),
                  chinese int,
                  english int,
                  math int
);

insert into student values(1,'�',95,95,98);
insert into student values(2,'�',86,95,94);
insert into student values(3,'������',97,93,96);
insert into student values(4,'����',88,86,89);
insert into student values(5,'�αط�',85,86,89);
insert into student values(6,'�ξ�',94,98,97);
insert into student values(7,'��ѧ˫',86,89,93);
insert into student values(8,'��ʦΰ',87,99,97);

alter table student add class_id int;
update student set class_id=ceil(id/4);

select avg(math),class_id from student group by class_id;   
