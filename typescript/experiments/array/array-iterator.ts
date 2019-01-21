let array = ['a', 'b', 'c'];
let it = array[Symbol.iterator]();

console.log('it = ', JSON.stringify(it));
console.log('it.next() = ', it.next().value);
console.log('it.return() = ', it.return().value);
console.log('it.next() = ', it.next().value);
console.log('it.return() = ', it.value);
console.log('it.next() = ', it.next().value);
console.log('it.return() = ', it.return().value);
console.log('it.next() = ', it.next());


