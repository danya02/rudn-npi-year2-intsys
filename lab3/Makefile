all: calc.so

calc.so: calc.cpp calc.h
	g++ -fPIC -shared -o calc.so calc.cpp

clean: 
	rm -f calc.so *.png