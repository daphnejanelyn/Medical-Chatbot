go :-
    retractall(yes(_)),  % Remove any previous diagnosis answers
    retractall(no(_)),
    write('What is the patient\'s name?'),
    read(PatientName),
    write('What is your age?'),
    read(PatientAge),
    (hypothesis(Disease)  % Check for a diagnosis
    ->
        nl,
        write('Name: '),
        write(PatientName),
        nl,
        write('Age: '),
        write(PatientAge),
        nl,
        write('Based on the description and symptoms above, it is suggested that the patient is suffering from '),
        write(Disease),
        nl,
        diagnose_again  % Ask the user if they want to diagnose again
        ;
        write('Sorry, the system is unable to identify the disease'),
        nl,
        diagnose_again).

diagnose_again :-
    nl,
    write('Do you want to perform another diagnosis? (yes or no)'),
    nl,
    read(Response),
    ((Response == yes ; Response == y)
    ->
    go
    ;
    write('Thank you for using the diagnosis system.')).

% Disease 1: Filariasis
hypothesis(filariasis) :-
    symptom('pain and swelling of the genitalia (breast, vagina or scrotum)'),
    symptom('pain and swelling of the legs and arms'),
    (symptom('fever') ;
    symptom('coughing');
    symptom('shortness of breath') ;
    symptom('wheezing')),
    nl,
    nl, !.

% Disease 2: Malaria
hypothesis(malaria) :-
    (symptom('fever') ;
    symptom('chills')),
    (symptom('headache') ;
    symptom('body aches')),
    symptom('nausea'),
    symptom('vomiting'),
    (symptom('fatigue') ;
    symptom('general weakness')),
    nl,
    nl, !.

% Disease 3: Dengue Fever
hypothesis(dengue_fever) :-
    (symptom('fever') ;
    symptom('chills')),
    (symptom('headache') ;
    symptom('pain behind the eyes')),
    (symptom('muscle and joint pain') ;
    symptom('bone pain')),
    (symptom('rash') ;
    symptom('mild bleeding')),
    nl,
    nl, !.


    ask(Question) :-
            write('Is the patient suffering from '),
            write(Question),
            write('? '),
            prompt(_, ''),
            read(Response),
            ((Response == yes ; Response == y) ->
                assert(yes(Question)) ;
                assert(no(Question)), fail).
                    :- dynamic yes/1,no/1.
    
    symptom(S) :-
        (yes(S) ->true;
        (no(S) ->fail;
        ask(S))).
    
    undo :- retract(yes( )),fail.
    undo :- retract(no( )),fail.
    undo.
