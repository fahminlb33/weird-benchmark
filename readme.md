
# NodeJS Array Functions Benchmark and Vectorization

This repository contians code used to benchmark NodeJS array functions performance in two of
my blog posts.

## NodeJS Array Functions

To run the benchmark, run:

```bash
node --expose-gc compare-array-functions.js
```

Example output:

```text
> node --expose-gc compare-array-functions.js

Running measurement for: forEach
Memory allocation: 22994944
Average execution time: 19.163008ms

Running measurement for: reduce
Memory allocation: 32784384
Average execution time: 18.283535000000004ms

Running measurement for: map
Memory allocation: 24010752
Average execution time: 27.384248000000003ms

Running measurement for: filter
Memory allocation: 125800448
Average execution time: 45.154591999999994ms

Running measurement for: for
Memory allocation: 16007168
Average execution time: 1.1233729999999995ms
```

To change the sample test size (defaults to 1.000), change `testSize` const (line 2) in
`compare-array-functions.js`.

## Vectorization Optimization

To compile the `mat.c` source to executable and assembly file, you'll need GCC with AVX
support. I'm using `gcc.exe (i686-posix-dwarf-rev0, Built by MinGW-W64 project) 8.1.0`
in Windows 10 64-bit.

```bash
# without vectorization
gcc -O0 -fopt-info-optall-optimized -fno-tree-vectorize -mno-avx -o mat1gcc.exe mat.c
gcc -O0 -fopt-info-optall-optimized -fno-tree-vectorize -mno-avx -S -o mat1gcc.asm mat.c

# with vectorization
gcc -O4 -fopt-info-optall-optimized -ftree-vectorize -mavx -o mat2gcc.exe mat.c
gcc -O4 -fopt-info-optall-optimized -ftree-vectorize -mavx -S -o mat2gcc.asm mat.c
```

To measure the time required to run the computation, run:

```powershell
measure-command {& ./mat1gcc | out-null} | select-object TotalSeconds
measure-command {& ./mat2gcc | out-null} | select-object TotalSeconds
measure-command {node mat.js | out-null} | select-object TotalSeconds
```

Example output:

```text
> measure-command {& ./mat2gcc | out-null} | select-object TotalSeconds  

TotalSeconds
------------
   1,2691288
```
