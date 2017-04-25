%{
open Core.Std
%}

(* tokens *)
%token LPAR RPAR EOF

%start <unit> ast_eof

%%

ast_eof:
  | a=ast; EOF { a }
  ;

ast:
  | LPAR; RPAR { () }
  ;

%%
