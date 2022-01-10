#![feature(stdin_forwarders)]

use std::io;

pub fn run(parse: impl Fn(&str) -> f64) {
    for s in io::stdin().lines() {
        println!("{}", parse(&s.unwrap()));
    }
}
