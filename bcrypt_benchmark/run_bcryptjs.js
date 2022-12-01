const bcryptjs = require("bcryptjs");

(async () => {
    const N_ITERATIONS = 1000;
    for (let i = 0; i < N_ITERATIONS; i++) {
        await bcryptjs.hash(`pass${i}`, 10);
    }
})();