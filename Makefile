# Compilar los SVG en PDF
# Con el dólor que significa hacelo en OS X :/ (son las 1:48AM!)


UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
    CCFLAGS += -D LINUX
    INKSCAPE = $(shell which inkscape)
endif
ifeq ($(UNAME_S),Darwin)
    CCFLAGS += -D OSX
    # Inkscape has some issues on OS X :(
    INKSCAPE = '/Applications/Inkscape.app/Contents/Resources/script'
endif


SVGS=$(wildcard out/*.svg)
PDFS=$(SVGS:.svg=.pdf)
#files := $(foreach dir,$(dirs),$(wildcard $(dir)/*))
PNGS_150=$(foreach file,$(SVGS), $(basename $(file))_150.png)
PNGS_300=$(foreach file,$(SVGS), $(basename $(file))_300.png)
PNGS_75=$(foreach file,$(SVGS), $(basename $(file))_75.png)


.PHONY: PDFS

all: $(PNGS_150)

# Unfortunately OS X requires to have full path to files
%.pdf: %.svg
	$(eval from_file := $(abspath $^))
	$(eval to_file := $(abspath $@))

	#-echo "from_file = ${from_file} to_file: ${to_file}"
	#echo ${CWD}
	$(INKSCAPE) -z -f "${from_file}" -A "${to_file}"

%_75.png: %.svg
	$(eval from_file := $(abspath $^))
	$(eval to_file := $(abspath $@))
	$(INKSCAPE) -z -f "${from_file}" -e "${to_file}" -d 75

%_150.png: %.svg
	$(eval from_file := $(abspath $^))
	$(eval to_file := $(abspath $@))
	$(INKSCAPE) -z -f "${from_file}" -e "${to_file}" -d 150

%_300.png: %.svg
	$(eval from_file := $(abspath $^))
	$(eval to_file := $(abspath $@))
	$(INKSCAPE) -z -f "${from_file}" -e "${to_file}" -d 300

%_600.png: %.svg
	$(eval from_file := $(abspath $^))
	$(eval to_file := $(abspath $@))
	$(INKSCAPE) -z -f "${from_file}" -e "${to_file}" -d 600
