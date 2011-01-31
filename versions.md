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

Neither of the two versions is Haskell-2010 (i.e. both use extensions), but
Parsec 2 uses less extensions than Parsec 3, so chances that any given compiler
can compile Parsec 2 are higher than those for Parsec 3.

By this time both versions work with GHC, while Parsec 2 is also [reported][jhc] to
build with JHC and is included as one of the JHC's standard libraries.

#### Haskell Platform ####
The [Haskell Platform][HP] is a set of blessed libraries and tools. As of
2010.2.0.0 release of the Platform, the Parsec 2 is included in the set of
packages, while Parsec 3 is not.

This means that users installing Haskell Platform get Parsec 2 for free, while
Parsec 3 has to be installed manually (e.g. using `cabal-install`).

On the other hand, most probably Parsec 3 will get into the Haskell Platform
sooner or later. Regarding Parsec 2, it also is not going to disappear from the
Platform in the nearest future.

#### Performance ####
Originally (i.e. as of 3.0 version) Parsec 3 was considerably slower than
Parsec 2. However, [work on improving Parsec 3 performance][cps] has been  done,
and as of version 3.1 Parsec 3 is only slightly slower than Parsec 2
(benchmarks: [1][bench1], [2][bench2]).


### Compatibility layer ###
It has been possible to "reimplement" all of the Parsec 2 API in Parsec 3. This
compatibility layer is provided by the Parsec 3 package under the module hierarchy
`Text.ParserCombinators.Parsec` (the same hierarchy which is used by Parsec 2),
while the new Parsec 3 API is available under the `Text.Parsec` hierarchy.

This means that you can use Parsec 3 as a drop-in replacement for Parsec 2.

[TODO]: https://github.com/feuerbach/parsec-doc/wiki
[HP]: http://hackage.haskell.org/platform/
[cps]: http://panicsonic.blogspot.com/2009/12/adventures-in-parsec.html
[bench1]: http://www.haskell.org/pipermail/haskell-cafe/2009-December/070196.html
[bench2]: http://www.mail-archive.com/haskell-cafe@haskell.org/msg79296.html
[jhc]: http://www.haskell.org/pipermail/haskell/2011-January/022532.html
