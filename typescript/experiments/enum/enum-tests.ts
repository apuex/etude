enum Direction {
    Up = 1,
    Down,
    Left,
    Right,
}

class Action {
  direction: Direction;
  amount: number;
}

const actions1: Action[] = [
  { direction: Direction.Up, amount: 1 },
  { direction: Direction.Down, amount: 1 },
  { direction: Direction.Left, amount: 1 },
  { direction: Direction.Right, amount: 1 }
];

const actions2: Action[] = [
{direction:1,amount:1},
{direction:2,amount:1},
{direction:3,amount:1},
{direction:4,amount:1}
];

const actions3: Action[] = [ 
{"direction":Direction["Up"],"amount":1},
{"direction":Direction["Down"],"amount":1},
{"direction":Direction["Left"],"amount":1},
{"direction":Direction["Right"],"amount":1}
];

const actions4: Action[] = [ 
{"direction":Direction[1],"amount":1},
{"direction":Direction[2],"amount":1},
{"direction":Direction[3],"amount":1},
{"direction":Direction[4],"amount":1}
];

console.log('actions1');
actions1.forEach(action => {
  console.log(JSON.stringify(action));
});
console.log('actions2');
actions2.forEach(action => {
  console.log(JSON.stringify(action));
});
console.log('actions3');
actions3.forEach(action => {
  console.log(JSON.stringify(action));
});
console.log('actions4');
actions4.forEach(action => {
  console.log(JSON.stringify(action));
});
