const express = require('express');
const { exec } = require('child_process');

const app = express();
const port = 3001;

app.use(express.json());

app.post('/start', (req, res) => {
    const process = exec('bash memory_game.sh');

    console.log("Hello");

    process.stdout.on('data', (data) => {
        const output = data.toString().trim();
        res.json({ output });
    });

    process.stderr.on('data', (data) => {
        console.error(`Error: ${data}`);
    });
});

app.post('/check', (req, res) => {
    const process = exec('bash memory_game.sh');

    process.stdout.on('data', (data) => {
        const output = data.toString().trim();
        res.json({ output });
    });

    process.stderr.on('data', (data) => {
        console.error(`Error: ${data}`);
    });

    process.stdin.write(req.body.input + '\n');
    process.stdin.end();
});

app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
