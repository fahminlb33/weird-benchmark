# Benchmarking `bcrpyt` and `bcryptjs`

This is another silly benchmark to compare how the top two library for `bcrypt` algorithm in NodeJS
performs under a huge load. This test is basically the same as `array_functions` or `vectorization`
but this test is intended to be executed along with diagnostic tools such as Clinic.js.

To run the example script, you can just use `time` or even better, use `clinic`.

```
clinic doctor -- node run_bcryptjs.js
clinic flame -- node run_bcryptjs.js
```
