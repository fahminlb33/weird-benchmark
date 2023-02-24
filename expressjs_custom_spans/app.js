// load config
const config = require('./config');

// add apm
const apm = require('elastic-apm-node').start({
    serviceName: config.SERVICE_NAME,
    secretToken: '',
    apiKey: '',
    serverUrl: config.ELASTIC_APM_SERVER_URL,
});

const traceSpan = async (name, scope, callback) => {
    const span = apm.startSpan(name, "app");
    await callback();

    if (span) {
        span.setLabel("app_scope", scope);
        span.end();
    }
}

const bcrypt = require('bcrypt')
const bcryptjs = require('bcryptjs')
const jsonwebtoken = require('jsonwebtoken')
const express = require('express')
const { MongoClient } = require("mongodb");

const dbClient = new MongoClient(config.MONGODB_URI, { useUnifiedTopology: true });

const app = express()

app.use(express.json())

app.get('/', (req, res) => {
    res.send('Hello World!')
})

app.post('/login-bcryptjs', async (req, res) => {
    const user = await dbClient.db(config.DB_NAME).collection("user").findOne({ email: req.body.user });
    if (!user) {
        res.status(401).send('User or password do not match');
        return;
    }

    let match = false;
    await traceSpan("compare using bcryptjs", "login-bcryptjs", async () => {
        match = await bcryptjs.compare(req.body.password, user.password);
    });
    if (!match) {
        res.status(401).send('User or password do not match');
        return;
    }

    const token = jsonwebtoken.sign({ user: user.name }, config.JWT_SECRET);
    const company = await dbClient.db(config.DB_NAME).collection("company").findOne({ companyId: user.companyId });

    res.json({
        user: user.user,
        accessToken: token,
        company
    })
})

app.post('/login-bcrypt', async (req, res) => {
    const user = await dbClient.db(config.DB_NAME).collection("user").findOne({ email: req.body.user });
    if (!user) {
        res.status(401).send('User or password do not match');
        return;
    }

    let match = false;
    await traceSpan("compare using bcrypt-native", "login-bcrypt", async () => {
        match = await bcrypt.compare(req.body.password, user.password);
    });
    if (!match) {
        res.status(401).send('User or password do not match');
        return;
    }

    const token = jsonwebtoken.sign({ user: user.name }, config.JWT_SECRET);
    const company = await dbClient.db(config.DB_NAME).collection("company").findOne({ companyId: user.companyId });

    res.json({
        user: user.user,
        accessToken: token,
        company
    })
})

app.listen(config.PORT, () => {
    console.log(`Example app listening on port ${config.PORT}`)
})

process.on('uncaughtException', error => {
    console.log(error)
    process.exit(1)
})