#gcc hello_mysql.c -o hello_mysql -I/usr/include/mysql/ -L/usr/lib/x86_64-linux-gnu/ -lmysqlclient 

source=$(wildcard *.c)
targets=$(patsubst %.c, %, $(source))

CC=gcc
IncPath=/usr/include/mysql/
LibPath=/usr/lib/x86_64-linux-gnu/
PubLib=-lmysqlclient 
FLAGS=-W -g

all:$(targets)

%:%.c
	$(CC) $? -o $@ -I$(IncPath) -L$(LibPath) $(PubLib) $(FLAGS)

clean:
	rm -f $(targets)
