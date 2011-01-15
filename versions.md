Parsec versions
---------------

At the moment there are two widely used major versions of Parsec, Parsec 2 and
Parsec 3.

As a quick advice, simply use the latest release of Parsec 3. But if you want to
make a conscious choice, read on.

### New in Parsec 3 ###
#### Monad Transformer ####
Parsec 3 introduces a monad transformer, `ParsecT`, which can be used to combine
parsing with other monadic effects. For examples of such combinations see [the
chapter about transformers][TODO].

#### Streams ####
Although Parsec 2 lets you to choose the token type (which is useful when you
want to separate lexical analysis from the parsing), the tokens are always
arranged into lists. List may be not the most efficient data structure to store
large texts.

Parsec 3 can work with arbitrary *streams* -- data structures with list-like
interface. You can define your own streams, but Parsec 3 also includes a popular
and efficient Stream implementation based on ByteString (for `Char`-based
parsing), exposed through the modules `Text.Parsec.ByteString` and
`Text.Parsec.ByteString.Lazy`.

### Reasons to prefer Parsec 2 ###
#### Less extensions required ####
Advanced features provided by Parsec 3 do not come for free: to implement them
several language extensions are required.

TODO: test Parsec 2 with different compilers

#### Haskell Platform ####

#### Performance ####

### Compatibility layer ###

[TODO]: https://github.com/feuerbach/parsec-doc/wiki
