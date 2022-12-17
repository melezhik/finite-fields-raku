[![SparrowCI](https://ci.sparrowhub.io/project/gh-grondilu-finite-fields-raku/badge)](https://ci.sparrowhub.io)

# Finite Fields Aritmetics in raku

```raku
use FiniteField;
$*modulus = 13;

say 10+5;  # 2
say 10/3;  # 12  (3*12 = 36 = 13*2 + 10)
```

## Notes
   
  * The dynamic variable `$*modulus` must be defined before calling any overloaded operator,
  otherwise the program will crash (no exception is handled so far).
  * Modular division will not check for primality of modulus or any other requirements.
  * Define a modulus for each lexical scopes you import the module in.
  * Althouh the name of this repo is using a plural, the name of the module
  itself is singular, because you only use one finite field at a time.
  * The main purpose of this module was to make writing cryptographic code easier.
