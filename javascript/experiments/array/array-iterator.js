var array = ['a', 'b', 'c'];
var it = array[Symbol.iterator]();

console.log('it.next() = ', it.next().value);
console.log('it.next() = ', it.next().value);
console.log('it.next() = ', it.next().value);
console.log('it.next() = ', it.next());


