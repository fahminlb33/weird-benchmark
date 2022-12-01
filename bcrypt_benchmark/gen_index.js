const fs = require("fs");

for (let i = 1; i <= 1000; i++) {
    fs.appendFileSync("all1.txt", `1\n`);
    fs.appendFileSync("all2.txt", `2\n`);
}