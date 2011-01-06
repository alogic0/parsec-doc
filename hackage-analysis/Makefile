imports := $(patsubst %,%.imports,$(shell cat packages-that-use-parsec.lst))
parsed   := $(patsubst %.imports,%.parsed-imports,$(wildcard *.imports))
tokens  := $(patsubst %.imports,%.tokens,$(wildcard *.imports))
parsec_tokens  := $(patsubst %.imports,%.parsec-tokens,$(wildcard *.imports))
all_stats:=combined-import-stats.txt parsec2-import-stats.txt parsec3-import-stats.txt parsec2-packages.lst parsec3-packages.lst combined-tokens-stats.txt parsec2-tokens-stats.txt parsec3-tokens-stats.txt

all: lexify $(parsed) $(tokens) $(parsec_tokens) $(all_stats)
#all: lexify packages-that-use-parsec.lst $(parsed) $(tokens) $(parsec_tokens) $(imports) $(all_stats)

hackage:
	mkdir -p hackage && cd hackage && tar -xf ~/.cabal/packages/hackage.haskell.org/00-index.tar 

packages-that-use-parsec.lst: hackage
	cd hackage && grep -l 'parsec' $$(find . -type f -name '*.cabal') | cut -d'/' -f2 | sort -u > ../packages-that-use-parsec.lst
    
%.imports:
	./extract-imports.sh $@ || true

%.parsed-imports: %.imports
	./parse-imports.pl < $< > $@

lexify: lexify.hs
	ghc -O2 --make lexify.hs

%.tokens:
	./lexify $$(find ./$(patsubst %.tokens,%,$@)-[0-9.]* -name '*.hs') > $@

%.parsec-tokens: %.parsed-imports %.tokens
	cut -f1 $< | sort -u | sed -e 's/(//;s/)//;' | while read t ; do fgrep -x "$$t" $*.tokens || true ; done > $@

combined-import-stats.txt: $(parsed)
	sort *.parsed-imports | uniq -c | sort -rn > $@

parsec2-import-stats.txt: $(parsed)
	grep -h ParserCombinators *.parsed-imports | sort | uniq -c | sort -rn > $@

parsec3-import-stats.txt: $(parsed)
	grep -vh ParserCombinators *.parsed-imports | sort | uniq -c | sort -rn > $@

parsec2-packages.lst: $(parsed)
	grep -l ParserCombinators *.parsed-imports | sort -u > $@

parsec3-packages.lst: $(parsed)
	grep -lv ParserCombinators *.parsed-imports | sort -u > $@

combined-tokens-stats.txt: $(parsec_tokens)
	sort *.parsec-tokens | uniq -c | sort -rn > $@

parsec2-tokens-stats.txt: $(parsec_tokens) parsec2-packages.lst
	sort $$(sed -e 's/.parsed-imports/.parsec-tokens/' parsec2-packages.lst) | uniq -c | sort -rn > $@

parsec3-tokens-stats.txt: $(parsec_tokens) parsec3-packages.lst
	sort $$(sed -e 's/.parsed-imports/.parsec-tokens/' parsec3-packages.lst) | uniq -c | sort -rn > $@

cleanstats:
	rm $(all_stats)

clean:
	rm $(parsed) $(tokens) $(parsec_tokens) $(all_stats)

distclean:
	rm -rf hackage $(imports) lexify lexify.o lexify.hi

