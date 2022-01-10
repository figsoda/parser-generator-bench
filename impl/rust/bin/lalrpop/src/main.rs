use lalrpop_util::lalrpop_mod;

lalrpop_mod!(calc);

fn main() {
    let parser = calc::ExprParser::new();
    common::run(|s| parser.parse(s).unwrap());
}
