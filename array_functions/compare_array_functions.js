const { measureExecution } = require('./measure');
const testSize = 10 ** 6;

function someFn(i) {
  return (i * 3 * 8 / 1200 * 0.002 / 40 * 0.2);
}

measureExecution('forEach', testSize, (arr) => {
    let sumForEach = 0;
    arr.forEach(item => sumForEach += someFn(item));
    return sumForEach;
});

measureExecution('reduce', testSize, (arr) => {
    let sumReduce = 0;
    sumReduce = arr.reduce((_, item) => {
        return sumReduce += someFn(item);
    });

    return sumReduce;
});

measureExecution('map', testSize, (arr) => {
    let sumMap = 0;
    arr.map(item => (sumMap += someFn(item)));
    return sumMap;
});

measureExecution('filter', testSize, (arr) => {
    let sumFilter = 0;
    arr.filter(item => (sumFilter += someFn(item)));
    return sumFilter;
});

measureExecution('for', testSize, (arr) => {
    let sumFor = 0;
    for (let j = 0; j < arr.length; j++) {
        sumFor += arr[j];
    }
    
    return sumFor;
});
