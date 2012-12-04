BEGIN { push @*INC, <lib> }
use Modular;
use Test;

plan 6;

my $modulus = 10;
is .residue, 1, "simple modular addition" given Modular.new(5, :$modulus) + Modular.new(6, :$modulus);
is .residue, 2, "simple modular multiplication" given mod(4, $modulus) * mod(3, $modulus);
is .residue, 1, "modular inverse" given mod(3, $modulus) * mod(3, $modulus).Inverse;
is .residue, 8, "modular division" given mod(6, $modulus) * mod(7, $modulus).Inverse;

$Modular::default-modulus = 9973;
my $r = (^$Modular::default-modulus).pick;
is .residue, $_, "using default modulus" given mod($r);
is .residue, $r.expmod( 10000, .modulus ), "modular exponentiation" given mod($r)**10000;

# vim: ft=perl6
