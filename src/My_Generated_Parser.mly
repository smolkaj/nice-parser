%{
open Core.Std
%}

(* tokens *)
%token LPAR RPAR EOF

%start <unit> ast_eof

%%

ast_eof:
  | ast; EOF { () }
  ;

ast:
  | list(nested) { () }

nested:
  | LPAR; ast; RPAR { () }
  ;

%%
