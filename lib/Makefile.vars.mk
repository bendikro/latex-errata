# DTX.sty.base and DTX.cls.base are set in the including Makefiles
DTX.base = $(DTX.sty.base) $(DTX.cls.base)
DTX = $(DTX.base:%=%.dtx) $(DTX.base:%=%.ins)

DTX.sty.ltxml = $(DTX.sty.base:%=%.sty.ltxml)
DTX.cls.ltxml = $(DTX.cls.base:%=%.cls.ltxml)
DTX.sty = $(DTX.sty.base:%=%.sty)
DTX.ins = $(DTX.sty.base:%=%.sty)
DTX.cls = $(DTX.cls.base:%=%.cls)
DTX.pdf	= $(sort $(DTX.base:%=%.pdf)) # sort to remove duplicates

# Build custom PDF document
CUSTOM.pdf	= $(CUSTOM:%=%.pdf)

# The TeX Directory Structure (see http://www.tug.org/tds/tds.html)
TDSDIR = /tmp/$(TDSCOLL).tds
TDSDIR.tex = $(TDSDIR)/tex/latex/$(TDSCOLL)/$(PACKAGE)
TDSDIR.doc = $(TDSDIR)/doc/latex/$(TDSCOLL)/$(PACKAGE)
TDSDIR.src = $(TDSDIR)/source/latex/$(TDSCOLL)/$(PACKAGE)

# make a zip for CTAN submission
CTANDIR = /tmp/$(TDSCOLL).ctan/$(CTANPREFIX)$(PACKAGE)

# the dependencies
SOURCES		= $(DTX.sty) $(BIB)
TEXINPUTS := .:$(MKPREFIX)//:
BSTINPUTS := .:$(MKPREFIX)//:

# we want to quiet down pdflatex
PDFLATEX_CMD=pdflatex -file-line-error -shell-escape
PDFLATEX_OPTIONS?=-interaction batchmode
PDFLATEX = $(PDFLATEX_CMD) $(PDFLATEX_OPTIONS)


# we set the package date for 'make filedate' to today
BINDIR = $(MKPREFIX)/../bin
PACKAGEDATE 	?= $(shell date "+%Y/%m/%d")
FILEDATEPROG    = PERL5LIB=$(BINDIR) $(BINDIR)/filedate
CHECKSUMPROG    = PERL5LIB=$(BINDIR) $(BINDIR)/checksum
