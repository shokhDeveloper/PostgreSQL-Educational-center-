CREATE TABLE users(
    user_id BIGSERIAL PRIMARY KEY,
    user_first_name VARCHAR(32) NOT NULL,
    user_last_name VARCHAR(32),
    user_username VARCHAR(32) unique,
    user_password VARCHAR(32) NOT NULL,
    user_contact VARCHAR(12) NOT NULL unique,
    user_gender INT NOT NULL,
    user_age smallint NOT NULL
);
CREATE TABLE groups(
    group_id BIGSERIAL primary key,
    group_name VARCHAR(32) NOT NULL
);
CREATE TABLE group_asistants(
    group_id INT references groups(group_id),
    asistent_id INT references users(user_id)
);
CREATE TABLE group_students(
    group_id INT NOT NULL references groups(group_id),
    student_id INT NOT NULL references users(user_id)
);
CREATE TABLE group_teachers(
    group_id INT NOT NULL references groups(group_id),
    teachar_id INT NOT NULL references users(user_id)
);

INSERT INTO users (user_first_name, user_last_name, user_username, user_password, user_contact, user_gender, user_age) VALUES
('Shohijahon', 'Musinkulov', 'shokhijakhon_dev', 'password', '998991457756', 1, 20),
('Sardor', 'Quvondiqov', 'sardor_dev', 'password', '998991457710', 1, 20),
('Abror', 'Ahmedov', 'abror_dev', 'password', '998991457711', 1, 21),
('Sunnat', 'Hamraqulov', 'sunnat_dev', 'password', '998991457715', 1, 23),
('Shaxzod', 'Qosimov', 'shakhzod_dev', 'password', '998991457721', 1, 23),
('Ramazon', 'Uzoqov', 'ramazon', 'password', '998991457717', 1, 22);
('Mingliboy', 'Qosimov', 'mingliboy', 'password', '998991457790', 1, 24),
('Axtam', 'Xudayarov', 'axtam', 'password', '998991457713', 1, 18),
('Bobur', 'Azizov', 'bobur', 'password', '998991457766', 1, 25);


INSERT INTO groups (group_name) VALUES 
('Node.js Bootcamp'),
('Frontend Standart'),
('Flutter Standart');

INSERT INTO group_teachers (group_id, teachar_id) VALUES
(1, 1),
(2, 2),
(3, 4);
(4, 1)
INSERT INTO group_asistants (group_id, asistent_id) VALUES 
(1, 2),
(2, 3),
(3, 5);
(4, 3);
(2, 5);
INSERT INTO group_students (group_id, student_id) VALUES
(1, 4),
(1, 6),
(1, 10),
(1, 11);
INSERT INTO group_students (group_id, student_id) VALUES
(4, 4),
(4, 6),
(4, 10),
(4, 11)
INSERT INTO group_students (group_id, student_id) VALUES
(2, 4),
(2, 6),
(2, 10),
(2, 11);

-- Node js Bootcamp Inner join

SELECT g.group_name, concat(u.user_first_name || ' ' || u.user_last_name) as teacher_name, 
(a.user_first_name || ' ' || a.user_last_name) as asistent_name from users u 
INNER JOIN group_teachers gt ON gt.teachar_id=u.user_id
INNER JOIN groups g ON  g.group_id=gt.group_id
INNER JOIN group_asistants ga ON g.group_id=ga.group_id
INNER JOIN users a ON ga.asistent_id=a.user_id;

SELECT g.group_name, concat(u.user_first_name || ' ' || u.user_last_name) as teacher_name, concat(a.user_first_name || ' ' || a.user_last_name) from users u
INNER JOIN group_teachers gt ON gt.teachar_id=u.user_id
INNER JOIN groups g ON  g.group_id=gt.group_id
INNER JOIN group_asistants ga ON ga.group_id=g.group_id
INNER JOIN users a ON ga.asistent_id=a.user_id;

SELECT concat(u.user_first_name || ' ' || u.user_last_name) as teacher, json_agg(g.group_name) as groups,
json_agg(a.user_first_name) as asistants from groups g
INNER JOIN group_teachers gt ON gt.group_id=g.group_id
INNER JOIN users u ON gt.teachar_id=u.user_id
INNER JOIN group_asistants ga ON ga.group_id=g.group_id
INNER JOIN users a ON a.user_id=ga.asistent_id 
GROUP BY u.user_first_name, u.user_last_name;

SELECT g.group_name, concat(u.user_first_name) as teacher, COUNT(DISTINCT ga.asistent_id) as asistants, COUNT(DISTINCT gs.student_id)  from groups g
INNER JOIN group_teachers gt ON gt.group_id=g.group_id
INNER JOIN users u ON u.user_id=gt.teachar_id 
INNER JOIN group_asistants ga ON ga.group_id=g.group_id
INNER JOIN group_students gs ON gs.group_id=g.group_id
GROUP BY g.group_name, u.user_first_name;