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

    // Pagination parameters
    const page = parseInt(req.query.page) || 1; 
    const limit = parseInt(req.query.limit) || 10; 
    const offset = (page - 1) * limit;

    // Get the emotion name
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

        // Get the total count of skills for pagination
        const sqlCount = `
        SELECT COUNT(*) AS total 
        FROM emotions_skills 
        JOIN skills ON emotions_skills.skill_id = skills.skill_id 
        WHERE emotions_skills.emo_id = ?`;

        conn.query(sqlCount, [emoId], function (err, countResult) {
            if (err) {
                console.error('Database error:', err);
                return res.status(500).send('Database error');
            }

            const totalSkills = countResult[0].total;
            const totalPages = Math.ceil(totalSkills / limit);

            // Get paginated skills
            const sqlSkills = `
            SELECT skills.skill_name, skills.skill_info 
            FROM emotions_skills 
            JOIN skills ON emotions_skills.skill_id = skills.skill_id 
            WHERE emotions_skills.emo_id = ? 
            LIMIT ? OFFSET ?`;

            conn.query(sqlSkills, [emoId, limit, offset], function (err, skillsResult) {
                if (err) {
                    console.error('Database error:', err);
                    return res.status(500).send('Database error');
                }

                res.render('skills', {
                    title: 'Skills to manage feeling ' + (emotionName || emotionTitle),
                    skills: skillsResult,
                    currentPage: page,
                    totalPages,
                    limit,
                    emoId
                });
            });
        });
    });
});


// LOGGED IN PAGES
app.get('/dashboard', function (req, res, next) {
	if (req.session.loggedin){
        const userRole = req.session.userrole;
		const userId = req.session.userId;
        const username = req.session.email
        console.log("Userrole:", userRole);

		if(userRole === "user"){
            const page = parseInt(req.query.page) || 1; // Current page, default is 1
            const limit = parseInt(req.query.limit) || 10; // Items per page, default is 10
            const offset = (page - 1) * limit;

            const countQuery = "SELECT COUNT(*) AS total FROM records WHERE user_id = ?";
            
            const query = "SELECT date_time, emotion, skill_name, skill_info FROM records WHERE user_id = ? LIMIT ? OFFSET ?";
            conn.query(countQuery, [userId], function (countError, countResults) {
                if (countError) {
                    console.error("Database error:", countError);
                    return next(countError);
                }

                const totalRecords = countResults[0].total;
                const totalPages = Math.ceil(totalRecords / limit);
            
            conn.query(query, [userId, limit, offset], function (error, results) {
                if (error) {
                    console.error("Database error:", error);
                    return next(error);
                }
                
                res.render('user/myRecord', { 
                    records: results, 
                    username: req.session.email, 
                    currentPage: page,
                    totalPages,
                    limit 
                });
            });
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
            const username = req.session.email;
            console.log("User ID:", userId);
            const query = "SELECT date_time, emotion, skill_name, skill_info FROM records WHERE user_id = ?";
            conn.query(query, [userId], function (error, results) {
                if (error) {
                    console.error("Database error:", error);
                    return next(error);
                }       
                res.render('user/myRecord', { records: results, username: req.session.email });
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
        console.log("record added")
    } else {
        res.send('Please login to record skills!');
    }
});
//SUBMIT EMO/SKILL
app.get('/user/submitSkill', (req, res) => {
    if (req.session.loggedin && req.session.userrole === "user") {
        res.render('user/submitSkill');
    } else {
        res.send('Please login to access this page!');
    }
});
// New Emotion Page
app.get('/user/submitEmotion', (req, res) => {
    if (req.session.loggedin && req.session.userrole === "user") {
        const sqlQuery = "SELECT emo_id, emo_categ FROM emotions_categories";
        const success = req.query.success === 'true';
        conn.query(sqlQuery, (err, categories) => {
            if (err) {
                console.log('DB error', err);
                return res.status(500).send('Database error');
            }
            res.render('user/submitEmotion', { categories, success });
        });
    } else {
        res.send('Please login to view this page!');
    }
});
app.post('/user/submitEmotion', function (req, res, next) {
    if (req.session.loggedin && req.session.userrole === "user") {
        const userId = req.session.userId;
        const emo = req.body.emoSubmit;
        const categ = req.body.emoCatSubmit;
        const subType = req.query.subType || 'New Emotion';
        const dateTime = new Date();

        const sqlInsert = `
        INSERT INTO submissions (user_id, emotion, emo_categ, sub_type, date_time)
        VALUES (?, ?, ?, ?, ?)`;

        conn.query(sqlInsert, [userId, emo, categ, subType, dateTime], function (err, result) {
            if (err) {
                console.log('DB error', err);
                return res.status(500).send('DB error');
            }
            console.log('New emotion submission!');
            res.redirect('/user/submitEmotion?success=true');
        });
    } else {
        res.send('Please login to submit an emotion!');
    }
});

// New Skill for Existing Emotion Page
// Route to get emotions for a specific category
app.get('/user/getEmotionsByCategory', (req, res) => {
    const selectedCategory = req.query.category; 
    console.log("Received emo_categ:", selectedCategory);
    
    const sqlQuery = `
        SELECT e.emotion
        FROM emotions AS e
        JOIN emotions_categories AS ec ON e.emo_id = ec.emo_id
        WHERE ec.emo_categ = ?`;
    
        conn.query(sqlQuery, [selectedCategory], function (err, results) {
            if (err) {
                console.error('Database error:', err);
                return res.status(500).send('Error fetching emotions');
            }
            res.json(results); // Return results as JSON
        });
    });
app.get('/user/submitSkillForEmotion', (req, res) => {
    if (req.session.loggedin && req.session.userrole === "user") {
        const success = req.query.success === 'true';
        const query = `SELECT emo_categ FROM emotions_categories`;

        conn.query(query, (err, categories) => {
            if (err) {
                console.log('DB error:', err);
                return res.status(500).send('Database error');
            }
            res.render('user/submitSkillForEmotion', { categories, success });
        });
    } else {
        res.send('Please login to view this page!');
    }
});


app.post('/user/submitSkillForEmotion', function (req, res) {
    if (req.session.loggedin && req.session.userrole === "user") {
        const userId = req.session.userId;
        const subType = "New Skill for Existing Emotion"; 
        const dateTime = new Date();
        
        const { emo_categ, emotion, skill_name, skill_info } = req.body;

        const sqlInsert = `
            INSERT INTO submissions (user_id, emotion, emo_categ, skill_name, skill_info, date_time, sub_type)
            VALUES (?, ?, ?, ?, ?, ?, ?)`;

        conn.query(sqlInsert, [userId, emotion, emo_categ, skill_name, skill_info, dateTime, subType], function (err, result) {
            if (err) {
                console.log('DB error:', err);
                return res.status(500).send('DB error');
            }
            res.redirect('/user/submitSkillForEmotion?success=true');
        });
    } else {
        res.send('Please login to make submissions!');
    }
});

// New Emotion and Skill Page
app.get('/user/submitEmotionAndSkill', (req, res) => {
    if (req.session.loggedin && req.session.userrole === "user") {
        const success = req.query.success === 'true';
        const query = `SELECT emo_categ FROM emotions_categories`;

        conn.query(query, (err, categories) => {
            if (err) {
                console.log('DB error:', err);
                return res.status(500).send('Database error');
            }
            res.render('user/submitEmotionAndSkill', { categories, success });
        });
    } else {
        res.send('Please login to view this page!');
    }
});

// POST route to handle form submission
app.post('/user/submitEmotionAndSkill', (req, res) => {
    if (req.session.loggedin && req.session.userrole === "user") {
        const userId = req.session.userId;
        const subType = "New Emotion and Skill"; // Indicating the type of submission
        const dateTime = new Date();

        const { emo_categ, emotion, skill_name, skill_info } = req.body;

        // Insert into the submissions table
        const sqlInsert = `
            INSERT INTO submissions (user_id, emotion, emo_categ, skill_name, skill_info, date_time, sub_type)
            VALUES (?, ?, ?, ?, ?, ?, ?)`;

        conn.query(
            sqlInsert,
            [userId, emotion, emo_categ, skill_name, skill_info, dateTime, subType],
            (err, result) => {
                if (err) {
                    console.log('DB error:', err);
                    return res.status(500).send('DB error');
                }
                res.redirect('/user/submitEmotionAndSkill?success=true');
            }
        );
    } else {
        res.send('Please login to make submissions!');
    }
});


//MODERATOR PAGE
app.get('/admin/moderator', function (req, res, next) {
    if (req.session.loggedin && req.session.userrole === "admin") {
        console.log("Query parameters:", req.query);
        const filter = req.query.type; 
        console.log("Filter:", filter);
        const sql = filter
            ? `SELECT * FROM submissions WHERE sub_type = ?`
            : `SELECT * FROM submissions`;
        const params = filter ? [filter] : [];

        const categoryQuery = `SELECT emo_categ FROM emotions_categories`;

        conn.query(sql, params, function (err, result) {
            if (err) {
                console.error('Database error:', err);
                return res.status(500).send('Database error');
            }

            conn.query(categoryQuery, function (err, categories) {
                if (err) {
                    console.error('Database error:', err);
                    return res.status(500).send('Database error');
                }

                res.render('admin/moderator', { submissions: result, categories: categories, filter });
            });
        });
    } else if (req.session.loggedin && req.session.userrole === "user") {
        res.send('Access denied.');
    } else {
        res.send('Please login to view this page!');
    }
});
// DELETE FUNCTION
app.delete('/admin/moderator/delete/:id', (req, res) => {
    const submissionId = req.params.id; 
    console.log('Received request to delete submission with ID:', submissionId);
    const query = 'DELETE FROM submissions WHERE id = ?';

    conn.query(query, [submissionId], (err, result) => {
        if (err) {
    console.error('Error deleting submission:', err);
    return res.status(500).send('Failed to delete submission');
        }
        
        console.log('Deleted submission with ID:', submissionId);
        res.send('Submission deleted successfully');
    });
});
// Update submission route
app.put('/admin/moderator/edit/:id', (req, res) => {
    const submissionId = req.params.id;
    const { emotion, category, skill_name, skill_description } = req.body;

    const updateQuery = `UPDATE submissions SET emotion = ?, emo_categ = ?, skill_name = ?, skill_info = ? WHERE id = ?`;
    const params = [emotion, category, skill_name, skill_description, submissionId];

    conn.query(updateQuery, params, (err, result) => {
        if (err) {
            console.error('Database error:', err);
            return res.status(500).json({ error: 'Failed to update submission' });
        }
        res.status(200).json({ success: true });
    });
});

// SUBMIT route
app.post('/moderator/submit', (req, res) => {
    const { sub_type, emotion, emo_categ, skill_name, skill_info } = req.body;
    let emo_id, skill_id;

    // Function to send a response only once after all processing is done
    function sendResponse(message, status = 200) {
        res.status(status).json({ message });
    }

    // 1. Handle new emotion
    if (sub_type === 'New Emotion' || sub_type === 'New Emotion and Skill') {
        console.log('Submitting an entry for New Emotion');

        // Query to get emo_id based on emo_categ
        conn.query(
            'SELECT emo_id FROM emotions_categories WHERE emo_categ = ?',
            [emo_categ],
            (err, categoryResult) => {
                if (err) {
                    console.error(err);
                    return sendResponse('Internal server error', 500);
                }

                if (categoryResult.length === 0) {
                    return sendResponse('Invalid emotion category', 400);
                }

                emo_id = categoryResult[0].emo_id;

                // Query to check if the emotion already exists for the given emo_id
                conn.query(
                    'SELECT emo_id FROM emotions WHERE emotion = ? AND emo_id = ?',
                    [emotion, emo_id],
                    (err, existingEmotion) => {
                        if (err) {
                            console.error(err);
                            return sendResponse('Internal server error', 500);
                        }

                        if (existingEmotion.length > 0) {
                            // Emotion already exists, so use existing emo_id
                            emo_id = existingEmotion[0].emo_id;
                            if (sub_type === 'New Emotion and Skill') {
                                // Proceed with adding the new skill after emotion check
                                addNewSkill(emo_id);
                            } else {
                                // For "New Emotion", just respond
                                sendResponse('New Emotion already exists');
                            }
                        } else {
                            // Insert new emotion if it doesn't exist
                            conn.query(
                                'INSERT INTO emotions (emotion, emo_id) VALUES (?, ?)',
                                [emotion, emo_id],
                                (err, result) => {
                                    if (err) {
                                        console.error(err);
                                        return sendResponse('Internal server error', 500);
                                    }

                                    console.log('New emotion inserted');
                                    if (sub_type === 'New Emotion and Skill') {
                                        // Proceed with adding the new skill after emotion insertion
                                        addNewSkill(emo_id);
                                    } else {
                                        sendResponse('New Emotion inserted successfully');
                                    }
                                }
                            );
                        }
                    }
                );
            }
        );
    }

     // 2. Handle new skill for existing emotion
     if (sub_type === 'New Skill for Existing Emotion') {
        console.log('Submitting an entry for New Skill for Existing Emotion');

        // Retrieve emo_id for the existing emotion
        conn.query(
            'SELECT emo_id FROM emotions_categories WHERE emo_categ = ?',
            [emo_categ],
            (err, emoResult) => {
                if (err) {
                    console.error(err);
                    return sendResponse('Internal server error', 500);
                }

                if (emoResult.length === 0) {
                    return sendResponse('Emotion does not exist for the specified category', 400);
                }

                emo_id = emoResult[0].emo_id;

                addNewSkill(emo_id);
            }
        );
    }

    // Function to add a new skill and link it to an emotion
    function addNewSkill(emo_id) {
        console.log('Submitting an entry for New Skill');

        conn.query(
            'INSERT INTO skills (skill_name, skill_info) VALUES (?, ?)',
            [skill_name, skill_info],
            (err, skillResult) => {
                if (err) {
                    console.error(err);
                    return sendResponse('Internal server error', 500);
                }

                skill_id = skillResult.insertId;

                conn.query(
                    'INSERT INTO emotions_skills (emo_id, skill_id) VALUES (?, ?)',
                    [emo_id, skill_id],
                    (err) => {
                        if (err) {
                            console.error(err);
                            return sendResponse('Internal server error', 500);
                        }

                        console.log('New skill linked to emotion');
                        sendResponse('New Skill for Existing Emotion submitted successfully');
                    }
                );
            }
        );
    }

 conn.query(
     'DELETE FROM submissions WHERE emotion = ? AND emo_categ = ? AND skill_name = ? AND skill_info = ?',
       [emotion, emo_categ, skill_name, skill_info],
      (err) => {
           if (err) {
              console.error(err);
           } else {
              console.log('Submission cleaned up');
          }
       }
   );
});


//Logout
app.get('/logout',(req,res) => {
    req.session.destroy();
    res.redirect('/');
});
app.listen(3000);
console.log('Node app is running on port 3000');
