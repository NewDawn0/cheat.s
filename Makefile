LIBPATH = /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/lib
ASM = nasm
ASMFLAGS = -f macho64
LD = ld
LDFLAGS = -lSystem -L $(LIBPATH)
OBJS = alpha.o
SRCS = ./src/alpha.asm
OUT = alpha
.PHONY: clean
build:
	@echo "Building"
	nasm $(ASMFLAGS) -o $(OBJS) $(SRCS)
	ld $(LDFLAGS) -o $(OUT) $(OBJS)
install: build
	@echo "Installing"
	cp alpha /usr/local/bin/
clean:
	@echo "Installing"
	rm $(OBJS) $(OUT)
