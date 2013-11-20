CC=gcc
CFLAGS=-g -O0
LIBS=-lSDL2
SRCS = SDL/idris_SDL_video.c SDL/idris_SDL_mouse.c
OBJS = $(SRCS:.c=.o)

all: $(OBJS)
	~/.cabal/bin/idris --ibcsubdir dist driver.idr -o driver && ./driver

.c.o:
	$(CC) $(CFLAGS) -c $< $(LIBS) 
#	gcc -g -O0 -c SDL/idris_SDL_video.c -lSDL2

clean:
	rm -rf driver *~ *.ibc *.o