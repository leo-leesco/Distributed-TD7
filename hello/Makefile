OBJ = hello_cpu hello_gpu

all: $(OBJ)

%: %.cu
	nvcc -I. -o $@ $^

%: %.c
	gcc -o $@ $^

clean:
	rm -f $(OBJ)
