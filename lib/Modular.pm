class Modular does Real {
    our $.default-modulus;
    has ($.residue, $.modulus);
    multi method new($residue, :$modulus where * > 1) { self.new: :residue($residue % $modulus), :$modulus }
    method Bridge { $.residue % $.modulus }
    multi method gist { "{self.Bridge} 「mod $.modulus」" }
    method succ { self.Bridge.succ % $.modulus }
    multi method Inverse {
	return Mu unless $.residue gcd $.modulus == 1;
        my ($c, $d, $uc, $vc, $ud, $vd) = ($.residue, $.modulus, 1, 0, 0, 1);
        my $q;
        while $c != 0 {
            ($q, $c, $d) = ($d div $c, $d % $c, $c);
            ($uc, $vc, $ud, $vd) = ($ud - $q*$uc, $vd - $q*$vc, $uc, $vc);
        }
        return self.new: $ud < 0 ?? $ud + $.modulus !! $ud, :$.modulus;
    }
}

sub mod($residue, $modulus = $Modular::default-modulus) is export returns Modular { Modular.new: :$residue, :$modulus }
multi prefix:<->(Modular $a) is export returns Modular { Modular.new: -$a.Bridge, :modulus($a.modulus) }
multi infix:<->(Modular $a, Modular $b where $a.modulus ~~ $b.modulus) is export returns Modular {
    Modular.new: $a.Bridge - $b.Bridge, :modulus($a.modulus)
}

multi infix:<+>(Modular $a, Modular $b where $a.modulus ~~ $b.modulus) is export returns Modular {
    Modular.new: $a.Bridge + $b.Bridge, :modulus($a.modulus)
}

multi infix:<*>(Modular $a, Modular $b where $a.modulus ~~ $b.modulus) is export returns Modular {
    Modular.new: $a.Bridge * $b.Bridge, :modulus($a.modulus)
}
multi infix:<*>(Int $a, Modular $b) is export returns Modular {
    Modular.new: $a * $b.Bridge, :modulus($b.modulus)
}

multi infix:</>(Modular $a, Modular $b where $a.modulus ~~ $b.modulus) is export returns Modular {
    Modular.new: $a.Bridge * $b.Inverse.Bridge, :modulus($a.modulus)
}

multi infix:<**>(Modular $a, Int $e) is export returns Modular {
    Modular.new: $a.Bridge.expmod($e, $a.modulus), :modulus($a.modulus)
}

# vim: ft=perl6
