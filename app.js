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
    const sql = `
        SELECT emotions.emotion, emotions.emo_id, emotions_categories.emo_categ 
        FROM emotions 
        JOIN emotions_categories ON emotions.emo_id = emotions_categories.emo_id
    `;

    conn.query(sql, function (err, result) {
        if (err) {
            console.error('Database error:', err);
            return res.status(500).send('Database error');
        }

        // Group emotions by emo_id for easier access in the template
        const emoIdData = {};
        result.forEach(row => {
            if (!emoIdData[row.emo_id]) {
                emoIdData[row.emo_id] = [];
            }
            emoIdData[row.emo_id].push(row);
        });

        // Render the emotions page and pass the data to the template
        res.render('emotions', { emoIdData });
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
    const emotionId = req.params.id; // Get the specific emotion ID
    const emoId = req.query.emo_id; // Get the emo_id from the query parameters

   // Step 1: Fetch the emotions that belong to this emo_id category
   const sqlEmotion = `
   SELECT emotion 
   FROM emotions 
   WHERE emo_id = ?`;

   conn.query(sqlEmotion, [emotionId], function (err, emotionResult) {
   if (err) {
       console.error('Database error:', err);
       return res.status(500).send('Database error');
   }

   if (emotionResult.length === 0) {
       return res.status(404).send('No emotions found for this category');
   }

   const emotionName = emotionResult[0].emotion;  // Use the first emotion for the title

        const sqlSkills = `
        SELECT skills.skill_name, skills.skill_info 
        FROM emotions_skills 
        JOIN skills ON emotions_skills.skill_id = skills.skill_id 
        WHERE emotions_skills.emo_id = ?`; // This filters by emo_id

    conn.query(sqlSkills, [emoId], function (err, skillsResult) {
        if (err) {
            console.error('Database error:', err);
            return res.status(500).send('Database error');
        }

        // Render the page with the emotion name in the title and skills in the content
        res.render('skills', { 
            title: 'Skills for ' + emotionName, 
            skills: skillsResult // Pass the filtered skills to the view 
        });
    });
});
});

app.listen(3000);
console.log('Node app is running on port 3000');
