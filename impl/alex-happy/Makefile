build:
	alex -g Lexer.x
	happy -g Parser.y
	ghc --make Main -O2 -o calc-alex-happy

install:
	install -Dm755 calc-alex-happy -t $(out)/bin
