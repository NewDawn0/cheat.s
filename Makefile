LIBPATH = /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/lib
LDFLAGS = -lSystem -L $(LIBPATH)
.PHONY: clean
build:
	@echo "Building"
	nasm -f macho64 -o alpha.o src/alpha.asm
	ld $(LDFLAGS) -o alpha alpha.o
install: build
	@echo "Installing"
	cp alpha /usr/local/bin/
clean:
	@echo "Cleaning"
	rm alpha.o alpha
