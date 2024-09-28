var express = require('express');
var app = express();
var session = require('express-session')
var conn = require('./dbConfig');
app.set('view engine','ejs');
app.use(session({
    secret: 'yoursecret',
    resave: true,
    saveUninitialized: true
}))

app.engine('ejs', require('ejs').__express);
app.use('/public', express.static('public'));

//PAGES
app.get('/', function (req, res){
res.render("home");
});   
app.get('/emotions', function (req, res){
    res.render("emotions");
    }); 
app.get('/skills', function (req, res){
    res.render("skills"); 
}); 

app.listen(3000);
console.log('Node app is running on port 3000');
