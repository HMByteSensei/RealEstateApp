const bcrypt = require('bcrypt');

const password = "test"; // Nova lozinka
const saltRounds = 10;

bcrypt.hash(password, saltRounds, (err, hash) => {
    if (err) {
        console.error(err);
        return;
    }
    console.log("Hash:", hash);
});
