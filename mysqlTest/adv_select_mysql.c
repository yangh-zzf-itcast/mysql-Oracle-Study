//select 查询数据库 功能完善 加入表头和获取字段个数
#include "mysql.h"
#include <stdio.h>
#include <stdlib.h>
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


	//添加业务代码
	//执行查询
	if(mysql_query(mysql, "select * from emp;")){
		printf("mysql_query err\n");
		exit(1);
	}
	
	//处理查询结果集
	MYSQL_RES *result = mysql_store_result(mysql);
	
	unsigned int num_fields;
	unsigned int i;
	MYSQL_FIELD *fields;
	 
	num_fields = mysql_num_fields(result);
	fields = mysql_fetch_fields(result);
	//打印表头
	for(i = 0; i < num_fields; i++)
	{
	   printf("%s\t", fields[i].name);		//打印字段名
	}
  printf("\n");	
  
	//打印数据
	MYSQL_ROW row;
	if(result != NULL){
		while((row = mysql_fetch_row(result))){
			for(i = 0;i < num_fields;i++){		//针对列的循环，一共是num_fields个数据
				printf("%s\t", row[i]);
			}
			printf("\n");		//一行处理结束，此处进行换行
		}
		mysql_free_result(result);
	}


	//3.mysql_close();
	mysql_close(mysql);
	return 0;
}
