# Which Array Function is The Fastest?

This is just a silly benchmark comparing `forEach`, `reduce`, `map`, `filter`, and `for`
to sum an array of numbers. I've been told that a certain function is the fastest (uhm, `map`)
and all the other functions is crap.

We will find out!

## How

In each test, we will sum an array of $10^6$ elements using different array functions, each test
will be run for 100 times. Oh and it's not just sum but we will calculate something and the sum it.
We will measure two important metrics, the memory allocation and average execution time.

To run the script,

```
node --expose-gc compare_array_functions.js
```

## Results

| Method | Memory Allocation | Average Execution Time (ms) |
|--------|-------------------|-----------------------------|
| forEach| 14561280          | 21.68193 |
| reduce | 16658432          | 18.65535 |
| map    | 48807936          | 25.65681 |
| filter | 69025792          | 41.40637 |
| for    | 16015360          | 1.281948 |

Read more: https://www.kodesiana.com/post/kamu-terlalu-banyak-menggunakan-map-nodejs/