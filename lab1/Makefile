CC = g++

CFLAGS = -g -Wall

all: lab1.o
	$(CC) $(CFLAGS) lab1.o -o program.out

lab1.o: lab1.cpp
	$(CC) $(CFLAGS) -c lab1.cpp

clean:
	rm -f program.out lab1.o