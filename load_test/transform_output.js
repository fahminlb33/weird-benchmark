const fs = require('fs');
const events = require('events');
const readline = require('readline');

const CATEGORY = 2;

(async function processLineByLine() {
    try {
        const rl = readline.createInterface({
            input: fs.createReadStream('fixstage.json'),
            crlfDelay: Infinity
        });

        const pointConnecting = [];
        const pointDuration = [];
        rl.on('line', (line) => {
            const data = JSON.parse(line);
            
            if (data.type !== 'Point') {
                return;
            }
            
            if (data.metric === "http_req_connecting") {
                pointConnecting.push(data.data.value);
                return;
            }

            if (data.metric === "http_req_duration") {
                pointDuration.push(data.data.value);
                return;
            }
        });

        await events.once(rl, 'close');

        const wfs = fs.createWriteStream('fixstage-transformed.csv');
        wfs.write('category,connecting,duration\n');
        for (let i = 0; i < pointConnecting.length; i++) {
            wfs.write(`${CATEGORY},${pointConnecting[i]},${pointDuration[i]}\n`);
        }

        wfs.close();

    } catch (err) {
        console.error(err);
    }
})();