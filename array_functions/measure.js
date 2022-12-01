const fs = require('fs');

module.exports.measureExecution = function (name, testSize, callback) {
    global.gc();
    const memoryData1 = process.memoryUsage();
    
    const results = [];
    const arr = Array(testSize).fill().map((_, index) => index + 1);
    for (let i = 0; i < 100; i++) {
        const start = process.hrtime();

        callback(arr);

        const elapsed = process.hrtime(start);
        results.push(elapsed[1] / 1000000);
    }
    
    const memoryData2 = process.memoryUsage();
    
    console.info('Running measurement for: %s', name);
    console.info('Memory allocation: %d', memoryData2.heapTotal - memoryData1.heapTotal);
    console.info('Average execution time: %dms', results.reduce((a, b) => a + b, 0) / results.length);
    console.info("");

    fs.writeFileSync(name + '.txt', results.join('\n'));
};
