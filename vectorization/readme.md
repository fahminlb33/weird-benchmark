# Vectorization using CPU Features

Let's say we have two matrices that we want to multiply using element-wise multiplication,
we can easily use two nested `for` loop to iterate each element and then print out the results,
but if the dimension of the matrix becomes large enough, it will be exponentially SLOW.

Remember, a nested `for` loop is has a time complexity of $O(2^n)$.

How can to optimize such operations? By running it on hardware.

> Many CPUs have "vector" or "SIMD" instruction sets which apply the same operation
> simultaneously to two, four, or more pieces of data. Modern x86 chips have the SSE
> instructions, many PPC chips have the "Altivec" instructions, and even some ARM
> chips have a vector instruction set, called NEON.
>
> "Vectorization" (simplified) is the process of rewriting a loop so that instead of
> processing a single element of an array N times, it processes (say) 4 elements of
> the array simultaneously N/4 times.
>
> Source: https://stackoverflow.com/a/1422181/5561144

Vectorization is one of the available trick a programmer can use to harness the full power
of your hardware, let it be CPU or GPU. With recent advancements like CUDA Math, Ray Tracing,
cuBLAS, cuFFT, and many other hardware-native implementation of math operations, we have
many amazing games and fast AI modelling process.

In this repo we will try to uncover the use of CPU feature using compiler optimization
to automatically vectorize our array operations.

## Baseline Performance in NodeJS

Here we want to multiply two matrices with the size of 1024x1024. You can check the source
code in the `mat.js`


```
$ node --version

v16.15.0


$ time node mat.js

30.98s  user
3.48s   system
100%    cpu
34.348  total
```

It took about 34.348 seconds in total. Well not that bad, at least for starter. Now we can
try to rewrite the app in C to see how vectorization can speed up this process. Since
JavaScript and C is not that different, the function looks almost identical.

## Vectorization in C/C++

Now I'll be using GCC in WSL 2 to compile this program. You can check the source code in
the `mat.c` file.

```
$ gcc --version

gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0
Copyright (C) 2019 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
```

### Default Compile

```
$ gcc -o mat mat.c

$ time ./mat

7.63s   user
0.18s   system
88%     cpu
8.801   total
```

### Vectorization using AVX2 and SSE2

```
$ gcc -O4 -fopt-info-optall-optimized -ftree-vectorize -mavx2 -msse2 -o mat_optimized mat.c

mat.c:36:9: optimized:   Inlining printf/15 into main/27 (always_inline).
mat.c:34:13: optimized:   Inlining printf/15 into main/27 (always_inline).
mat.c:29:9: optimized:  Inlined chunked_mm.constprop/30 into main/27 which now has time 3098669.816406 and size 47, net change of -6.
mat.c:11:9: optimized: loop vectorized using 32 byte vectors
mat.c:20:5: optimized: Loop nest 1 distributed: split to 2 loops and 1 library calls.
mat.c:11:9: optimized: loop vectorized using 32 byte vectors
mat.c:21:9: optimized: loop vectorized using 32 byte vectors
mat.c:21:9: optimized: loop vectorized using 32 byte vectors


time ./mat_optimized

0.71s   user
0.15s   system
46%     cpu
1.844   total
```

## Results

Now let's take a look at the amount of time each method requires to finish the multiplication.

| Compiler/Runtime | Elapsed Time (seconds) |
|------------------|------------------------|
| NodeJS           | 34.348                 |
| gcc (default)    | 8.801 (-74.38%)        |
| gcc (AVX2, SSE2) | 1.844 (-94.63%)        |

NodeJS is the slowest because as we know it can't run vectorization automatically (we can do
vectorization through N-API bt writing a native library). The C version is much faster, up to
74% faster even with the default compiler flags.

With AVX2 and SSE2 flags set, it can further reduce the amount of time down to 1.8 seconds,
that's 94% speed up!

Of course just multiplying matrices is not very interesting, but if you consider machine learning
algorithms (which basically a bunch of matrix multiplication), computer graphics (TRIANGLES!!!),
and many simulations is just matrix and other math operations. Because of this, many CPU and GPU
vendors include a variety of "helper libraries" to optimize this math functions by making a
dedicated hardware for those task, making it runs much much faster.

You can check out the `.asm` files to see how compiler optimization (-O4) can change the behavior
of code, especially in the optimized version where the program uses SSE2 and AVX2 instructions
like `VBROADCASTSS`, `VMULPS`, and `VMOVUPS`.
