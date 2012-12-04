Modular arithmetics in Perl6

Inspired from P5´s Math::ModInt

    use Modular;

    # using the exported C<mod> functin
    my $x = mod(6, 10);
    my $y = mod(7, 10);
    say $x + $y;  # should display 3 「mod 10」

    # using a verbose object notation
    # the modulus must be passed as a named argument
    my $x = Modular.new: 6, :modulus(10);
    my $x = Modular.new: 7, :modulus(10);
    say $x * $y;  # should display 2 「mod 10」

    # using a default modulus
    $Modular::default-modulus =  10;
    my $x = mod 6;
    my $y = mod 7;
    say $x div $y; # should display 8 「mod 10」


The purpose of this module is to provide a class implementing Real and
overloading arithmetic operators.  Some modular operators are already defined
in perl6, such as '%', 'mod' and 'expmod'.  But as far as I know, there is no
class to use them with generic functions.

For instance, say you defined the factorial function as such:

    sub postfix:<!>($n) { [*] 1 .. $n }

You can use such a function to compute 100! (mod 101) efficiently only
if you have defined a modular version of C<*> and C<..>.  That is the purpose
of this module:  to use modular integers as if there were normal integers.
