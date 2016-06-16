ZIPFILE = hw4.zip
CODE_FILES = queue/*.m polling/*.py

all: $(ZIPFILE)

$(ZIPFILE): $(ZIPFILE:.zip=.pdf) $(CODE_FILES)
	zip -9 -r $@ $^

%.pdf: %.tex clean
	pdflatex $<
	pdflatex $<

clean:
	rm *.pdf 2>/dev/null || true
	rm *.aux 2>/dev/null || true
	rm *.out 2>/dev/null || true
	rm $(ZIPFILE) 2>/dev/null || true

.PHONY: clean all
