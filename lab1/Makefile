CC = g++

CFLAGS = -g -Wall -lsqlite3

all: search.o graph_accessor.o neighbor_struct.o lab1.o debug.h
	$(CC) $(CFLAGS) *.o -o program.out

search.o: search.cpp search.h
	$(CC) $(CFLAGS) -c search.cpp

graph_accessor.o: graph_accessor.cpp graph_accessor.h 
	$(CC) $(CFLAGS) -c graph_accessor.cpp

neighbor_struct.o: neighbor_struct.cpp
	$(CC) $(CFLAGS) -c neighbor_struct.cpp

lab1.o: lab1.cpp
	$(CC) $(CFLAGS) -c lab1.cpp

run: all
	./program.out

runn: clean run

clean:
	rm -f *.out *.o