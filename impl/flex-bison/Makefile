build:
	flex calc.l
	bison -d calc.y
	cc *.c -lm -O3 -flto -o $(pname)

install:
	install -Dm755 $(pname) -t $(out)/bin
