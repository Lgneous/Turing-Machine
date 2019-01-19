%token <string> STRING
%token LEFT_BRACE
%token RIGHT_BRACE
%token LEFT_BRACK
%token RIGHT_BRACK
%token COLON
%token COMMA
%token EOF

%start <Syntax.ast> prog
%%

prog:
  | assoc EOF { $1 }

value:
  | assoc { $1 }
  | list { $1 }
  | STRING { Syntax.String $1 }

assoc:
  | LEFT_BRACE separated_list(COMMA, assoc_elem) RIGHT_BRACE { Syntax.Assoc $2}

assoc_elem:
  | STRING COLON value { ($1, $3) }

list:
  | LEFT_BRACK separated_list(COMMA, value) RIGHT_BRACK { Syntax.List $2 }
