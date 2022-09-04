CC = g++

CFLAGS = -g -Wall -lsqlite3

all: object
	$(CC) $(CFLAGS) *.o -o program.out


object: 
	$(CC) $(CFLAGS) -c *.cpp

run: all
	./program.out

clean:
	rm -f *.out *.o