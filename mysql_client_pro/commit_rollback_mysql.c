// mysql数据库事务的操作
// 手动提交与回滚
// 自动提交

#include "mysql.h"
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#define SET_TRAN		"SET AUTOCOMMIT=0"		//手动commit，提交事务。oracle数据库默认模式
#define UNSET_TRAN		"SET AUTOCOMMIT=1"		//自动commit，提交事务。mysql数据库默认模式

#define _HOST_	 "127.0.0.1"	//主机
#define _USER_	 "root"			//用户
#define _PASSWD_ "123456"		//密码
#define _DB_	 "scott"		//数据库名

//制表语句，创建一个 test_table 表
#define DROP_SAMPLE_TABLE 	"DROP TABLE IF EXISTS test_table"
#define CREATE_SAMPLE_TABLE "CREATE TABLE test_table(col1 INT,\
                                                 col2 VARCHAR(40),\
                                                 col3 VARCHAR(20),\
                                                 col4 TIMESTAMP)"

//插入数据语句
#define SQL01 "INSERT INTO test_table(col1,col2,col3) VALUES(10, 'AAA', 'A1')"
#define SQL02 "INSERT INTO test_table(col1,col2,col3) VALUES(20, 'BBB', 'B1')"
#define SQL03 "INSERT INTO test_table(col1,col2,col3) VALUES(30, 'CCC', 'C1')"
#define SQL04 "INSERT INTO test_table(col1,col2,col3) VALUES(40, 'DDD', 'D1')"

//函数封装

//设置事务为手动提交
int mysql_OperationTran(MYSQL *mysql)
{
	//开始事务
	int ret = mysql_query(mysql, "start transaction");
	if(ret != 0){
		printf("mysql_OperationTran query start err:%s\n", mysql_error(mysql));
		return ret;
	}
	
	//设置事务为手动提交
	ret = mysql_query(mysql, SET_TRAN);		//"SET AUTOCOMMIT=0"	
	if(ret != 0){
		printf("mysql_OperationTran query set err:%s\n", mysql_error(mysql));
		return ret;
	}
	
	return ret;
}

//设置事务为自动提交
int mysql_AutoTran(MYSQL *mysql)
{
	//开始事务
	int ret = mysql_query(mysql, "start transaction");
	if(ret != 0){
		printf("mysql_AutoTran query start err:%s\n", mysql_error(mysql));
		return ret;
	}
	
	//设置事务为手动提交
	ret = mysql_query(mysql, UNSET_TRAN);	//"SET AUTOCOMMIT=1"	
	if(ret != 0){
		printf("mysql_AutoTran query set err:%s\n", mysql_error(mysql));
		return ret;
	}
	
	return ret;
}

//执行commit，手动提交事务
int mysql_Commit(MYSQL *mysql)
{
	int ret = mysql_query(mysql, "COMMIT");		//提交
	if(ret != 0){
		printf("commit err: %s\n", mysql_error(mysql));
		return ret;
	}
	
	return ret;
}

//执行rollback，回滚事务，回滚到上次提交事务的状态
int mysql_Rollback(MYSQL *mysql)
{
	int ret = mysql_query(mysql, "ROLLBACK");		//提交
	if(ret != 0){
		printf("rollback err: %s\n", mysql_error(mysql));
		return ret;
	}
	
	return ret;
}

//执行mysql语句
int mysql_Query(MYSQL *mysql, const char *sql)
{
	int ret = mysql_query(mysql, sql);
	if(ret != 0){
		printf("mysql_query err: %d\n", ret);
		return ret;
	}
}	

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
	int ret = 0;
	MYSQL *mysql = NULL;

	//1.mysql_init();
	mysql = mysql_init(NULL);
	if(mysql == NULL){
		printf("mysql_init err\n");
	}

	//2.mysql_real_connect();
	mysql = mysql_real_connect(mysql, _HOST_, _USER_, _PASSWD_, _DB_,
								0, NULL, 0);
	if(mysql == NULL){
		printf("mysql_real_connect err\n");
	}

	printf("welcome to mysql!!\n");
	
	if (mysql_Query(mysql, DROP_SAMPLE_TABLE))		//删除表
	{
		fprintf(stderr, " DROP TABLE failed\n");
	    fprintf(stderr, " %s\n", mysql_error(mysql));
	    exit(0);
	}
	 
	if (mysql_Query(mysql, CREATE_SAMPLE_TABLE))	//创建表
	{
	    fprintf(stderr, " CREATE TABLE failed\n");
	    fprintf(stderr, " %s\n", mysql_error(mysql));
	    exit(0);
	}
	 
	//开始事务，并且设置事务属性为手动提交commit 
	ret = mysql_OperationTran(mysql);
	if(ret != 0){
		printf("mysql_OperationTran err: %d\n", ret);
		return ret;
	} 
	
	ret = mysql_Query(mysql, SQL01);		//向test_table表中插入第一行数据'AAA'
	if(ret != 0){
		return ret;
	}
	
	ret = mysql_query(mysql, SQL02);		//向test_table表中插入第二行数据'BBB'
	if(ret != 0){
		return ret;
	}
	
	//手动提交模式，插入数据结束后，进行手动提交
	ret = mysql_Commit(mysql);
	if(ret != 0){
		printf("mysql_Commit err: %d\n", ret);
		return ret;
	}
	
	// 插入AAA、BBB 数据结束
	
#if 0
	//开始事务，并且设置事务属性为【自动】提交commit 
	ret = mysql_AutoTran(mysql);
	if(ret != 0){
		printf("mysql_AutoTran err: %d\n", ret);
		return ret;
	} 
#else
	//开始事务，并且设置事务属性为【手动】提交commit 
	ret = mysql_OperationTran(mysql);
	if(ret != 0){
		printf("mysql_OperationTran err: %d\n", ret);
		return ret;
	} 
#endif

	//如果前面设置了【自动】提交，则CCC、DDD的数据无法再rollback
	ret = mysql_query(mysql, SQL03);		//向test_table表中插入第一行数据'CCC'
	if(ret != 0){
		return ret;
	}
	
	ret = mysql_query(mysql, SQL04);		//向test_table表中插入第二行数据'DDD'
	if(ret != 0){
		return ret;
	}

	ret = mysql_Rollback(mysql);
	if(ret != 0){
		printf("mysql_rollback err: %d\n", ret);
		return ret;
	}

/*
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
*/

	//3.mysql_close();
	mysql_close(mysql);
	return 0;
}
