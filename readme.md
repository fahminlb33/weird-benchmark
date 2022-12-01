# Weird Benchmark 101

Welcome to the lost souls of programmer who find him/herself into this weird repo!

This repo contains the code I used to run several code benchmark, do load testing,
and try some weird stuff with JS and C.

Table of Contents:

- array_functions, contains my experiment with different array functions to find out which one is the fastest
- bcrypt_benchmark, contains my experiment with `bcryptjs` and `bcrypt` to demonstrate how to profile a NodeJS app
- expressjs_custom_spans, contains a sample app to create manual instrumentation in Elastic APM
- load_test, contains a sample K6.io script to perform a REST API load test
- vectorization, a sample matrix multiplication using NodeJS and C, with different compiler flags to enable SSE2 and AVX2 optimization
