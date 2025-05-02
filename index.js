const express = require('express');
const app = express();
const port = 3000;

// ASCII art or any plain text
const asciiArt = `
┈┈┈┈┈┈▕▔╲
┈┈┈┈┈┈┈▏▕
┈┈┈┈┈┈┈▏▕▂▂▂
▂▂▂▂▂▂╱┈▕▂▂▂▏
▉▉▉▉▉┈┈┈▕▂▂▂▏
▉▉▉▉▉┈┈┈▕▂▂▂▏
▔▔▔▔▔▔╲▂▕▂▂▂
            
`;

app.get('/', (req, res) => {
    res.send(asciiArt);
}
);

app.listen(port, () => {
    console.log(`Server is running at http://localhost:${port}`);
    console.log(asciiArt); // Print ASCII art to the console
}
);