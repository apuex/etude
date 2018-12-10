function compare(l: any, r: any): number {
  if(l.id < r.id) return -1;
  else if(l.id > r.id) return 1;
  else return 0;
}

let data = [
  { id: 1, text: 'hello' },
  { id: 2, text: 'world' },
  { id: 4, text: 'babe' },
  { id: 3, text: 'cafe' }
];

data.sort(compare)
.map(x => x.text)
.forEach(x => console.log(x));

