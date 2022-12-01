const N = 1024;

function createArray(length) {
    var arr = new Array(length || 0),
        i = length;

    if (arguments.length > 1) {
        var args = Array.prototype.slice.call(arguments, 1);
        while(i--) arr[length-1 - i] = createArray.apply(this, args);
    }

    return arr;
}

matrix_a = createArray(N,N);
matrix_b = createArray(N,N);
result_matrix = createArray(N,N);

function chunked_mm(chunk, n_chunks) {
    for (i = chunk*(N/n_chunks); i < (chunk+1)*(N/n_chunks); i++) {
        for (j = 0; j < N; j++) {
            for (k = 0; k < N; k++) {
                result_matrix[i][j] += matrix_a[i][k] * matrix_b[k][j];
            }
        }
    }
}

for (i = 0; i < N; i++) {
    for (j = 0; j < N; j++) {
        matrix_a[i][j] = 0.1;
        matrix_b[i][j] = 0.2;
        result_matrix[i][j] = 0.0;
    }
}

for (chunk = 0; chunk < 4; chunk++) {
    chunked_mm(chunk, 4);
}

for (i = 0; i < N; i++) {
    for (j = 0; j < N; j++) {
        const elem = result_matrix[i][j];
        process.stdout.write(`${elem} `);
    }
    process.stdout.write("\n");
}