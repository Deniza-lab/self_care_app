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
                req.session.userId = results[0].user_id;
				console.log("Session data after login:", req.session);			
				res.redirect('/dashboard');
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

// LOGGED IN PAGES
app.get('/dashboard', function (req, res, next) {
	if (req.session.loggedin){
        const userRole = req.session.userrole;
		const userId = req.session.userId;
        console.log("Userrole:", userRole);

		if(userRole === "user"){
            console.log("User ID:", userId);
            
            const query = "SELECT date_time, emotion, skill_name, skill_info FROM records WHERE user_id = ?";
            conn.query(query, [userId], function (error, results) {
                if (error) {
                    console.error("Database error:", error);
                    return next(error);
                }
                
                res.render('user/myRecord', { records: results });
            });
        }
        else if (userRole === "admin") {
			res.redirect('/admin/moderator');
        } else {
			res.send('Page not found for this user ');
		}
	} else {		
		res.send('Please login to view this page!');
	}
});

app.get('/user/myRecord', function (req, res, next) {
	if (req.session.loggedin){
		if(req.session.userrole === "user"){
            const userId = req.session.userId;
            console.log("User ID:", userId);
            const query = "SELECT date_time, emotion, skill_name, skill_info FROM records WHERE user_id = ?";
            conn.query(query, [userId], function (error, results) {
                if (error) {
                    console.error("Database error:", error);
                    return next(error);
                }       
                res.render('user/myRecord', { records: results });
            });
        }
		else{
			res.send('Page not found for this user ');
		}
	}
	else {		
		res.send('Please login to view this page!');
	}
});

app.get('/user/myProfile', function (req, res, next) {
	if (req.session.loggedin){
		if(req.session.userrole === "user"){
			res.render('user/myProfile');
		}
		else{
			res.send('Page not found for this user ');
		}
	}
	else {		
		res.send('Please login to view this page!');
	}
});
//LOGGED IN EMOTIONS PAGE 
app.get('/user/emotions', function (req, res, next) {
    if (req.session.loggedin) {
        if (req.session.userrole === "user") {
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
                res.render('user/emotions', { emoIdData });
            });
        } else {
            res.send('Page not found for this user.');
        }
    } else {
        res.send('Please login to view this page!');
    }
});
app.get('/user/skills/:emo_id', function (req, res) {
    req.session.previousUrl = req.originalUrl;
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
            res.render('user/skills', { 
                title: 'Skills to manage feeling ' + (emotionName || emotionTitle), 
                skills: skillsResult 
            });
        });
    });
});

app.get('/user/skills', function (req, res, next) {
    if (req.session.loggedin) {
        if (req.session.userrole === "user") {
            const sql = `SELECT * FROM skills`; 
            conn.query(sql, function (err, result) {
                if (err) {
                    console.error('Database error:', err);
                    return res.status(500).send('Database error');
                }
                res.render('user/skills', { title: 'All Skills', skills: result }); 
            });
        } else {
            res.send('Page not found for this user.');
        }
    } else {		
        res.send('Please login to view this page!');
    }
});
//ADD EMO+SKILL to MY RECORD
app.post('/user/records', function (req, res) {
    if (req.session.loggedin) {
        const userId = req.session.userId; 
        const emotion = req.body.emotion; 
        const skillName = req.body.skill_name;
        const skillInfo = req.body.skill_info;
        const dateTime = new Date(); 

        const sqlInsert = `
            INSERT INTO records (user_id, emotion, skill_name, skill_info, date_time) 
            VALUES (?, ?, ?, ?, ?)`;
        
        conn.query(sqlInsert, [userId, emotion, skillName, skillInfo, dateTime], function (err, result) {
            if (err) {
                console.error('Database error:', err);
                return res.status(500).send('Database error');
            }
            res.redirect(req.session.previousUrl || '/user/emotions'); 
        });
    } else {
        res.send('Please login to record skills!');
    }
});
//SUBMIT EMO/SKILL
app.get('/user/submitSkill', function (req, res, next) {
    if (req.session.loggedin && req.session.userrole === "user") {
        const sqlQuery = "SELECT emo_id, emo_categ FROM emotions_categories";
        const success = req.query.success === 'true';
        conn.query(sqlQuery, function (err, categories) {
            if (err) {
                console.log('DB error', err);
                return res.status(500).send('Database error');
            }
            res.render('user/submitSkill', { categories, success });
        });
    } else {
        res.send('Please login to view this page!');
    }
});
//SUBMIT SKILL FORM SUBMISSION            
app.post('/user/submitSkill', function (req, res, next) {
	if (req.session.loggedin){
		if(req.session.userrole === "user"){
            const userId = req.session.userId; 
            const emo = req.body.emoSubmit;
            const categ = req.body.emoCatSubmit;
            const skillName = req.body.skillName;
            const skillInfo = req.body.skillInfo;
            const dateTime = new Date();

            const sqlInsert = `
            INSERT INTO submissions (user_id, emotion, emo_categ, skill_name, skill_info, date_time)
            VALUES (?, ?, ?, ?, ?, ?)`;

            conn.query(sqlInsert, [userId, emo, categ, skillName, skillInfo, dateTime], function (err, result) {
                if (err) {
                    console.log('DB error', err);
                    return res.status(500).send('DB error');
                }
                console.log('New submission!')
                res.redirect('/user/submitSkill?success=true');
                
            });
		} else {
			res.send('Please login to make submissions!');
		}
	}
});

//MODERATOR PAGE
app.get('/admin/moderator', function (req, res, next) {
    if (req.session.loggedin) {
        if (req.session.userrole === "admin") {
            const sql = `
                SELECT * 
                FROM submissions 
            `;
            conn.query(sql, function (err, result) {
                if (err) {
                    console.error('Database error:', err);
                    return res.status(500).send('Database error');
                }

                res.render('admin/moderator', { submissions: result });
            });
        } else if (req.session.userrole === "user") {
            res.send('Access denied.');
        }
    } else {        
        res.send('Please login to view this page!');
    }
});

app.get('/logout',(req,res) => {
    req.session.destroy();
    res.redirect('/');
});
app.listen(3000);
console.log('Node app is running on port 3000');
