#!/usr/bin/perl
$imports=join('',<>);
$imports=~s/\n//g;
#print $imports;
while ($imports =~ /(.*?)(Text(\.ParserCombinators)?\.Parsec(\.Token)?)\s*(as\s*\w+?)?\s*\((.*?)\)\s*($|import.*)/) {
    # print "Match: $2 % $3 % $4 % $5 % $6\n";
    $imports="$1$7";
    $module=$2;
    $importlist=$6;
    if ($module =~ /Token$/) {
        $importlist =~ s/(Gen)?TokenParser\(//;
        $importlist =~ s/\w*LanguageDef\(//;
        $importlist =~ s/\)//g;
    }
    @imported=split(/,\s*/,$importlist);
    foreach $i (@imported) {
        $i=~s/^\s*//;
        $i=~s/\s*$//;
        print "$i\t$module\n";
    }
}
