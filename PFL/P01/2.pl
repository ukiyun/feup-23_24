% a)

% teachers(course, professor
teaches(algorithms, adalberto).
teaches(databases, bernardete).
teaches(compilers, capitolino).
teaches(statistics, diógenes).
teaches(networks, ermelinda).

% students = attends(course, student)

% 'Algorithms'
attends(algorithms, alberto).
attends(algorithms, bruna).
attends(algorithms, cristina).
attends(algorithms, diogo).
attends(algorithms, eduarda).

% 'Databases'
attends(databases, antónio).
attends(databases, bruno).
attends(databases, cristina).
attends(databases, duarte).
attends(databases, eduardo).

% 'Compilers'
attends(compilers, alberto).
attends(compilers, bernardo).
attends(compilers, clara).
attends(compilers, diana).
attends(compilers, eurico).

% 'Statistics'
attends(statistics, antónio).
attends(statistics, bruna).
attends(statistics, cláudio).
attends(statistics, duarte).
attends(statistics, eva).

% 'Networks'
attends(networks, álvaro).
attends(networks, beatriz).
attends(networks, cláudio).
attends(networks, diana).
attends(networks, eduardo).

% b)
/*

i.  |?- teaches(C, diógenes).                                   not working 
ii. |?- teaches(C, felismina).                                  not working
iii.|?- attends(C, cláudio).                                    not working
iv. |?- attends(C, dalmindo).                                   not working
v.  |?- teaches(C, bernardete), attends(C, eduarda).            not working
vi. |?- attends(C, alberto), attends(c, álvaro).                not working

*/


% c)

% RULES

% is X student of Y?
student(X,Y):- attends(C, X), teaches(C, Y).

% is X teacher of Y?
teacher(X,Y):- student(Y,X).

% is X classmate of Y?
classmates(X,Y):- attends(C, X), attends(C, Y), Y\=X.

% are X and Y collegues?
collegues(X,Y):- teaches(C, X), teaches(C, Y), X\=Y.

% X attends more than one course?
morecourse(X):- attends(C, X), attends(C1, X), C\=C1.


