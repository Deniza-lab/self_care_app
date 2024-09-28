var mysql = require('mysql')
var conn = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'self_care_app'
});

conn.connect(function(err) {
    if (err) throw err;
    console.log('Database connected')
});

module.exports = conn;