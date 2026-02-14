test: test.c
	$(CC) -g -Wall -O0 test.c -o test

demo: test
	sudo bpftrace ./trace.bt -c './test helloworld'
	sudo bpftrace ./trace.bt -c './test 0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789'

clean:
	$(RM) test

.PHONY: test demo clean
