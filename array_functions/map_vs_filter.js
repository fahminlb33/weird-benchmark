const { measureExecution } = require('./measure');
const testSize = 10 ** 6;

measureExecution('odds-map', testSize, (arr) => {
    const results = []
    return arr.map((x) => {
         if (x % 2 === 0) results.push(x);
    });
});

measureExecution('odds-filter', testSize, (arr) => {
    return arr.filter(x=>x % 2 === 0);
});
