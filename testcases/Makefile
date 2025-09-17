CC := gcc
CFLAGS := -rdynamic -shared

all::
	# COFF to ELF conversion
	x86_64-w64-mingw32-gcc -c -o test_math.o test_math.c
	wcc test_math.o -o test_math2.o -c
	$(CC) $(CFLAGS) test_math2.o -o test_coff.so

	# PE to ELF conversion
	wine tcc/tcc.exe -o test_math.exe simple_math.c
	wcc test_math.exe -o test_math3.o -c
	# a PE file doesn't keep symbols names : add them back manually
	objcopy --add-symbol add_numbers=.text:0x0,global,function test_math3.o test_math4.o
	mv test_math4.o test_math3.o
	objcopy --add-symbol multiply=.text:0x28,global,function test_math3.o test_math4.o
	mv test_math4.o test_math3.o
	objcopy --add-symbol fibonacci=.text:0x46,global,function test_math3.o test_math4.o
	$(CC) $(CFLAGS) test_math4.o -o test_pe.so

	# Mach-O to ELF conversion
	clang -target x86_64-apple-darwin simple_math.c -o test.macho -c
	wcc test.macho -o testmacho.o -c
	gcc -rdynamic testmacho.o -o test_macho.so -shared

gettcc::
	wget https://download.savannah.gnu.org/releases/tinycc/tcc-0.9.27-win64-bin.zip
	unzip tcc-0.9.27-win64-bin.zip

getwcc::
	mv wcc.bin /usr/bin/wcc

filetypes:
	file test_math.o test_math.exe test.macho

test::
	./test-coff.wsh
	./test-pe.wsh
	./test-macho.wsh

clean:
	rm -f test_math.o test_math2.o test_math.so test_math3.o test_math4.o test.macho  testmacho.o test_coff.so  test_macho.so  test_pe.so test_math.exe

