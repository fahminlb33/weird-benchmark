const bcrypt = require("bcrypt");

(async () => {
    const N_ITERATIONS = 1000;
    for (let i = 0; i < N_ITERATIONS; i++) {
        await bcrypt.hash(`pass${i}`, 10);
    }
})();