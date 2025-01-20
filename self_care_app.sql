-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 09, 2024 at 07:45 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `self_care_app`
--

-- --------------------------------------------------------

--
-- Table structure for table `emotions`
--

CREATE TABLE `emotions` (
  `id` int(11) NOT NULL,
  `emo_id` varchar(20) NOT NULL,
  `emotion` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `emotions`
--

INSERT INTO `emotions` (`id`, `emo_id`, `emotion`) VALUES
(1, 'fr', 'scared'),
(2, 'fr', 'nervous'),
(3, 'fr', 'anxious'),
(4, 'fr', 'panicky'),
(5, 'fr', 'distressed'),
(6, 'fr', 'worried'),
(7, 'fr', 'uneasy'),
(8, 'sd', 'hurt'),
(9, 'sd', 'depressed'),
(10, 'sd', 'melancholic'),
(11, 'sd', 'hopeless'),
(12, 'sd', 'grief'),
(13, 'sd', 'miserable'),
(14, 'sd', 'guilty'),
(15, 'sd', 'regretful'),
(16, 'sd', 'rejected'),
(17, 'sd', 'homesick'),
(18, 'sd', 'humiliated'),
(19, 'sd', 'insecure'),
(20, 'sd', 'isolated'),
(21, 'sd', 'lonely'),
(22, 'ag', 'angry'),
(23, 'ag', 'agitated'),
(24, 'ag', 'antagonistic'),
(25, 'ag', 'annoyed'),
(26, 'ag', 'grumpy'),
(27, 'ag', 'frustrated'),
(28, 'ag', 'hatred'),
(29, 'ag', 'resentment'),
(30, 'ag', 'vengeful'),
(31, 'ag', 'rage'),
(32, 'ag', 'disgusted'),
(33, 'ag', 'jealous'),
(34, 'br', 'bored'),
(35, 'sc', 'ashamed'),
(36, 'sc', 'embarassed'),
(37, 'sc', 'self-conscious'),
(38, 'sc', 'self-aware'),
(39, 'sc', 'anxious'),
(40, 'sc', 'fearful'),
(41, 'sc', 'low self-esteem'),
(42, 'fr', 'paranoid'),
(43, 'fr', 'flight'),
(44, 'sd', 'suicidal'),
(45, 'sd', 'overwhelmed'),
(46, 'ag', 'TEST'),
(47, 'ag', 'violent'),
(48, 'sc', 'judgemental'),
(49, 'fr', 'frozen'),
(50, 'br', 'numb'),
(51, 'br', 'flat'),
(52, 'sd', 'test2');

-- --------------------------------------------------------

--
-- Table structure for table `emotions_categories`
--

CREATE TABLE `emotions_categories` (
  `emo_id` varchar(20) DEFAULT NULL,
  `emo_categ` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `emotions_categories`
--

INSERT INTO `emotions_categories` (`emo_id`, `emo_categ`) VALUES
('ag', 'Anger'),
('br', 'Boredom'),
('fr', 'Fear'),
('sc', 'Self-conscious'),
('sd', 'Sadness');

-- --------------------------------------------------------

--
-- Table structure for table `emotions_skills`
--

CREATE TABLE `emotions_skills` (
  `emo_id` varchar(20) NOT NULL,
  `skill_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `emotions_skills`
--

INSERT INTO `emotions_skills` (`emo_id`, `skill_id`) VALUES
('ag', 3),
('ag', 6),
('ag', 8),
('ag', 10),
('ag', 16),
('ag', 18),
('ag', 19),
('br', 5),
('br', 12),
('br', 15),
('br', 22),
('br', 24),
('br', 25),
('fr', 1),
('fr', 2),
('fr', 3),
('fr', 4),
('fr', 5),
('fr', 7),
('fr', 8),
('fr', 10),
('fr', 11),
('fr', 13),
('sc', 1),
('sc', 3),
('sc', 4),
('sc', 7),
('sc', 9),
('sc', 10),
('sc', 11),
('sc', 12),
('sc', 20),
('sc', 21),
('sd', 1),
('sd', 2),
('sd', 3),
('sd', 4),
('sd', 5),
('sd', 8),
('sd', 10),
('sd', 12),
('sd', 13),
('sd', 15),
('sd', 17),
('sd', 26);

-- --------------------------------------------------------

--
-- Table structure for table `records`
--

CREATE TABLE `records` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `emotion` varchar(20) NOT NULL,
  `skill_name` varchar(100) NOT NULL,
  `skill_info` text DEFAULT NULL,
  `date_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `records`
--

INSERT INTO `records` (`id`, `user_id`, `emotion`, `skill_name`, `skill_info`, `date_time`) VALUES
(1, 1, 'bored', 'IMPROVE', 'The intent of the IMPROVE skill is to improve the moment by replacing the immediate event that has caused unpleasant emotions, with a more positive act, thereby making the moment more pleasant and easier to tolerate.\r\n\r\n    Imagery: Improve the moment with Imagery. Imagine a beautiful scene on the beach or in the mountains. Image a safe place in your home.\r\n    Meaning: Improve the moment with Meaning. Find purpose or meaning in your daily activities.\r\n    Prayer: Improve the moment with Prayer. Ask for strength from your supreme being.\r\n    Relaxation: Improve the moment with Relaxation. Breathe deeply, take a hot bath, massage your neck.\r\n    One: Improve the moment with one thing in the moment. Focus your attention on this moment.\r\n    Vacation: Improve the moment with Vacation from adulthood. Go to the beach or the woods for a walk.\r\n    Encouragement: Improve the moment with Encouragement from self. Say positive affirmations aloud to yourself.\r\n\r\n', '2024-10-20 18:25:39'),
(2, 1, 'anxious', 'Self-soothing', 'Self-soothing skill involves doing things that feel pleasant, comforting, and provide relief from stress or pain. It helps to pass the time without making things worse.\r\n        Vision: Look for a beautiful sunrise or sunset, the stars at night, or pictures of these things. Look for beautiful photos of beaches or mountains or a beautiful flower. Look to nature all around you.\r\nHearing: Listen to music you enjoy. Listen for the breeze, or the trees in the breeze. Listen for birds or waves of the water.\r\nSmell: Find a fragrance you enjoy, and smell fragrances around you. Smell a flower, or perfume, freshly cut grass, or the burning of wood in a fireplace.\r\nTaste: Enjoy some of your favorite foods.\r\nTouch: Apply moisturizer. Take a hot shower, or a long bath. Sit in the sun or shade and feel the warmth or cool of the breeze.', '2024-10-20 18:31:03'),
(3, 1, 'depressed', 'Sensory Awareness', 'Sensory awareness is a skill that requires a person to pay attention to a specific sensation, for example, feeling hair touching your head, feeling how you breathe, noticing how your feet are touching the floor, feeling your clothes on your body, imagining peaceful scenes, etc.', '2024-10-20 18:34:33'),
(4, 1, 'self-aware', 'Problem Solving', 'The Problem Solving skill can be very useful once we have determined that a problem has arisen, and it’s our problem to solve. Sometimes we experience unpleasant emotions about the actions of others or situations that we cannot change. This skill specifically helps us to collect the facts and take steps to solve a problem for which we can change.\r\n\r\nThere are a number of steps to effective problem solving:\r\n\r\n    1\r\n    Stop long enough to realize that a situation is a problem and you may need time to find a resolution.\r\n    2\r\n    Define the problem in detail. What is the situation? Who is involved? What is happening or not happening that is a problem? Where did it happen? When did it happen? How did it happen? How often does it occur? Why does it happen? How do you feel? What do you do in response? What do you want to change?\r\n    3\r\n    Describe how the problem interferes with your goals. If the situation does not interfere with your goals, it is likely not your problem.\r\n    4\r\n    Identify all the options/alternatives. It is important to find at least 3 potential solutions in order to avoid the black/white thinking we were programmed to use.\r\n    5\r\n    View of the consequences of each option/alternative. Seek additional knowledge if necessary.\r\n    6\r\n    Identify the steps needed to resolve/take action. Make a list of when and how the steps will be taken and then take the required action.\r\n    7\r\n    Evaluate results. If the steps taken were successful to resolve the problem, acknowledge that you successfully solved a problem and give yourself some credit. If the steps taken were not successful to solve the problem, learn more about what would be needed to solve the problem and follow steps 4-7 again until the matter is resolved.\r\n\r\n', '2024-10-20 18:36:41'),
(5, 1, 'antagonistic', 'Cold Water', 'To rapidly calm down, try dipping your face in a bowl of cold water or applying a cold pack to your eyes and cheeks for at least 20 seconds. This prompts the mammalian diving reflex, a natural response that occurs in all mammals, including humans when their faces come into contact with cold water.\r\n\r\nThe reflex triggers a shift in body chemistry, leading to an immediate drop in heart rate and activation of the parasympathetic nervous system, inducing a relaxation response. Ensure that the water’s temperature remains above 50 degrees Fahrenheit.\r\n', '2024-10-20 18:40:40'),
(10, 1, 'low self-esteem', 'Progressive Muscle Relaxation', 'Progressive Muscle Relaxation teaches you how to relax your muscles through a two-step process. First, you systematically tense particular muscle groups in your body, such as your neck and shoulders. Next, you release the tension and notice how your muscles feel when you relax them. https://www.youtube.com/watch?v=ihO02wUzgkc\r\n', '2024-10-20 19:19:56'),
(11, 1, 'low self-esteem', 'Cold Water', 'To rapidly calm down, try dipping your face in a bowl of cold water or applying a cold pack to your eyes and cheeks for at least 20 seconds. This prompts the mammalian diving reflex, a natural response that occurs in all mammals, including humans when their faces come into contact with cold water.\r\n\r\nThe reflex triggers a shift in body chemistry, leading to an immediate drop in heart rate and activation of the parasympathetic nervous system, inducing a relaxation response. Ensure that the water’s temperature remains above 50 degrees Fahrenheit.\r\n', '2024-10-20 19:30:34'),
(12, 1, 'nervous', 'Self-soothing', 'Self-soothing skill involves doing things that feel pleasant, comforting, and provide relief from stress or pain. It helps to pass the time without making things worse.\r\n        Vision: Look for a beautiful sunrise or sunset, the stars at night, or pictures of these things. Look for beautiful photos of beaches or mountains or a beautiful flower. Look to nature all around you.\r\nHearing: Listen to music you enjoy. Listen for the breeze, or the trees in the breeze. Listen for birds or waves of the water.\r\nSmell: Find a fragrance you enjoy, and smell fragrances around you. Smell a flower, or perfume, freshly cut grass, or the burning of wood in a fireplace.\r\nTaste: Enjoy some of your favorite foods.\r\nTouch: Apply moisturizer. Take a hot shower, or a long bath. Sit in the sun or shade and feel the warmth or cool of the breeze.', '2024-10-20 19:34:01'),
(13, 1, 'nervous', 'Progressive Muscle Relaxation', 'Progressive Muscle Relaxation teaches you how to relax your muscles through a two-step process. First, you systematically tense particular muscle groups in your body, such as your neck and shoulders. Next, you release the tension and notice how your muscles feel when you relax them. https://www.youtube.com/watch?v=ihO02wUzgkc\r\n', '2024-10-20 19:35:16'),
(14, 1, 'nervous', 'IMPROVE', 'The intent of the IMPROVE skill is to improve the moment by replacing the immediate event that has caused unpleasant emotions, with a more positive act, thereby making the moment more pleasant and easier to tolerate.\r\n\r\n    Imagery: Improve the moment with Imagery. Imagine a beautiful scene on the beach or in the mountains. Image a safe place in your home.\r\n    Meaning: Improve the moment with Meaning. Find purpose or meaning in your daily activities.\r\n    Prayer: Improve the moment with Prayer. Ask for strength from your supreme being.\r\n    Relaxation: Improve the moment with Relaxation. Breathe deeply, take a hot bath, massage your neck.\r\n    One: Improve the moment with one thing in the moment. Focus your attention on this moment.\r\n    Vacation: Improve the moment with Vacation from adulthood. Go to the beach or the woods for a walk.\r\n    Encouragement: Improve the moment with Encouragement from self. Say positive affirmations aloud to yourself.\r\n\r\n', '2024-10-20 19:35:44'),
(15, 1, 'nervous', 'Radical Acceptance', 'Radical acceptance is the complete and total acceptance of reality. This means that you accept the reality of a situation in your mind, heart, and body. You stop fighting against the reality and accept it.\r\nThings to Remember:\r\n\r\n    Radical means all the way – completely.\r\n    You let go of the bitterness.\r\n    Reality is as it is – rejecting it does not change it.\r\n    There are limitations about the future.\r\n    Everything has a cause.\r\n    Life is worth living – pain cannot be avoided.\r\n\r\n', '2024-10-20 19:36:33'),
(16, 1, 'nervous', 'Sensory Awareness', 'Sensory awareness is a skill that requires a person to pay attention to a specific sensation, for example, feeling hair touching your head, feeling how you breathe, noticing how your feet are touching the floor, feeling your clothes on your body, imagining peaceful scenes, etc.', '2024-10-20 19:37:08'),
(17, 1, 'nervous', 'Progressive Muscle Relaxation', 'Progressive Muscle Relaxation teaches you how to relax your muscles through a two-step process. First, you systematically tense particular muscle groups in your body, such as your neck and shoulders. Next, you release the tension and notice how your muscles feel when you relax them. https://www.youtube.com/watch?v=ihO02wUzgkc\r\n', '2024-10-20 19:39:13'),
(18, 1, 'nervous', 'Problem Solving', 'The Problem Solving skill can be very useful once we have determined that a problem has arisen, and it’s our problem to solve. Sometimes we experience unpleasant emotions about the actions of others or situations that we cannot change. This skill specifically helps us to collect the facts and take steps to solve a problem for which we can change.\r\n\r\nThere are a number of steps to effective problem solving:\r\n\r\n    1\r\n    Stop long enough to realize that a situation is a problem and you may need time to find a resolution.\r\n    2\r\n    Define the problem in detail. What is the situation? Who is involved? What is happening or not happening that is a problem? Where did it happen? When did it happen? How did it happen? How often does it occur? Why does it happen? How do you feel? What do you do in response? What do you want to change?\r\n    3\r\n    Describe how the problem interferes with your goals. If the situation does not interfere with your goals, it is likely not your problem.\r\n    4\r\n    Identify all the options/alternatives. It is important to find at least 3 potential solutions in order to avoid the black/white thinking we were programmed to use.\r\n    5\r\n    View of the consequences of each option/alternative. Seek additional knowledge if necessary.\r\n    6\r\n    Identify the steps needed to resolve/take action. Make a list of when and how the steps will be taken and then take the required action.\r\n    7\r\n    Evaluate results. If the steps taken were successful to resolve the problem, acknowledge that you successfully solved a problem and give yourself some credit. If the steps taken were not successful to solve the problem, learn more about what would be needed to solve the problem and follow steps 4-7 again until the matter is resolved.\r\n\r\n', '2024-10-20 19:45:46'),
(19, 1, 'nervous', 'Reduce Emotional Vulnerability', '\r\nThe ABC PLEASE skill is about taking good care of ourselves so that we can take care of others. Also, an important component of DBT is to reduce our vulnerability. When we take good care of ourselves, we are less likely to be vulnerable to disease and emotional crisis.\r\nABC\r\n\r\n    A\r\n    Accumulate positive emotions by doing things that are pleasant.\r\n    B\r\n    Build mastery by doing things we enjoy. Whether it is reading, cooking, cleaning, fixing a car, working a cross word puzzle, or playing a musical instrument. Practice these things to build master and in time we feel competent.\r\n    C\r\n    Cope Ahead by rehearsing a plan ahead of time so that we can be prepared to cope skillfully.\r\n\r\nPLEASE\r\n\r\n    Treat Physical Illness and take medications as prescribed.\r\n    Balance eating in order to avoid mood swings.\r\n    Avoid mood-Altering substances and have mood control.\r\n    Maintain good sleep so you can enjoy your life.\r\n    Get exercise to maintain high spirits.\r\n', '2024-10-20 19:50:33'),
(20, 1, 'nervous', 'Cope Ahead', 'The Cope Ahead skill is intended to have us consider how we might be prepared in some way to help us reduce stress ahead of the time. When we are asked to do some task, it is helpful to think through to the completion of the task. All of us at one time or another have had to give a presentation. Before the presentation, we likely wrote up some notes or did some research on the subject. We do this in order to increase our chances of communicating a message to others successfully. This is an example of coping ahead of time.\r\nrehearse a plan ahead of time so that you are prepared to cope skillfully with emotional situations.\r\n\r\n    1\r\n    Describe the situation that is likely to prompt uncomfortable emotions. Check the facts. Be specific in describing the situation. Name the emotions and actions likely to interfere with using your skills.\r\n    2\r\n    Decide what coping or problem-solving skills you want to use in the situation. Be specific. Write out in detail how you will cope with the situation and with your emotions and action urges.\r\n    3\r\n    Imagine the situation in your mind as vividly as possible. Imagine yourself in the situation now, not watching the situation.\r\n    4\r\n    Rehearse in your mind coping effectively. Rehearse in your mind exactly what you can do to cope effectively. Rehearse your actions, your thoughts, what you say, and how to say it. Rehearse coping effectively with new problems that come up. Rehearse coping effectively with your most feared catastrophe.\r\n    5\r\n    Practice relaxation after rehearsing.\r\n', '2024-10-20 19:52:50'),
(21, 1, 'nervous', 'Cold Water', 'To rapidly calm down, try dipping your face in a bowl of cold water or applying a cold pack to your eyes and cheeks for at least 20 seconds. This prompts the mammalian diving reflex, a natural response that occurs in all mammals, including humans when their faces come into contact with cold water.\r\n\r\nThe reflex triggers a shift in body chemistry, leading to an immediate drop in heart rate and activation of the parasympathetic nervous system, inducing a relaxation response. Ensure that the water’s temperature remains above 50 degrees Fahrenheit.\r\n', '2024-10-20 19:53:01'),
(22, 1, 'nervous', 'Cold Water', 'To rapidly calm down, try dipping your face in a bowl of cold water or applying a cold pack to your eyes and cheeks for at least 20 seconds. This prompts the mammalian diving reflex, a natural response that occurs in all mammals, including humans when their faces come into contact with cold water.\r\n\r\nThe reflex triggers a shift in body chemistry, leading to an immediate drop in heart rate and activation of the parasympathetic nervous system, inducing a relaxation response. Ensure that the water’s temperature remains above 50 degrees Fahrenheit.\r\n', '2024-10-20 19:54:13'),
(23, 1, 'nervous', 'Problem Solving', 'The Problem Solving skill can be very useful once we have determined that a problem has arisen, and it’s our problem to solve. Sometimes we experience unpleasant emotions about the actions of others or situations that we cannot change. This skill specifically helps us to collect the facts and take steps to solve a problem for which we can change.\r\n\r\nThere are a number of steps to effective problem solving:\r\n\r\n    1\r\n    Stop long enough to realize that a situation is a problem and you may need time to find a resolution.\r\n    2\r\n    Define the problem in detail. What is the situation? Who is involved? What is happening or not happening that is a problem? Where did it happen? When did it happen? How did it happen? How often does it occur? Why does it happen? How do you feel? What do you do in response? What do you want to change?\r\n    3\r\n    Describe how the problem interferes with your goals. If the situation does not interfere with your goals, it is likely not your problem.\r\n    4\r\n    Identify all the options/alternatives. It is important to find at least 3 potential solutions in order to avoid the black/white thinking we were programmed to use.\r\n    5\r\n    View of the consequences of each option/alternative. Seek additional knowledge if necessary.\r\n    6\r\n    Identify the steps needed to resolve/take action. Make a list of when and how the steps will be taken and then take the required action.\r\n    7\r\n    Evaluate results. If the steps taken were successful to resolve the problem, acknowledge that you successfully solved a problem and give yourself some credit. If the steps taken were not successful to solve the problem, learn more about what would be needed to solve the problem and follow steps 4-7 again until the matter is resolved.\r\n\r\n', '2024-10-20 19:56:22'),
(24, 1, 'nervous', 'Cold Water', 'To rapidly calm down, try dipping your face in a bowl of cold water or applying a cold pack to your eyes and cheeks for at least 20 seconds. This prompts the mammalian diving reflex, a natural response that occurs in all mammals, including humans when their faces come into contact with cold water.\r\n\r\nThe reflex triggers a shift in body chemistry, leading to an immediate drop in heart rate and activation of the parasympathetic nervous system, inducing a relaxation response. Ensure that the water’s temperature remains above 50 degrees Fahrenheit.\r\n', '2024-10-20 19:57:16'),
(25, 1, 'nervous', 'Problem Solving', 'The Problem Solving skill can be very useful once we have determined that a problem has arisen, and it’s our problem to solve. Sometimes we experience unpleasant emotions about the actions of others or situations that we cannot change. This skill specifically helps us to collect the facts and take steps to solve a problem for which we can change.\r\n\r\nThere are a number of steps to effective problem solving:\r\n\r\n    1\r\n    Stop long enough to realize that a situation is a problem and you may need time to find a resolution.\r\n    2\r\n    Define the problem in detail. What is the situation? Who is involved? What is happening or not happening that is a problem? Where did it happen? When did it happen? How did it happen? How often does it occur? Why does it happen? How do you feel? What do you do in response? What do you want to change?\r\n    3\r\n    Describe how the problem interferes with your goals. If the situation does not interfere with your goals, it is likely not your problem.\r\n    4\r\n    Identify all the options/alternatives. It is important to find at least 3 potential solutions in order to avoid the black/white thinking we were programmed to use.\r\n    5\r\n    View of the consequences of each option/alternative. Seek additional knowledge if necessary.\r\n    6\r\n    Identify the steps needed to resolve/take action. Make a list of when and how the steps will be taken and then take the required action.\r\n    7\r\n    Evaluate results. If the steps taken were successful to resolve the problem, acknowledge that you successfully solved a problem and give yourself some credit. If the steps taken were not successful to solve the problem, learn more about what would be needed to solve the problem and follow steps 4-7 again until the matter is resolved.\r\n\r\n', '2024-10-20 19:57:22'),
(26, 1, 'nervous', 'Sensory Awareness', 'Sensory awareness is a skill that requires a person to pay attention to a specific sensation, for example, feeling hair touching your head, feeling how you breathe, noticing how your feet are touching the floor, feeling your clothes on your body, imagining peaceful scenes, etc.', '2024-10-20 20:06:17'),
(27, 1, 'nervous', 'Progressive Muscle Relaxation', 'Progressive Muscle Relaxation teaches you how to relax your muscles through a two-step process. First, you systematically tense particular muscle groups in your body, such as your neck and shoulders. Next, you release the tension and notice how your muscles feel when you relax them. https://www.youtube.com/watch?v=ihO02wUzgkc\r\n', '2024-10-20 20:14:50'),
(28, 1, 'nervous', 'Cold Water', 'To rapidly calm down, try dipping your face in a bowl of cold water or applying a cold pack to your eyes and cheeks for at least 20 seconds. This prompts the mammalian diving reflex, a natural response that occurs in all mammals, including humans when their faces come into contact with cold water.\r\n\r\nThe reflex triggers a shift in body chemistry, leading to an immediate drop in heart rate and activation of the parasympathetic nervous system, inducing a relaxation response. Ensure that the water’s temperature remains above 50 degrees Fahrenheit.\r\n', '2024-10-20 20:16:08'),
(29, 1, 'nervous', 'Progressive Muscle Relaxation', 'Progressive Muscle Relaxation teaches you how to relax your muscles through a two-step process. First, you systematically tense particular muscle groups in your body, such as your neck and shoulders. Next, you release the tension and notice how your muscles feel when you relax them. https://www.youtube.com/watch?v=ihO02wUzgkc\r\n', '2024-10-20 20:16:38'),
(30, 1, 'nervous', 'Cold Water', 'To rapidly calm down, try dipping your face in a bowl of cold water or applying a cold pack to your eyes and cheeks for at least 20 seconds. This prompts the mammalian diving reflex, a natural response that occurs in all mammals, including humans when their faces come into contact with cold water.\r\n\r\nThe reflex triggers a shift in body chemistry, leading to an immediate drop in heart rate and activation of the parasympathetic nervous system, inducing a relaxation response. Ensure that the water’s temperature remains above 50 degrees Fahrenheit.\r\n', '2024-10-20 20:16:53'),
(31, 1, 'nervous', 'Progressive Muscle Relaxation', 'Progressive Muscle Relaxation teaches you how to relax your muscles through a two-step process. First, you systematically tense particular muscle groups in your body, such as your neck and shoulders. Next, you release the tension and notice how your muscles feel when you relax them. https://www.youtube.com/watch?v=ihO02wUzgkc\r\n', '2024-10-20 20:18:16'),
(32, 1, 'nervous', 'Sensory Awareness', 'Sensory awareness is a skill that requires a person to pay attention to a specific sensation, for example, feeling hair touching your head, feeling how you breathe, noticing how your feet are touching the floor, feeling your clothes on your body, imagining peaceful scenes, etc.', '2024-10-20 20:19:43'),
(33, 1, 'nervous', 'Self-soothing', 'Self-soothing skill involves doing things that feel pleasant, comforting, and provide relief from stress or pain. It helps to pass the time without making things worse.\r\n        Vision: Look for a beautiful sunrise or sunset, the stars at night, or pictures of these things. Look for beautiful photos of beaches or mountains or a beautiful flower. Look to nature all around you.\r\nHearing: Listen to music you enjoy. Listen for the breeze, or the trees in the breeze. Listen for birds or waves of the water.\r\nSmell: Find a fragrance you enjoy, and smell fragrances around you. Smell a flower, or perfume, freshly cut grass, or the burning of wood in a fireplace.\r\nTaste: Enjoy some of your favorite foods.\r\nTouch: Apply moisturizer. Take a hot shower, or a long bath. Sit in the sun or shade and feel the warmth or cool of the breeze.', '2024-10-20 20:19:53'),
(34, 1, 'nervous', 'Cold Water', 'To rapidly calm down, try dipping your face in a bowl of cold water or applying a cold pack to your eyes and cheeks for at least 20 seconds. This prompts the mammalian diving reflex, a natural response that occurs in all mammals, including humans when their faces come into contact with cold water.\r\n\r\nThe reflex triggers a shift in body chemistry, leading to an immediate drop in heart rate and activation of the parasympathetic nervous system, inducing a relaxation response. Ensure that the water’s temperature remains above 50 degrees Fahrenheit.\r\n', '2024-10-20 20:21:38'),
(35, 1, 'angry', 'Cold Water', 'To rapidly calm down, try dipping your face in a bowl of cold water or applying a cold pack to your eyes and cheeks for at least 20 seconds. This prompts the mammalian diving reflex, a natural response that occurs in all mammals, including humans when their faces come into contact with cold water.\r\n\r\nThe reflex triggers a shift in body chemistry, leading to an immediate drop in heart rate and activation of the parasympathetic nervous system, inducing a relaxation response. Ensure that the water’s temperature remains above 50 degrees Fahrenheit.\r\n', '2024-10-21 18:39:56'),
(37, 1, 'distressed', 'Radical Acceptance', 'Radical acceptance is the complete and total acceptance of reality. This means that you accept the reality of a situation in your mind, heart, and body. You stop fighting against the reality and accept it.\r\nThings to Remember:\r\n\r\n    Radical means all the way – completely.\r\n    You let go of the bitterness.\r\n    Reality is as it is – rejecting it does not change it.\r\n    There are limitations about the future.\r\n    Everything has a cause.\r\n    Life is worth living – pain cannot be avoided.\r\n\r\n', '2024-10-23 18:43:26'),
(38, 1, 'bored', 'Mindfulness skills', '\r\n\r\nObserve\r\n\r\n    Pay attention to events, emotions, and thoughts.\r\n    Try not to terminate them when they are painful.\r\n    Try not to prolong them when they are pleasant.\r\n    Allow yourself to experience with awareness.\r\n\r\nDescribe\r\n\r\n    Describe events, label emotions, identify thoughts.\r\n    Try not to take emotions and thoughts as accurate and exact reflections of events.\r\n    List \"just the facts\" – No need to label or judge.\r\n\r\nParticipate\r\n\r\n    Enter completely into the activity of the moment.\r\n    Try not to be self-conscious.\r\n    Be spontaneous and give attention to the activity.\r\n\r\nNon-Judgmental\r\n\r\n    Taking a non-judgmental stance means – do not judge things as good or bad, right or wrong.\r\n    It is effective to focus on the consequence of behavior instead of judging others or ourselves.\r\n    It is helpful to fully describe what is observed and collect just the facts; without judging those involved or the circumstances.\r\n\r\nOne Mindful\r\n\r\n    It is the ability to focus the mind (and awareness) in the current moment.\r\n    Try not to become distracted by thoughts or images of the past.\r\n    Try to put your worries about the future away and focus on the task at hand.\r\n    Engage in the activity of the moment with your eyes wide open.\r\n\r\nEffective\r\n\r\n    Do what works.\r\n    Try not to worry about being “right”.\r\n    Focus on the outcome you desire.\r\n', '2024-10-23 18:51:13'),
(39, 1, 'anxious', 'Progressive Muscle Relaxation', 'Progressive Muscle Relaxation teaches you how to relax your muscles through a two-step process. First, you systematically tense particular muscle groups in your body, such as your neck and shoulders. Next, you release the tension and notice how your muscles feel when you relax them. https://www.youtube.com/watch?v=ihO02wUzgkc\r\n', '2024-11-13 19:09:26'),
(40, 1, 'fearful', 'Self-soothing', 'Self-soothing skill involves doing things that feel pleasant, comforting, and provide relief from stress or pain. It helps to pass the time without making things worse.\r\n        Vision: Look for a beautiful sunrise or sunset, the stars at night, or pictures of these things. Look for beautiful photos of beaches or mountains or a beautiful flower. Look to nature all around you.\r\nHearing: Listen to music you enjoy. Listen for the breeze, or the trees in the breeze. Listen for birds or waves of the water.\r\nSmell: Find a fragrance you enjoy, and smell fragrances around you. Smell a flower, or perfume, freshly cut grass, or the burning of wood in a fireplace.\r\nTaste: Enjoy some of your favorite foods.\r\nTouch: Apply moisturizer. Take a hot shower, or a long bath. Sit in the sun or shade and feel the warmth or cool of the breeze.', '2024-11-18 19:06:19'),
(41, 1, 'nervous', 'Self-soothing', 'Self-soothing skill involves doing things that feel pleasant, comforting, and provide relief from stress or pain. It helps to pass the time without making things worse.\r\n        Vision: Look for a beautiful sunrise or sunset, the stars at night, or pictures of these things. Look for beautiful photos of beaches or mountains or a beautiful flower. Look to nature all around you.\r\nHearing: Listen to music you enjoy. Listen for the breeze, or the trees in the breeze. Listen for birds or waves of the water.\r\nSmell: Find a fragrance you enjoy, and smell fragrances around you. Smell a flower, or perfume, freshly cut grass, or the burning of wood in a fireplace.\r\nTaste: Enjoy some of your favorite foods.\r\nTouch: Apply moisturizer. Take a hot shower, or a long bath. Sit in the sun or shade and feel the warmth or cool of the breeze.', '2024-11-18 19:08:26'),
(42, 1, 'scared', 'Self-soothing', 'Self-soothing skill involves doing things that feel pleasant, comforting, and provide relief from stress or pain. It helps to pass the time without making things worse.\r\n        Vision: Look for a beautiful sunrise or sunset, the stars at night, or pictures of these things. Look for beautiful photos of beaches or mountains or a beautiful flower. Look to nature all around you.\r\nHearing: Listen to music you enjoy. Listen for the breeze, or the trees in the breeze. Listen for birds or waves of the water.\r\nSmell: Find a fragrance you enjoy, and smell fragrances around you. Smell a flower, or perfume, freshly cut grass, or the burning of wood in a fireplace.\r\nTaste: Enjoy some of your favorite foods.\r\nTouch: Apply moisturizer. Take a hot shower, or a long bath. Sit in the sun or shade and feel the warmth or cool of the breeze.', '2024-12-09 18:54:15'),
(43, 3, 'bored', 'IMPROVE', 'The intent of the IMPROVE skill is to improve the moment by replacing the immediate event that has caused unpleasant emotions, with a more positive act, thereby making the moment more pleasant and easier to tolerate.\r\n\r\n    Imagery: Improve the moment with Imagery. Imagine a beautiful scene on the beach or in the mountains. Image a safe place in your home.\r\n    Meaning: Improve the moment with Meaning. Find purpose or meaning in your daily activities.\r\n    Prayer: Improve the moment with Prayer. Ask for strength from your supreme being.\r\n    Relaxation: Improve the moment with Relaxation. Breathe deeply, take a hot bath, massage your neck.\r\n    One: Improve the moment with one thing in the moment. Focus your attention on this moment.\r\n    Vacation: Improve the moment with Vacation from adulthood. Go to the beach or the woods for a walk.\r\n    Encouragement: Improve the moment with Encouragement from self. Say positive affirmations aloud to yourself.\r\n\r\n', '2024-12-09 18:56:09'),
(44, 1, 'angry', 'loving kindness', 'send them loving kindness', '2024-12-09 19:05:20'),
(45, 3, 'flat', 'Build Mastery', '\r\nYou can build mastery by doing things you enjoy. Whether it is reading, cooking, cleaning, fixing a car, working a cross word puzzle, or playing a musical instrument. Learn as much as you can about the subject in order to be well versed. Discuss what you have learned and write about what you have learned. Practice these things to build mastery and in time, feel competent.\r\nTry Something New\r\n\r\nAnyone can master a new recipe and with practice, it can become a family favorite. Finding a recipe for a dish that the family will enjoy is the first part of the challenge. Understanding the components of the recipe and how to follow the steps is next. If you are unsure, ask others who enjoy cooking or google the answer. Collect the ingredients and give the recipe a whirl. Expect mistakes, because mistakes help us to learn. Seek help when you are not sure about how to proceed.\r\nPractice\r\n\r\nWashing the dishes and doing the laundry are thankless jobs, yet when they are complete and are done well, we can feel good that the task is complete. Reading a book to a young child and finding joy in sharing that time, is also considered building mastery in relationship building. Playing a board game with friends, or frisbee, or any other sport, can also be part of building a relationship which involves mastery.\r\nGive Yourself Credit\r\n\r\nAn important ingredient in this skill building is to remember to give ourselves credit for building mastery. We often let the day go as if we accomplished nothing at all. Give yourself credit for all that you accomplished at days end.\r\n', '2024-12-09 19:32:05');

-- --------------------------------------------------------

--
-- Table structure for table `skills`
--

CREATE TABLE `skills` (
  `skill_id` int(11) NOT NULL,
  `skill_name` varchar(100) DEFAULT NULL,
  `skill_info` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `skills`
--

INSERT INTO `skills` (`skill_id`, `skill_name`, `skill_info`) VALUES
(1, 'Self-soothing', 'Self-soothing skill involves doing things that feel pleasant, comforting, and provide relief from stress or pain. It helps to pass the time without making things worse.\n        Vision: Look for a beautiful sunrise or sunset, the stars at night, or pictures of these things. Look for beautiful photos of beaches or mountains or a beautiful flower. Look to nature all around you.\nHearing: Listen to music you enjoy. Listen for the breeze, or the trees in the breeze. Listen for birds or waves of the water.\nSmell: Find a fragrance you enjoy, and smell fragrances around you. Smell a flower, or perfume, freshly cut grass, or the burning of wood in a fireplace.\nTaste: Enjoy some of your favorite foods.\nTouch: Apply moisturizer. Take a hot shower, or a long bath. Sit in the sun or shade and feel the warmth or cool of the breeze.'),
(2, 'Sensory Awareness', 'Sensory awareness is a skill that requires a person to pay attention to a specific sensation, for example, feeling hair touching your head, feeling how you breathe, noticing how your feet are touching the floor, feeling your clothes on your body, imagining peaceful scenes, etc.'),
(3, 'Cold Water', 'To rapidly calm down, try dipping your face in a bowl of cold water or applying a cold pack to your eyes and cheeks for at least 20 seconds. This prompts the mammalian diving reflex, a natural response that occurs in all mammals, including humans when their faces come into contact with cold water.\r\n\r\nThe reflex triggers a shift in body chemistry, leading to an immediate drop in heart rate and activation of the parasympathetic nervous system, inducing a relaxation response. Ensure that the water’s temperature remains above 50 degrees Fahrenheit.\r\n'),
(4, 'Progressive Muscle Relaxation', 'Progressive Muscle Relaxation teaches you how to relax your muscles through a two-step process. First, you systematically tense particular muscle groups in your body, such as your neck and shoulders. Next, you release the tension and notice how your muscles feel when you relax them. https://www.youtube.com/watch?v=ihO02wUzgkc\r\n'),
(5, 'IMPROVE', 'The intent of the IMPROVE skill is to improve the moment by replacing the immediate event that has caused unpleasant emotions, with a more positive act, thereby making the moment more pleasant and easier to tolerate.\r\n\r\n    Imagery: Improve the moment with Imagery. Imagine a beautiful scene on the beach or in the mountains. Image a safe place in your home.\r\n    Meaning: Improve the moment with Meaning. Find purpose or meaning in your daily activities.\r\n    Prayer: Improve the moment with Prayer. Ask for strength from your supreme being.\r\n    Relaxation: Improve the moment with Relaxation. Breathe deeply, take a hot bath, massage your neck.\r\n    One: Improve the moment with one thing in the moment. Focus your attention on this moment.\r\n    Vacation: Improve the moment with Vacation from adulthood. Go to the beach or the woods for a walk.\r\n    Encouragement: Improve the moment with Encouragement from self. Say positive affirmations aloud to yourself.\r\n\r\n'),
(6, 'STOP', 'The STOP skill consists of the following sequence: Stop, Take a step back, Observe, Proceed mindfully.\r\nStop\r\n\r\nWhen you feel that your emotions seem to be in control, stop! Don’t react. Don’t move a muscle. Just freeze especially those muscles around the mouth. Freezing for a moment helps prevent you from doing what your emotions want you to do (which is to act without thinking). Stay in control. Remember, you are the boss of your emotions. Name the emotion – put a label on it.\r\nTake A Step Back\r\n\r\nWhen you are faced with a difficult situation, it may be hard to think about how to deal with it on the spot. Give yourself some time to calm down and think. Take a step back from the situation. Get unstuck from what is going on. Take a deep breath and continue breathing deeply as long as you need and until you are in control. Do not let your emotions control what you do. It is the rare incident, indeed, wherein we need to make a split-second decision about anything. Hence, it is okay to take our time to decide how to respond.\r\nObserve\r\n\r\nObserve what is happening around you and within you, who is involved, and what are other people doing or saying. Listen to the Automatic Negative Thoughts (ANTs) that occur…remember those are based on an outdated Belief System that was programmed before you were seven. To make effective choices, it is important NOT to jump to conclusions. Instead, gather the relevant facts so you can understand what is going on and what options are available.\r\nProceed Mindfully\r\n\r\nAsk yourself, “What do I want from this situation?” or “What are my goals?” or “What choice might make this situation better or worse?” or “What act will allow for success?” Stay calm, stay in control, and when you have some information and how that may impact your goals, you will be better prepared to deal with the situation effectively. Remember your brain needs time to think all of this through.\r\n'),
(7, 'Problem Solving', 'The Problem Solving skill can be very useful once we have determined that a problem has arisen, and it’s our problem to solve. Sometimes we experience unpleasant emotions about the actions of others or situations that we cannot change. This skill specifically helps us to collect the facts and take steps to solve a problem for which we can change.\r\n\r\nThere are a number of steps to effective problem solving:\r\n\r\n    1\r\n    Stop long enough to realize that a situation is a problem and you may need time to find a resolution.\r\n    2\r\n    Define the problem in detail. What is the situation? Who is involved? What is happening or not happening that is a problem? Where did it happen? When did it happen? How did it happen? How often does it occur? Why does it happen? How do you feel? What do you do in response? What do you want to change?\r\n    3\r\n    Describe how the problem interferes with your goals. If the situation does not interfere with your goals, it is likely not your problem.\r\n    4\r\n    Identify all the options/alternatives. It is important to find at least 3 potential solutions in order to avoid the black/white thinking we were programmed to use.\r\n    5\r\n    View of the consequences of each option/alternative. Seek additional knowledge if necessary.\r\n    6\r\n    Identify the steps needed to resolve/take action. Make a list of when and how the steps will be taken and then take the required action.\r\n    7\r\n    Evaluate results. If the steps taken were successful to resolve the problem, acknowledge that you successfully solved a problem and give yourself some credit. If the steps taken were not successful to solve the problem, learn more about what would be needed to solve the problem and follow steps 4-7 again until the matter is resolved.\r\n\r\n'),
(8, 'Radical Acceptance', 'Radical acceptance is the complete and total acceptance of reality. This means that you accept the reality of a situation in your mind, heart, and body. You stop fighting against the reality and accept it.\r\nThings to Remember:\r\n\r\n    Radical means all the way – completely.\r\n    You let go of the bitterness.\r\n    Reality is as it is – rejecting it does not change it.\r\n    There are limitations about the future.\r\n    Everything has a cause.\r\n    Life is worth living – pain cannot be avoided.\r\n\r\n'),
(9, 'Assertive Communication', 'The DEARMAN skill is intended to help us develop effective interpersonal communication that will help us get our needs met and develop healthy relationships with others.\r\n\r\n    Describe the current situation (if necessary). Stick to the facts. Tell the person exactly what you are reacting to.\r\n    Express your feelings and opinions about the situation. Don’t assume that the other person knows how you feel.\r\n    Assert yourself by asking for what you want or saying “No” clearly. Do not assume that others will figure out what you want. Remember that others cannot read your mind.\r\n    Reinforce (reward) the person ahead of time (so to speak) by explaining positive effects of getting what you want or need. If necessary, also clarify the negative consequences of not getting what you want or need.\r\n    Mindful keep your focus on your goals. Maintain your position. Don’t be distracted. Don’t get off the topic. Speak like a “Broken record.” Keep asking for what you want. Or say “No” and express your opinion over and over and over. Just keep replaying the same thing again and again. Ignore attacks. If the other person attacks, threatens, or tries to change the subject, ignore the threats, comments, or attempts to divert you. Do not respond to attacks. Ignore distractions. Just keep making your point.\r\n    Appear confident, effective, and competent. Use a confident voice tone and physical manner; make good eye contact. No stammering, whispering, staring at the floor, retreating.\r\n    Negotiate be willing to give to get. Offer and ask for other solutions to the problem. Reduce your request. Say no, but offer to do something else or to solve the problem another way. Focus on what will work.\r\n\r\n'),
(10, 'Opposite Action', 'All emotions activate us to respond and the type of activation is biologically wired. The Opposite Action Skill allows us to choose to respond opposite from what our biological response would activate us to do. They get us ready to act. Here are some examples:\r\n\r\n    Thirst: tells us that we need to hydrate. It activates us to drink water.\r\n    Hunger: tells us that we need to give our body fuel. It activates us to eat.\r\n    Fatigue: tells us that we need rest. It activates us to sleep.\r\n\r\nSwitch it Up\r\n\r\nThe 3 emotions listed above are helpful for our survival; but those that follow require thought before we act and opposite action may be helpful.\r\n\r\n    Anger gets us ready to attack/ It activates us to attack or defend.\r\n    Opposite show kindness/concern or walk away.\r\n    Shame gets us ready to hide. It activates us isolate.\r\n    Opposite raise your head up, give eye contact, shoulders back.\r\n    Fear gets us ready to run or hide. It activates us to escape danger.\r\n    Opposite go towards, stay involved in it, build courage.\r\n    Depression gets us ready to be inactive. It activates us to avoid contact.\r\n    Opposite get active.\r\n    Disgust gets us ready to reject or distance ourselves. It activates us to avoid.\r\n    Opposite push through and get through situation.\r\n    Guilt gets us ready to repair violations. It activates us to seek forgiveness.\r\n    Opposite apologize and mean what we say.\r\n\r\nRemember:\r\n\r\n    1\r\n    If we want an emotion to stick around or increase, continue to do the action as above.\r\n    2\r\n    If we want an emotion to go away or become less uncomfortable, do the opposite action.\r\n    3\r\n    If we want this skill to work, we must use opposite action all the way and believe that it will work.\r\n\r\n'),
(11, 'Cope Ahead', 'The Cope Ahead skill is intended to have us consider how we might be prepared in some way to help us reduce stress ahead of the time. When we are asked to do some task, it is helpful to think through to the completion of the task. All of us at one time or another have had to give a presentation. Before the presentation, we likely wrote up some notes or did some research on the subject. We do this in order to increase our chances of communicating a message to others successfully. This is an example of coping ahead of time.\r\nrehearse a plan ahead of time so that you are prepared to cope skillfully with emotional situations.\r\n\r\n    1\r\n    Describe the situation that is likely to prompt uncomfortable emotions. Check the facts. Be specific in describing the situation. Name the emotions and actions likely to interfere with using your skills.\r\n    2\r\n    Decide what coping or problem-solving skills you want to use in the situation. Be specific. Write out in detail how you will cope with the situation and with your emotions and action urges.\r\n    3\r\n    Imagine the situation in your mind as vividly as possible. Imagine yourself in the situation now, not watching the situation.\r\n    4\r\n    Rehearse in your mind coping effectively. Rehearse in your mind exactly what you can do to cope effectively. Rehearse your actions, your thoughts, what you say, and how to say it. Rehearse coping effectively with new problems that come up. Rehearse coping effectively with your most feared catastrophe.\r\n    5\r\n    Practice relaxation after rehearsing.\r\n'),
(12, 'Build Mastery', '\r\nYou can build mastery by doing things you enjoy. Whether it is reading, cooking, cleaning, fixing a car, working a cross word puzzle, or playing a musical instrument. Learn as much as you can about the subject in order to be well versed. Discuss what you have learned and write about what you have learned. Practice these things to build mastery and in time, feel competent.\r\nTry Something New\r\n\r\nAnyone can master a new recipe and with practice, it can become a family favorite. Finding a recipe for a dish that the family will enjoy is the first part of the challenge. Understanding the components of the recipe and how to follow the steps is next. If you are unsure, ask others who enjoy cooking or google the answer. Collect the ingredients and give the recipe a whirl. Expect mistakes, because mistakes help us to learn. Seek help when you are not sure about how to proceed.\r\nPractice\r\n\r\nWashing the dishes and doing the laundry are thankless jobs, yet when they are complete and are done well, we can feel good that the task is complete. Reading a book to a young child and finding joy in sharing that time, is also considered building mastery in relationship building. Playing a board game with friends, or frisbee, or any other sport, can also be part of building a relationship which involves mastery.\r\nGive Yourself Credit\r\n\r\nAn important ingredient in this skill building is to remember to give ourselves credit for building mastery. We often let the day go as if we accomplished nothing at all. Give yourself credit for all that you accomplished at days end.\r\n'),
(13, 'Reduce Emotional Vulnerability', '\r\nThe ABC PLEASE skill is about taking good care of ourselves so that we can take care of others. Also, an important component of DBT is to reduce our vulnerability. When we take good care of ourselves, we are less likely to be vulnerable to disease and emotional crisis.\r\nABC\r\n\r\n    A\r\n    Accumulate positive emotions by doing things that are pleasant.\r\n    B\r\n    Build mastery by doing things we enjoy. Whether it is reading, cooking, cleaning, fixing a car, working a cross word puzzle, or playing a musical instrument. Practice these things to build master and in time we feel competent.\r\n    C\r\n    Cope Ahead by rehearsing a plan ahead of time so that we can be prepared to cope skillfully.\r\n\r\nPLEASE\r\n\r\n    Treat Physical Illness and take medications as prescribed.\r\n    Balance eating in order to avoid mood swings.\r\n    Avoid mood-Altering substances and have mood control.\r\n    Maintain good sleep so you can enjoy your life.\r\n    Get exercise to maintain high spirits.\r\n'),
(14, 'Pros and Cons Problem Solving', '\r\nWe all use pros and cons to make decisions. This skill can be very helpful when you need to make a decision between two or more options. The objective when using this skill is for you to realize that accepting reality and tolerating distress leads to better outcomes versus rejecting reality and refusing to tolerate distress.\r\nHere is How:\r\n\r\nFirst describe the dilemma at hand. If the dilemma involves crisis behavior that you are hoping to avoid, we would want to look at the pros and cons of the behavior. How effective is the behavior in the short run and long run? Is the behavior damaging or inconsistent with your goals? Next, examine the pros and cons of the crisis behavior or acting on your urges. Then examine the advantages & disadvantages (or pros and cons) for each of the viable options. Before a crisis behavior occurs, it is helpful to write out the pros and cons and carry them with you so that you can be reminded and rehearse the skill over and over.\r\n\r\n    1\r\n    Describe the crisis behavior you are trying to avoid.\r\n    2\r\n    Examine the pros and cons of the crisis behavior / acting on your urges.\r\n    3\r\n    Examine the advantages & disadvantages (or pros and cons) for each of the viable options.\r\n'),
(15, 'Mindfulness skills', '\n\nObserve\n\n    Pay attention to events, emotions, and thoughts.\n    Try not to terminate them when they are painful.\n    Try not to prolong them when they are pleasant.\n    Allow yourself to experience with awareness.\n\nDescribe\n\n    Describe events, label emotions, identify thoughts.\n    Try not to take emotions and thoughts as accurate and exact reflections of events.\n    List \"just the facts\" – No need to label or judge.\n\nParticipate\n\n    Enter completely into the activity of the moment.\n    Try not to be self-conscious.\n    Be spontaneous and give attention to the activity.\n\nNon-Judgmental\n\n    Taking a non-judgmental stance means – do not judge things as good or bad, right or wrong.\n    It is effective to focus on the consequence of behavior instead of judging others or ourselves.\n    It is helpful to fully describe what is observed and collect just the facts; without judging those involved or the circumstances.\n\nOne Mindful\n\n    It is the ability to focus the mind (and awareness) in the current moment.\n    Try not to become distracted by thoughts or images of the past.\n    Try to put your worries about the future away and focus on the task at hand.\n    Engage in the activity of the moment with your eyes wide open.\n\nEffective\n\n    Do what works.\n    Try not to worry about being “right”.\n    Focus on the outcome you desire.\n'),
(16, 'just chill bro', 'just chill'),
(17, 'have a cry', 'allow yourself to cry'),
(18, 'loving kindness', 'send them loving kindness'),
(19, 'TEST', 'TEST'),
(20, 'non-judgemental', 'look at the facts, not the opinions or judgements'),
(21, 'TESTING', 'TESTING'),
(22, 'awareness of emotion', 'is there an underlying emotion that I don\'t allow myself to feel?'),
(24, '111222', '111222'),
(25, 'test1', 'test1'),
(26, 'test2', 'test2');

-- --------------------------------------------------------

--
-- Table structure for table `submissions`
--

CREATE TABLE `submissions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `emotion` varchar(20) DEFAULT NULL,
  `emo_categ` varchar(20) DEFAULT NULL,
  `skill_name` varchar(100) DEFAULT NULL,
  `skill_info` text DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  `sub_type` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `submissions`
--

INSERT INTO `submissions` (`id`, `user_id`, `emotion`, `emo_categ`, `skill_name`, `skill_info`, `date_time`, `sub_type`) VALUES
(12, 1, 'happy', 'Unsure', NULL, NULL, '2024-11-09 19:36:26', 'New Emotion'),
(15, 1, 'suicidal', 'Sadness', NULL, NULL, '2024-11-09 20:44:08', 'New Emotion'),
(16, 1, 'violent', 'Anger', NULL, NULL, '2024-11-09 20:46:04', 'New Emotion'),
(17, 1, 'switched off', 'Boredom', NULL, NULL, '2024-11-09 20:46:42', 'New Emotion'),
(19, 1, 'apathic', 'Boredom', NULL, NULL, '2024-11-16 23:08:58', 'New Emotion'),
(20, 1, 'disinterested', 'Boredom', NULL, NULL, '2024-11-16 23:09:21', 'New Emotion'),
(21, 1, 'anhedonia', 'Boredom', NULL, NULL, '2024-11-16 23:09:48', 'New Emotion'),
(22, 1, 'frozen', 'Fear', NULL, NULL, '2024-11-16 23:10:06', 'New Emotion'),
(34, 1, 'flat', 'Boredom', NULL, NULL, '2024-12-09 18:59:52', 'New Emotion');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `userrole` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `email`, `password`, `userrole`) VALUES
(1, 'dewill177@duck.com', '1234', 'user'),
(2, 'admin@test.com', '1234', 'admin'),
(3, 'tom@test.com', '1234', 'user');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `emotions`
--
ALTER TABLE `emotions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ind_emo_id` (`emo_id`),
  ADD KEY `emotion` (`emotion`);

--
-- Indexes for table `emotions_categories`
--
ALTER TABLE `emotions_categories`
  ADD PRIMARY KEY (`emo_categ`),
  ADD KEY `emo_id` (`emo_id`);

--
-- Indexes for table `emotions_skills`
--
ALTER TABLE `emotions_skills`
  ADD PRIMARY KEY (`emo_id`,`skill_id`),
  ADD KEY `skill_id` (`skill_id`);

--
-- Indexes for table `records`
--
ALTER TABLE `records`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_user` (`user_id`),
  ADD KEY `fk_emotion` (`emotion`),
  ADD KEY `fk_skill_name` (`skill_name`);

--
-- Indexes for table `skills`
--
ALTER TABLE `skills`
  ADD PRIMARY KEY (`skill_id`),
  ADD UNIQUE KEY `skill_name` (`skill_name`);

--
-- Indexes for table `submissions`
--
ALTER TABLE `submissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `sub_type` (`sub_type`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `emotions`
--
ALTER TABLE `emotions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `records`
--
ALTER TABLE `records`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `skills`
--
ALTER TABLE `skills`
  MODIFY `skill_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `submissions`
--
ALTER TABLE `submissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `emotions_categories`
--
ALTER TABLE `emotions_categories`
  ADD CONSTRAINT `emotions_categories_ibfk_1` FOREIGN KEY (`emo_id`) REFERENCES `emotions` (`emo_id`);

--
-- Constraints for table `emotions_skills`
--
ALTER TABLE `emotions_skills`
  ADD CONSTRAINT `emotions_skills_ibfk_1` FOREIGN KEY (`emo_id`) REFERENCES `emotions` (`emo_id`),
  ADD CONSTRAINT `emotions_skills_ibfk_2` FOREIGN KEY (`skill_id`) REFERENCES `skills` (`skill_id`);

--
-- Constraints for table `records`
--
ALTER TABLE `records`
  ADD CONSTRAINT `fk_emotion` FOREIGN KEY (`emotion`) REFERENCES `emotions` (`emotion`),
  ADD CONSTRAINT `fk_skill_name` FOREIGN KEY (`skill_name`) REFERENCES `skills` (`skill_name`),
  ADD CONSTRAINT `fk_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `submissions`
--
ALTER TABLE `submissions`
  ADD CONSTRAINT `submissions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
