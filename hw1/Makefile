ZIPFILE = hw1.zip
MATLAB_FILES = matlab/*.m matlab/data/

all: $(ZIPFILE)

$(ZIPFILE): $(ZIPFILE:.zip=.pdf) $(MATLAB_FILES)
	zip -r $@ $^

%.pdf: %.tex clean
	pdflatex $<
	pdflatex $<

clean:
	rm *.pdf 2>/dev/null || true
	rm *.aux 2>/dev/null || true
	rm *.out 2>/dev/null || true
	rm $(ZIPFILE) 2>/dev/null || true

.PHONY: clean all
