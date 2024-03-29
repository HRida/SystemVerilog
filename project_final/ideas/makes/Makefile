top: make -f Makefile.top simulate_dump

rom2ram: make -f Makefile.rom2ram simulate_dump

arbiter: make -f Makefile.arbiter simulate_dump

rom: make -f Makefile.rom simulate_dump

dma: make -f Makefile.dma simulate_dump

ram: make -f Makefile.ram simulate_dump

matmult: make -f Makefile.matmult simulate_dump

dotporduct : make -f Makefile.dotproduct simulate_dump

fifo: make -f Makefile.fifo simulate_dump

mac: make -f Makefile.mac simulate_dump

cdc: make -f Makefile.cdc simulate_dump

clean:
	#find . -type f ! -name 'Makefile*' -execdir rm {} +
	find . -type f ! -name 'Makefile*' | xargs rm 
	rm -rf xsim*