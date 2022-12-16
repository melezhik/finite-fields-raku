use Test;

use FiniteField;
$*modulus = 13;

ok $_*$_ ~~ ^13 for ^13;
ok 1/$_ ~~ UInt for 1..^13;
is (1/$_)*$_, 1 for 1..^13;

done-testing;

# vim: ft=raku
