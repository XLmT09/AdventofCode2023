const fs = require('fs');
const readline = require('readline');
let solution = 0;

const filePath = 'data.txt';

const fileStream = fs.createReadStream(filePath);
const rl = readline.createInterface({
  input: fileStream
});

rl.on('line', (line) => {
  let game_number = parseInt(line.split(": ")[0].split(" ")[1]);
  let game = line.split(": ")[1].split("; ");

  let valid = true;

  // Loop through pull in a game
  for (let i = 0; i < game.length; i++) {
    var pull = game[i].split(", ");

    // Loop through total block colour's within each pull
    for (let block of pull) {
      let number = parseInt(block.split(" ")[0])
      let colour = block.split(" ")[1]
      
      if ((colour === "red" && number > 12) ||
          (colour === "green" && number > 13) ||
          (colour === "blue" && number > 14)) { valid = false; } 
    }
  }

  if (valid) {
    solution += game_number
  }

  // Solution is the last ouput from this log
  console.log(solution);
});