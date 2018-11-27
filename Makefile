STEM = cmp2018

$(STEM).pdf: $(STEM).tex header.tex Figs/spreadsheet_ugly.pdf
	xelatex $<

Figs/spreadsheet_ugly.pdf: R/make_spreadsheet_figs.R R/example_ugly.csv R/example_tidy.csv
	cd $(<D);R -e "source('$(<F)')"

web: $(STEM).pdf
	scp $(STEM).pdf adhara.biostat.wisc.edu:Website/presentations/$(STEM).pdf
