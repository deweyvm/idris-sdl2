
all: video
	~/.cabal/bin/idris --ibcsubdir dist driver.idr -o driver && ./driver

video:
	gcc -g -O0 -c SDL/idris_SDL_video.c -lSDL2

clean:
	rm -rf driver *~ *.ibc *.o