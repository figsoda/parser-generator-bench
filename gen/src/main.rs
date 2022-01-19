#![feature(exclusive_range_pattern)]

use fastrand::Rng;

use std::{fs::File, io::Write};

fn write_ws(w: &mut impl Write, rng: &Rng) {
    for _ in 0..rng.u8(0..3) {
        write!(w, "{}", if rng.bool() { " " } else { "\t" }).unwrap();
    }
}

fn write_expr(w: &mut impl Write, rng: &Rng, len: u8) {
    let mut i = 0;
    while i < len {
        if i != 0 {
            write_ws(w, rng);
            write!(
                w,
                "{}",
                match rng.u8(0..33) {
                    0..8 => '+',
                    8..16 => '-',
                    16..24 => '*',
                    24..32 => '/',
                    32 => '^',
                    33.. => unreachable!(),
                }
            )
            .unwrap();
            write_ws(w, rng);
        }

        match rng.u8(0..4) {
            0..3 => {
                write!(
                    w,
                    "{}",
                    match rng.u8(0..6) {
                        0..4 => "",
                        4 => "-",
                        5 => "+",
                        6.. => unreachable!(),
                    }
                )
                .unwrap();

                write!(
                    w,
                    "{}",
                    match rng.u8(0..6) {
                        0..4 => (rng.u16(..) as f64 / rng.u8(1..) as f64).to_string(),
                        4 => "e".into(),
                        5 => "pi".into(),
                        6.. => unreachable!(),
                    }
                )
                .unwrap();
            }

            3 => {
                let n = rng.u8(1..=len - i);
                i += n;
                write!(
                    w,
                    "{}(",
                    match rng.u8(0..16) {
                        0..7 => "",
                        7 => "abs",
                        8 => "round",
                        9 => "floor",
                        10 => "ceil",
                        11 => "sqrt",
                        12 => "ln",
                        13 => "sin",
                        14 => "cos",
                        15 => "tan",
                        16.. => unreachable!(),
                    }
                )
                .unwrap();
                write_expr(w, rng, n);
                write!(w, ")").unwrap();
            }

            4.. => unreachable!(),
        }

        i += 1;
    }
}

fn main() {
    let mut file = File::create("input").unwrap();
    for _ in 0..1000 {
        write_expr(&mut file, &Rng::new(), 16);
        writeln!(file).unwrap();
    }
}
