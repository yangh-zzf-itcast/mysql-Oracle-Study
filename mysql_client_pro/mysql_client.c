// mysql客户端的编写
// ctrl + <- 可以回退

#include "mysql.h"
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#define _HOST_	 "127.0.0.1"	//主机
#define _USER_	 "root"			//用户
#define _PASSWD_ "123456"		//密码
#define _DB_	 "scott"		//数据库名

//函数封装

//打印显示结果集
void show_result(MYSQL_RES *result, MYSQL *mysql)
{
	unsigned int num_fields;
	unsigned int i;
	MYSQL_FIELD *fields;
	 
	num_fields = mysql_num_fields(result);		//获得字段数，列数
	fields = mysql_fetch_fields(result);			//获取字段的数组，是char ** 的结构体
	
	//打印表头
	for(i = 0; i < num_fields; i++)
	{
	   printf("%s\t", fields[i].name);		//打印字段名
	}
 	 printf("\n");	
  
  	printf("-----------------------------------------------------------------------------\n");
  
	//打印数据
	MYSQL_ROW row;		

	while((row = mysql_fetch_row(result))){
		for(i = 0;i < num_fields;i++){		//针对列的循环，一共是num_fields个数据
			printf("%s\t", row[i]);
		}
		printf("\n");		//一行处理结束，此处进行换行
	}	
	printf("-----------------------------------------------------------------------------\n");
	printf("%ld row in set\n",(long) mysql_affected_rows(mysql));
}

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

	//添加业务代码，mysql客户端程序逻辑

	mysql_set_character_set(mysql, "utf8"); 		//设置默认字符集为utf8

	char rSql[512];		//用于获取mysql命令	
	while(1){
		printf("myYHSQL>");
		memset(rSql, 0, sizeof(rSql));
		fgets(rSql, sizeof(rSql), stdin);
		printf("rSql:%s\n", rSql);
		
		if(strncmp(rSql, "quit", 4) == 0 || strncmp(rSql, "Quit", 4) == 0){
			printf("Bye bye!\n");
			break;
		}
		
		//执行 sql 功能命令
		if(mysql_query(mysql, rSql)){
			//printf("mysql_query err\n");
			//exit(1);
			printf("mysql syntax error\n");
			continue;
		}
		
			
		//处理查询结果集，查到的话进行打印输出
		MYSQL_RES *result = mysql_store_result(mysql);
		if(result != NULL){
			show_result(result, mysql);		//打印
			mysql_free_result(result);
		}
	}

	//3.mysql_close();
	mysql_close(mysql);
	return 0;
}
