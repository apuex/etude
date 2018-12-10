let object = {
  hello: "world",
  bizar: "rel"
};

console.log('for(var k in object) console.log(k, object[k]);');
for(var k in object) console.log(k, object[k]);

console.log('Object.keys(object).forEach(k => console.log(k, object[k]));');
Object.keys(object).forEach(k => console.log(k, object[k]));


