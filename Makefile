
all: ctest
	~/.cabal/bin/idris driver.idr -o driver && ./driver

ctest:
	gcc -g -O0 -c idris_SDL_video.c -lSDL2

clean:
	rm -rf driver *~ *.ibc *.o