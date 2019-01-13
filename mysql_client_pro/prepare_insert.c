// insert 向数据库中新增插入数据
// 使用mysql 预处理 语句
#include "mysql.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define _HOST_	 "127.0.0.1"	//主机
#define _USER_	 "root"			//用户
#define _PASSWD_ "123456"		//密码
#define _DB_	 "scott"		//数据库名

#define STRING_SIZE 50
 
#define DROP_SAMPLE_TABLE 	"DROP TABLE IF EXISTS test_table"
#define CREATE_SAMPLE_TABLE "CREATE TABLE test_table(col1 INT,\
                                                 col2 VARCHAR(40),\
                                                 col3 SMALLINT,\
                                                 col4 TIMESTAMP)"

// ？，？，？表示占位，等待 bind 补充
#define INSERT_SAMPLE 		"INSERT INTO test_table(col1,col2,col3) VALUES(?,?,?)"

void prepare_insert(MYSQL *mysql);		//insert预处理

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
	
	prepare_insert(mysql);

	//3.mysql_close();
	mysql_close(mysql);
	return 0;
}


void prepare_insert(MYSQL *mysql)
{
	MYSQL_STMT    *stmt;			//预处理句柄
	MYSQL_BIND    bind[3];			//绑定参数，个数跟？的个数有关
	my_ulonglong  affected_rows;	
	int           param_count;
	short         small_data;
	int           int_data;
	char          str_data[STRING_SIZE];
	unsigned long str_length;
	my_bool       is_null;
 
	if (mysql_query(mysql, DROP_SAMPLE_TABLE))		//删除表
	{
		fprintf(stderr, " DROP TABLE failed\n");
	    fprintf(stderr, " %s\n", mysql_error(mysql));
	    exit(0);
	}
	 
	if (mysql_query(mysql, CREATE_SAMPLE_TABLE))	//创建表
	{
	    fprintf(stderr, " CREATE TABLE failed\n");
	    fprintf(stderr, " %s\n", mysql_error(mysql));
	    exit(0);
	}
	 
	/* Prepare an INSERT query with 3 parameters */
	/* (the TIMESTAMP column is not named; the server */
	/*  sets it to the current date and time) */
	
	stmt = mysql_stmt_init(mysql);
	if (!stmt)
	{
	    fprintf(stderr, " mysql_stmt_init(), out of memory\n");
	    exit(0);
	}
	
	//预处理语句准备
	if (mysql_stmt_prepare(stmt, INSERT_SAMPLE, strlen(INSERT_SAMPLE)))		
	{
	    fprintf(stderr, " mysql_stmt_prepare(), INSERT failed\n");
	    fprintf(stderr, " %s\n", mysql_stmt_error(stmt));
	    exit(0);
	}
	fprintf(stdout, " prepare, INSERT successful\n");
	 
	/* 获取预处理的语句的参数个数，此处为3 */
	param_count= mysql_stmt_param_count(stmt);
	fprintf(stdout, " total parameters in INSERT: %d\n", param_count);
	 
	if (param_count != 3) /* validate parameter count */
	{
	    fprintf(stderr, " invalid parameter count returned by MySQL\n");
	    exit(0);
	}
	 
	/* 为3个参数绑定数据，赋值内存映射关系 */
	 
	memset(bind, 0, sizeof(bind));
	 
	/* INTEGER PARAM */
	/* This is a number type, so there is no need to specify buffer_length */
	bind[0].buffer_type= MYSQL_TYPE_LONG;
	bind[0].buffer= (char *)&int_data;		//内存映射，取到int_data的值
	bind[0].is_null= 0;
	bind[0].length= 0;
	 
	/* STRING PARAM */		//字符串的赋值，需要字符串的长度
	bind[1].buffer_type= MYSQL_TYPE_STRING;
	bind[1].buffer= (char *)str_data;
	bind[1].buffer_length= STRING_SIZE;
	bind[1].is_null= 0;
	bind[1].length= &str_length;
	 
	/* SMALLINT PARAM */
	bind[2].buffer_type= MYSQL_TYPE_SHORT;
	bind[2].buffer= (char *)&small_data;
	bind[2].is_null= &is_null;				//是否为null的指示器
	bind[2].length= 0;
	 
	/* Bind the buffers */
	if (mysql_stmt_bind_param(stmt, bind))	//绑定变量 参数绑定
	{
	    fprintf(stderr, " mysql_stmt_bind_param() failed\n");
	    fprintf(stderr, " %s\n", mysql_stmt_error(stmt));
	    exit(0);
	}
	 
	/* 第一次赋值 */
	/* INSERT INTO test_table(col1,col2,col3) VALUES(10,'MySQL',null) */
	int_data= 10;             /* integer */
	strncpy(str_data, "MySQL", STRING_SIZE); /* string  */
	str_length= strlen(str_data);
	 
	/* 表示插入的第三个字段是否为null，1表示空，插入数据也无效，0表示非空 */
	is_null= 1;					
	 
	/* Execute the INSERT statement - 1*/
	if (mysql_stmt_execute(stmt))	//预处理执行，第一次执行
	{
	    fprintf(stderr, " mysql_stmt_execute(), 1 failed\n");
	    fprintf(stderr, " %s\n", mysql_stmt_error(stmt));
	    exit(0);
	}
	 
	/* 预处理的影响条数 */
	affected_rows= mysql_stmt_affected_rows(stmt);	
	fprintf(stdout, " total affected rows(insert 1): %lu\n",
	                (unsigned long) affected_rows);
	 
	if (affected_rows != 1) /* validate affected rows */
	{
	    fprintf(stderr, " invalid affected rows by MySQL\n");
	    exit(0);
	}
	 
	/* 第二次赋值 */
	/* INSERT INTO test_table(col1,col2,col3) VALUES(1000,'The most popular Open Source database',1000) */
	int_data= 1000;
	strncpy(str_data, "The most popular Open Source database", STRING_SIZE);
	str_length= strlen(str_data);
	small_data= 1000;         /* smallint */
	is_null= 0;               /* reset */
	 
	/* Execute the INSERT statement - 2*/
	if (mysql_stmt_execute(stmt))
	{
	    fprintf(stderr, " mysql_stmt_execute, 2 failed\n");
	    fprintf(stderr, " %s\n", mysql_stmt_error(stmt));
	    exit(0);
	}
	 
	/* Get the total rows affected */
	affected_rows= mysql_stmt_affected_rows(stmt);
	fprintf(stdout, " total affected rows(insert 2): %lu\n",
	                (unsigned long) affected_rows);
	 
	if (affected_rows != 1) /* validate affected rows */
	{
	    fprintf(stderr, " invalid affected rows by MySQL\n");
	    exit(0);
	}
	 
	/* Close the statement */
	if (mysql_stmt_close(stmt))
	{
	    fprintf(stderr, " failed while closing the statement\n");
	    fprintf(stderr, " %s\n", mysql_stmt_error(stmt));
	    exit(0);
	}
}
