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
//EMOTIONS PAGE  
app.get('/emotions', function (req, res) {
    const emoIds = ['ag', 'br', 'fr', 'sc', 'sd'];
    const placeholders = emoIds.map(() => '?').join(', ');
    const sql = `SELECT emo_id, emotion FROM emotions WHERE emo_id IN (${placeholders})`;

    console.log('Executing SQL:', sql, emoIds); 

    conn.query(sql, emoIds, function(err, result) {
        if (err) {
            console.error('Database error:', err);
            return res.status(500).send('Database error');
        }

        if (result.length === 0) {
            console.log('No emotions found for the specified emo_ids.');
        } else {
            console.log('Fetched results:', JSON.stringify(result, null, 2)); 
        }

        // Create emoIdData object to organize emotions by emo_id
        const emoIdData = result.reduce((acc, row) => {
            if (!acc[row.emo_id]) {
                acc[row.emo_id] = [];
            }
            acc[row.emo_id].push(row.emotion);
            return acc;
        }, {});

        // Render the EJS file with organized data
        res.render('emotions', { title: "Emotions Lists", emoIdData });
    });
});
//SKILLS PAGE
app.get('/skills', function (req, res) {
    const sql = 'SELECT * FROM skills';

    conn.query(sql, function (err, result) {
        if (err) {
            console.error('Database error:', err);
            return res.status(500).send('Database error');
        }
        res.render('skills', { title: '', skills: result });
    });
});

//SKILLS FOR ALL EMO GROUPS
app.get('/skills/:emo_id', function (req, res) {
    const emoId = req.params.emo_id;

    const sql = `
        SELECT skills.skill_name, skills.skill_info, emotions.emotion, emotions.id 
        FROM emotions_skills 
        JOIN skills ON emotions_skills.skill_id = skills.skill_id 
        JOIN emotions ON emotions_skills.emo_id = emotions.emo_id 
        WHERE emotions_skills.emo_id = ?`;

    conn.query(sql, [emoId], function (err, result) {
        if (err) {
            console.error('Database error:', err);
            return res.status(500).send('Database error');
        }
        console.log(result);
        const emotionName = result.length > 0 ? result[0].emotion : emoId; 
        res.render('skills', { title: 'Skills for ' + emotionName, skills: result });
    });
});

app.listen(3000);
console.log('Node app is running on port 3000');
