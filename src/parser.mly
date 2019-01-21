%{
    open Batteries
	 %}

%token <string> STRING
%token <string> CHAR
%token NAME
%token ALPHABET
%token BLANK
%token STATES
%token INITIAL
%token FINALS
%token TRANSITIONS
%token READ
%token TO_STATE
%token WRITE
%token ACTION
%token LEFT
%token RIGHT
%token LEFT_BRACE
%token RIGHT_BRACE
%token LEFT_BRACK
%token RIGHT_BRACK
%token COLON
%token COMMA
%token EOF

%start <Syntax.t> prog
%%

prog:
  | LEFT_BRACE NAME COLON; n = string; COMMA ALPHABET COLON LEFT_BRACK; a = separated_list(COMMA, CHAR);
RIGHT_BRACK COMMA BLANK COLON; b = CHAR; COMMA STATES COLON LEFT_BRACK; s = separated_list(COMMA, string);
RIGHT_BRACK COMMA INITIAL COLON; i = string; COMMA FINALS COLON LEFT_BRACK; f = separated_list(COMMA, string);
RIGHT_BRACK COMMA TRANSITIONS COLON LEFT_BRACE; t = separated_list(COMMA, assoc); RIGHT_BRACE RIGHT_BRACE EOF
    {
      {
	Syntax.name = n;
	Syntax.alphabet = a;
	Syntax.blank = b;
	Syntax.states = s;
	Syntax.initial = i;
	Syntax.finals = f;
	Syntax.transitions = Hashtbl.of_list t
      }
    }

string:
  | NAME { "name" }
  | ALPHABET { "alphabet" }
  | BLANK { "blank" }
  | STATES { "states" }
  | INITIAL { "initial" }
  | FINALS { "finals" }
  | TRANSITIONS { "transitions" }
  | READ { "read" }
  | TO_STATE { "to_state" }
  | WRITE { "write" }
  | ACTION { "action" }
  | LEFT { "left" }
  | RIGHT { "right" }
  | STRING | CHAR { $1 }

assoc:
  | string COLON LEFT_BRACK separated_list(COMMA, transi) RIGHT_BRACK { ($1, $4) }

transi:
  | LEFT_BRACE READ COLON CHAR COMMA TO_STATE COLON string COMMA WRITE COLON CHAR COMMA ACTION COLON LEFT RIGHT_BRACE { {Transition.read = $4; Transition.to_state = $8; Transition.write = $12; Transition.action = Transition.Left} }
  | LEFT_BRACE READ COLON CHAR COMMA TO_STATE COLON string COMMA WRITE COLON CHAR COMMA ACTION COLON RIGHT RIGHT_BRACE { {Transition.read = $4; Transition.to_state = $8; Transition.write = $12; Transition.action = Transition.Right} }
