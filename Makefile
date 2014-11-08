TEXIARGS = --html --ifinfo --no-split --css-ref=janix-texinfo.css

.PHONY: flim semi wanderlust clean

all: wl.html wl-ja.html mime-en.html mime-ja.html mime-ui-en.html mime-ui-ja.html

clean:
	rm -rf tmp/ wl.html wl-ja.html mime-en.html mime-ja.html mime-ui-en.html mime-ui-ja.html janix-texinfo.css
tmp:
	mkdir -p tmp

flim: tmp
	[ -d tmp/flim ] || (cd tmp && git clone https://github.com/wanderlust/flim.git --depth 1)
	cd tmp/flim && git pull

semi: tmp
	[ -d tmp/semi ] || (cd tmp && git clone https://github.com/wanderlust/semi.git --depth 1)
	cd tmp/semi && git pull

wanderlust: tmp
	[ -d tmp/wanderlust ] || (cd tmp && git clone https://github.com/wanderlust/wanderlust.git --depth 1)
	cd tmp/wanderlust && git pull

janix-texinfo.css:
	wget https://raw.githubusercontent.com/Janixman/janix-texinfo.css/master/janix-texinfo.css

mime-ui-en.html : semi janix-texinfo.css
	texi2any $(TEXIARGS) tmp/semi/mime-ui-en.texi -o $@

mime-ui-ja.html : semi janix-texinfo.css
	texi2any $(TEXIARGS) tmp/semi/mime-ui-ja.texi -o $@

mime-en.html : flim janix-texinfo.css
	texi2any $(TEXIARGS) tmp/flim/mime-en.texi -o $@

mime-ja.html : flim janix-texinfo.css
	texi2any $(TEXIARGS) --force tmp/flim/mime-ja.texi -o $@

wl.html : wanderlust janix-texinfo.css
	texi2any $(TEXIARGS) tmp/wanderlust/doc/wl.texi -o $@

wl-ja.html: wanderlust janix-texinfo.css
	texi2any $(TEXIARGS) tmp/wanderlust/doc/wl-ja.texi -o $@

