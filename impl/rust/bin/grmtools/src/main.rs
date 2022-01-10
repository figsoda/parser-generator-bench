lrlex::lrlex_mod!("calc.l");
lrpar::lrpar_mod!("calc.y");

fn main() {
    let lexerdef = calc_l::lexerdef();
    common::run(|s| calc_y::parse(&lexerdef.lexer(s)).0.unwrap());
}
