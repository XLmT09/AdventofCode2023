const fs = require('fs');
const readline = require('readline');
var solution = 0;

const filePath = 'data.txt';

const fileStream = fs.createReadStream(filePath);
const rl = readline.createInterface({
  input: fileStream,
});

rl.on('line', (line) => {
  let game = line.split(": ")[1].split("; ");

  let highest_red = 0;
  let highest_green = 0;
  let highest_blue = 0;

  // Loop through pull in a game
  for (let i = 0; i < game.length; i++) {
    var pull = game[i].split(", ");

    // Loop through total block colour's within each pull
    for (let block of pull) {
      let number = parseInt(block.split(" ")[0])
      let colour = block.split(" ")[1]
      
      if (colour === "red" && number > highest_red) {
        highest_red = number;
      } else if (colour === "green" && number > highest_green) {
        highest_green = number;
      } else if (colour === "blue" && number > highest_blue) {
        highest_blue = number;
      }
    }
  }

  solution += (highest_red * highest_green * highest_blue);

  // Solution is the last output from this log
  console.log(solution);
});
