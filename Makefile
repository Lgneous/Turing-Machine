.PHONY: all clean byte native profile debug sanity

OCB_FLAGS = -use-menhir -use-ocamlfind -I src
OCB = ocamlbuild $(OCB_FLAGS)
LIB = batteries

NAME = turing

all: native byte

clean:
	rm -rf _build

fclean:
	$(OCB) -clean

re: fclean all

native: sanity
	$(OCB) $(NAME).native

byte: sanity
	$(OCB) $(NAME).byte

profile: sanity
	$(OCB) -tag profile $(NAME).native

debug: sanity
	$(OCB) -tag debug $(NAME).byte

sanity:
	ocamlfind query $(LIB)
