build:
	alex -g Lexer.x
	happy -g Parser.y
	ghc Main -O2 -o $(pname)

install:
	install -Dm755 $(pname) -t $(out)/bin
