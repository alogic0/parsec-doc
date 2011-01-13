ALL: versions.html most-useful.html

%.html: %.md
	pandoc -s -S $< > $@
