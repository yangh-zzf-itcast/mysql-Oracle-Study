//insert 向数据库中新增插入数据

#include "mysql.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define _HOST_	 "127.0.0.1"	//主机
#define _USER_	 "root"			//用户
#define _PASSWD_ "123456"		//密码
#define _DB_	 "scott"		//数据库名

int main()
{
	MYSQL *mysql = NULL;

	//1.mysql_init();
	mysql = mysql_init(NULL);
	if(mysql == NULL){
		printf("mysql init err\n");
		exit(1);
	}

	//2.mysql_real_connect();
	mysql = mysql_real_connect(mysql, _HOST_, _USER_, _PASSWD_, _DB_,
								0, NULL, 0);
	if(mysql == NULL){
		printf("mysql_real_connect err\n");
		exit(1);
	}

	printf("welcome to mysql!!\n");
	
	//string sql = "use scott;insert into emp values(7069,'YANGHANG','CLARK',7902,'1980-12-17',800,NULL,20);";
	//int ret = mysql_query(mysql, sql.c_str());
	const char *sql =  "insert into scott.emp values(8000,'YANGHANG','CLARK',7902,'1995-08-20',8000,NULL,20);";
	int ret = mysql_query(mysql, sql);
	if(ret == 1){
		printf("mysql_query err\n");
		exit(1);
	}else{
		printf("insert success!\n");
	}

	//3.mysql_close();
	mysql_close(mysql);
	return 0;
}
