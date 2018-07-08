# if -march=native does not work on your platform, you could try
# -msse
# -msse2
# -mavx
# or
# -mavx2

CC     = gcc

CFLAGS = -std=gnu99 -O3 -march=native

all: solve_bs solve_piwi_bs solve_piwi libnfc_crypto1_crack

CRAPTEV1 = craptev1-v1.1/craptev1.c -I craptev1-v1.1/
CRAPTO1 = crapto1-v3.3/crapto1.c crapto1-v3.3/crypto1.c -I crapto1-v3.3/ 
CRYPTO1_BS = crypto1_bs.c crypto1_bs_crack.c 

solve_bs:
	$(CC) $(CFLAGS) $@.c $(CRYPTO1_BS) $(CRAPTO1) ${CRAPTEV1} -o $@ -lpthread -lm

solve_piwi_bs:
	$(CC) $(CFLAGS) $@.c $(CRYPTO1_BS) $(CRAPTO1) ${CRAPTEV1} -o $@ -lpthread -lm

solve_piwi:
	$(CC) $(CFLAGS) $@.c $(CRYPTO1_BS) $(CRAPTO1) ${CRAPTEV1} -o $@ -lpthread

libnfc_crypto1_crack:
	$(CC) $(CFLAGS) $@.c $(CRYPTO1_BS) $(CRAPTO1) ${CRAPTEV1} -o $@ -lpthread -lnfc -lm

clean:
	rm -f solve.so solve_bs solve_piwi_bs solve_piwi 

get_craptev1:
	#wget https://doc-00-3g-docs.googleusercontent.com/docs/securesc/ha0ro937gcuc7l7deffksulhg5h7mbp1/t7l5d57qlutlalrgnff7badc1tbvfs3o/1531058400000/14354694460147819648/*/0Bwg207dj_8XxcFB3a3FWQzJyZ2tLd2pnNXhTLWJDN0VsOGpV?e=download
	tar Jxvf craptev1-v1.1.tar.xz

get_crapto1:
	#wget https://doc-08-3g-docs.googleusercontent.com/docs/securesc/ha0ro937gcuc7l7deffksulhg5h7mbp1/5didg387u3mfibth4siovr71tb4v7lhn/1531058400000/14354694460147819648/*/0Bwg207dj_8XxamNCRTBTMjN4alBsbWcySlVEQ1dlYmpZQmRR?e=download
	#mkdir crapto1-v3.3
	tar Jxvf crapto1-v3.3.tar.xz 

# Windows cross compilation
MINGW32 = i686-w64-mingw32-gcc
MINGW64 = x86_64-w64-mingw32-gcc
# solve.c code cannot be compiled on windows without patching the includes

WIN32EXES = solve_piwi_bs32.exe solve_piwi32.exe libnfc_crypto1_crack32.exe
win32: $(WIN32EXES)
win32_clean:
	rm -f $(WIN32EXES)

WIN64EXES = solve_piwi_bs64.exe solve_piwi64.exe libnfc_crypto1_crack64.exe
win64: $(WIN64EXES)
win64_clean:
	rm -f $(WIN64EXES)

solve_piwi_bs32.exe:
	$(MINGW32) $(CFLAGS) solve_piwi_bs.c $(CRYPTO1_BS) $(CRAPTO1) ${CRAPTEV1} -static -m32 -o $@ -lpthread

solve_piwi_bs64.exe:
	$(MINGW64) $(CFLAGS) solve_piwi_bs.c $(CRYPTO1_BS) $(CRAPTO1) ${CRAPTEV1} -static -o $@ -lpthread

solve_piwi32.exe:
	$(MINGW32) $(CFLAGS) solve_piwi.c $(CRYPTO1_BS) $(CRAPTO1) ${CRAPTEV1} -static -m32 -o $@ -lpthread

solve_piwi64.exe:
	$(MINGW64) $(CFLAGS) solve_piwi.c $(CRYPTO1_BS) $(CRAPTO1) ${CRAPTEV1} -static -o $@ -lpthread

