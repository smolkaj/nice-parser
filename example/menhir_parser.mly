(* tokens *)
%token EOF LPAR RPAR
%token <string> ATOM

(* start symbol *)
%start <Ast.sexp> sexp_eof

%%

sexp_eof:
  | e=sexp; EOF { e }
  ;

sexp:
  | a=ATOM { Ast.Atom a }
  | LPAR; es=list(sexp); RPAR { Ast.List es }
  ;

%%
