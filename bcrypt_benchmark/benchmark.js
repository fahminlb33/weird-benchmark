const fs = require('fs');
const cliProgress = require('cli-progress');

const bcrypt = require("bcrypt");
const bcryptjs = require("bcryptjs");

const N_ITERATIONS = 1000;

async function measureBcryptJs() {
    console.log("\nRunning test: bcryptjs");

    const bar1 = new cliProgress.SingleBar({}, cliProgress.Presets.shades_classic);
    bar1.start(N_ITERATIONS, 0);

    const runtimeLog = [];
    for (let i = 0; i < N_ITERATIONS; i++) {
        const start = performance.now();
        await bcryptjs.hash(`pass${i}`, 10);
        const end = performance.now();

        runtimeLog.push(end - start);
        bar1.update(i + 1);
    }

    bar1.stop();

    return runtimeLog;
}

async function measureBcryptNative() {
    console.log("\nRunning test: bcrypt-native");

    const bar1 = new cliProgress.SingleBar({}, cliProgress.Presets.shades_classic);
    bar1.start(N_ITERATIONS, 0);

    const runtimeLog = [];
    for (let i = 0; i < N_ITERATIONS; i++) {
        const start = performance.now();
        await bcrypt.hash(`pass${i}`, 10);
        const end = performance.now();

        runtimeLog.push(end - start);
        bar1.update(i + 1);
    }

    bar1.stop();

    return runtimeLog;
}

function printStats(runtimeLog) {
    // total
    const total = runtimeLog.reduce((a, b) => a + b, 0);
    console.log(`Total time: ${total}ms`);

    // average
    const average = total / runtimeLog.length;
    console.log(`Average time: ${average}ms`);

    // standard deviation
    const variance = runtimeLog.map(x => Math.pow(x - average, 2)).reduce((a, b) => a + b, 0) / runtimeLog.length;
    const stdDev = Math.sqrt(variance);
    console.log(`Standard deviation: ${stdDev}ms`);
}

(async () => {
    // run bcryptjs
    const runtimeLogBcryptJs = await measureBcryptJs();
    printStats(runtimeLogBcryptJs);
    fs.writeFileSync("bcrypt-js.txt", runtimeLogBcryptJs.join("\n"));

    // run bcrypt-native
    const runtimeLogBcryptNative = await measureBcryptNative();
    printStats(runtimeLogBcryptNative);
    fs.writeFileSync("bcrypt-native.txt", runtimeLogBcryptNative.join("\n"));
})();
