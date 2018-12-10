let nua: number[] = [1,2,3,5,4,7,7,6,8];
let nus: Set<number> = new Set<number>(nua);
let nusa: number[] = new Array<number>();
nus.forEach(x => nusa.push(x));

let tsa = [
    new Date(Date.parse('2018-01-02T03:04:05.666Z')),
    new Date(Date.parse('2018-01-02T03:04:05.666Z')),
    new Date(Date.parse('2018-01-02T03:04:06.666Z')),
    new Date(Date.parse('2018-01-02T03:04:04.666Z')),
    new Date(Date.parse('2018-01-02T03:04:03.666Z')),
    new Date(Date.parse('2018-01-02T03:04:02.666Z')),
    new Date(Date.parse('2018-01-02T03:04:01.666Z')),
    new Date(Date.parse('2018-01-02T03:04:00.666Z')),
    new Date(Date.parse('2018-01-02T03:04:00.666Z')),
    new Date(Date.parse('2018-01-02T03:04:07.666Z'))
  ];

let tss = new Set(tsa.map(x => x.valueOf()).sort());
// equivalent to
// let tss = new Set(tsa.map(x => x.valueOf()).sort((d1, d2) => (d1 < d2 ? 0 : 1)));

console.log("original number array:");
nua.forEach(x => console.log(x));
console.log("sorted number array:");
nua.sort().forEach(x => console.log(x));
console.log("number set:");
nus.forEach(x => console.log(x));
console.log("number set back to array:");
nusa.forEach(x => console.log(x));
console.log("number set back to array using Array.from():");
Array.from(nus).forEach(x => console.log(x));

console.log("original date array:");
tsa.forEach(x => console.log(x));
console.log("sorted date set:");
tss.forEach(x => console.log(x));
console.log("sorted date.valueOf() set:");
tss.forEach(x => console.log(x.valueOf()));

console.log("new Date('2018-01-02T03:04:05.666Z')");
console.log(new Date('2018-01-02T03:04:05.666Z'));
console.log("Date.parse('2018-01-02T03:04:05.666Z')");
console.log(Date.parse('2018-01-02T03:04:05.666Z'));

console.log("load set to array:");
let tssa: number[] = new Array<number>();
tss.forEach(x => tssa.push(x));
tssa.forEach(x => console.log(x));

