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
app.use(express.urlencoded({ extended: true }));
app.use(express.json()); 
app.engine('ejs', require('ejs').__express);
app.use('/public', express.static('public'));


//PAGES
app.get('/', function (req, res){
res.render("home");
}); 
//Login + Register
app.get('/auth/login', function(req, res) {
	res.render('auth/login.ejs');
});
app.post('/auth/login', function(req, res) {
    console.log("Login attempt:", req.body);
	const { email, password } = req.body;
	if (email && password) {
		conn.query('SELECT * FROM users WHERE email = ? AND password = ?', [email, password], function(error, results, fields) {
			if (error) throw error;
			console.log(results.length);
			if (results.length > 0) {
				req.session.loggedin = true;			
				req.session.email = email;
				req.session.userrole = results[0].userrole;
				console.log(results.length);
				console.log("User email :",results[0].email);
				console.log("User role :",results[0].userrole)			
				res.redirect('/user/myProfile');
			} else {
				res.send('Incorrect email and/or password!');
			}			
		});
	} else {
		res.send('Please enter your email and password!');
	}
});
app.get('/auth/register', function (req, res){
	res.render("auth/register.ejs");
});

app.post('/auth/register', function(req, res) {
	const { email, password } = req.body;
    const userrole = 'user';

		const sql = 'INSERT INTO users (email, password, userrole) VALUES (?, ?, ?)';
		conn.query(sql, [email, password, userrole], (err, result) => {
			if (err) {
				return res.status(500).send('Error saving user: ' + err);
			}
			console.log('User registered')
            res.send('User registered successfully!');
		});
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

        
        const emoIdData = {};
        result.forEach(row => {
            if (!emoIdData[row.emo_id]) {
                emoIdData[row.emo_id] = [];
            }
            emoIdData[row.emo_id].push(row);
        });

        
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
    const emoId = req.params.emo_id; 
    const emotionName = req.query.emotion_name; 

    
    const sqlEmotion = `
    SELECT emotion 
    FROM emotions 
    WHERE emo_id = ?`;

    conn.query(sqlEmotion, [emoId], function (err, emotionResult) {
        if (err) {
            console.error('Database error:', err);
            return res.status(500).send('Database error');
        }

        if (emotionResult.length === 0) {
            return res.status(404).send('No emotions found for this category');
        }

    
        const emotionTitle = emotionResult[0].emotion; 

        
        const sqlSkills = `
        SELECT skills.skill_name, skills.skill_info 
        FROM emotions_skills 
        JOIN skills ON emotions_skills.skill_id = skills.skill_id 
        WHERE emotions_skills.emo_id = ?`; 

        conn.query(sqlSkills, [emoId], function (err, skillsResult) {
            if (err) {
                console.error('Database error:', err);
                return res.status(500).send('Database error');
            }

            res.render('skills', { 
                title: 'Skills to manage feeling ' + (emotionName || emotionTitle), 
                skills: skillsResult 
            });
        });
    });
});
app.get('/logout',(req,res) => {
    req.session.destroy();
    res.redirect('/');
});
app.listen(3000);
console.log('Node app is running on port 3000');
