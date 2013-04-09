## Most useful combinators

According to the analysis of the real code that is available on Hackage, 80% of Parsec function calls could be attributed to the very small set of functions.

They are:

* Parsec invocation: parse, parseFromFile
* Lexical combinators: char string digit spaces satisfy oneOf noneOf eof
* Repetition: option/optional/optionMaybe many many1 manyTill
* Parsing alternatives: <|> choice
* Backtracking: try, lookAhead(?)
* Error reporting: <?>
* Convenience combinators: between parens
* Handling parser state: getState/setState/updateState

All of them are accessible once you import the main Parsec module (TODO: ref modules). Examples in this section assume that we are working in the ghci session with main Parsec module brought into scope, like so:

Parsec 2

```:m +Text.ParserCombinators.Parsec```

Parsec 3

```:m +Text.Parsec```

### Parser invocation and basic parser building blocks

```
:t char 'a'
parse (char 'a') "" "a"
parse (char 'a') "" "b"
```

Parsers return values

```
parse (char 'a' >> char 'd' >> char 'd') "" "add"
parse (string "add") "" "add"

parse digit "" "1"
parse (string "add" >> spaces >> digit) "" "add 1"

parse (string "add" >> spaces >> digit >> eof) "" "add 1"
```

```
do string "add"
   var <- satisfy isUpper
   val <- digit
   eof
   return (var, val)
```
   
```"add A 1"```

```replace (satisfy isUpper) with (oneOf "ABC") or (noneOf "XYZ")```

### Repetition

Parallels with regexps

```
many a ==> a*
many1 a ==> a+
optional a ==> a?
option a ==> a?
a `manyTill` b ==> a*b
```

Some examples

### Alternatives

```a <|> b ==> a|b```
mention eager matching

choice [a,b,c,d] ==> a|b|c|d

### Backtracing

TODO: motivational example and the rest

### Error reporting

### Convenience combinators

 between parens

Mention where to look for the rest of them

### Handling parser state

TODO: getState/setState/updateState
