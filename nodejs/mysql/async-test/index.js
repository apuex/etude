const mysql      = require('mysql2');
const pool       = mysql.createPool({
  connectionLimit : 10,
  host            : 'concerto',
  user            : 'root',
  password        : 'my-secret-pw',
  database        : 'mysql'
});

console.log("query user");
pool.query('SELECT user FROM db', function (error, results, fields) {
  if (error) {
    console.log(JSON.stringify(error));
    throw error;
  }
  // connected!
  console.log(JSON.stringify(results));
  //console.log(JSON.stringify(fields));
  
  pool.end(function(error){
    if(error)console.log(JSON.stringify(error));
    process.exit(0);
  });
});


