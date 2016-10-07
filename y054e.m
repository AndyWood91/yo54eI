clc, clear all
rng('shuffle')

addpath('functions');  % Andy - reorganised program files
addpath('instructions');  % Andy - reorganised program files


% variables modificables
numBlocks1A = 6;
numBlocks1B = 7;
numBlocks2 = 8;
interTrialInterval = 1;     % <--- 1
fixationInterval = 0.5;     % <--- 0.5
feedbackInterval = 3;       % <--- 3


% Andy's participant info - checks inputs on entry to reduce errors
DATA.start_time = datestr(now,0);  % get current time
while true  % subject loop
    try
        subject = input('Participant number --> ', 's');  % storing this as a string to stop Matlab accepting expressions or named variables as inputs
    catch
        % do nothing with errors, subject loop will repeat
    end
    
    % validation
    if str2double(subject) > 0  % only accept positive values
        subject = str2double(subject);  % convert to number
        DATA.subject = subject;  % save to DATA
        break  % exit the subject loop
    else
        % do nothing, subject loop will repeat
    end

end  % subject loop
while true  % SOA loop
%     try
%         SOA = input('SOA? 1=250 / 2=1000 --> ', 's');  % storing this as a string to stop Matlab accepting expressions or named variables as inputs
%     catch
%         % do nothing with errors, SOA loop will repeat
%     end

    SOA = '1';  % only using 250ms for now
    
    % validation
    if strcmp(SOA, '1')
        SOA = 250;
        DATA.SOA = SOA;  % save to DATA
        break  % exit the SOA loop
    elseif strcmp(SOA, '2')
        SOA = 1000;
        DATA.SOA = SOA;  % save to DATA
        break  % exit the SOA loop
    else
        % do nothing, SOA loop will repeat
    end

end  % SOA loop
while true  % group loop
    try
        group = input('Group/Sprites? (1/2/3) --> ', 's');  % storing this as a string to stop Matlab accepting expressions or named variables as inputs
    catch
        % do nothing with errors, group loop will repeat
    end
    
    % validation
    if str2double(group) > 1 && str2double(group) < 4  % only accept values from 2 to 3 (simple/supercomplex)
        group = str2double(group);  % convert to number
        DATA.group = group;  % save to data
        break  % exit group loop
    else
        % do nothing, group loop will repeat
    end

end  % group loop
while true  % age loop
    try
        age = input('Participant age --> ', 's');  % stored as a string to stop Matlab accepting expressions or named variables as inputs
    catch
        % do nothing with errors, age loop will repeat
    end

    % validation
    if str2double(age) > 0  % only accept positive values
        age = str2double(age);  % convert to number
        DATA.age = age;  % save to DATA
        break  % exit the age loop
    else
        % do nothing, age loop will repeat
    end

end  % age loop
while true  % gender loop
    try
        gender = input('Participant gender (use first letter): man/other/woman --> ', 's');  % stored as a string to stop Matlab accepting expressions or named variables as inputs
    catch
        % do nothing with errors, hand loop will repeat
    end

    % validation
    if strcmpi(gender, 'm') || strcmpi(gender, 'o') || strcmpi(gender, 'w')  % acceptable inputs, case insensitive
        gender = upper(gender);  % convert to upper case
        DATA.gender = gender;  % save to DATA
        break  % exit gender loop
    else
        % do nothing, gender loop will repeat
    end
end  % gender loop
while true  % hand loop
    try
        hand = input('Participant dominant hand (use first letter): ambidextrous/left/right --> ', 's');  % stored as a string to stop Matlab accepting expressions or named variables as inputs
    catch
        % do nothing with errors, hand loop will repeat
    end

    % validation
    if strcmpi(hand, 'a') || strcmpi(hand, 'l') || strcmpi(hand, 'r')  % set acceptable options, case insensitive
        hand = upper(hand);  % convert to upper case
        DATA.hand = hand;  % save to DATA
        break  % exit hand loop
    else
        % do nothing, hand loop will repeat
    end
end  % hand loop


% setup cogent
config_display(1,2,[0 0 0],[1 1 1],'Helvetica',16,4,0);
config_sound;
config_keyboard(100,1,'nonexclusive');
start_cogent;

% hacer imagénes y secuencia
if DATA.group==1
    makeSprites1
elseif DATA.group==2
    makeSprites2
else
    makeSprites3
end
[sequence, DATA.cues, DATA.outcomes] = makeSequence(DATA.SOA, numBlocks1A, numBlocks1B, numBlocks2);

numPretrainingTrials = sum(sequence(:,1) <= numBlocks1A);
DATA.trials = [];

% entrenamiento
for trial = 1:size(sequence, 1)
    
    trial
    
    % instrucciones
    if trial == 1;
        instrSet = 1;
        showInstructions(instrSet);
    elseif trial == numPretrainingTrials+1;
        instrSet = 2;
        showInstructions(instrSet);
    end
    
    % presentar ensayos
    if sequence(trial,4)==0 % si es un ensayo sin dot...
        responseVariables = trialCat(sequence(trial,:), interTrialInterval, fixationInterval, feedbackInterval);
    else % si es un ensayo con dot...
        responseVariables = trialDot(sequence(trial,:), interTrialInterval, fixationInterval, feedbackInterval);
    end

    % guardar datos
    DATA.trials = [DATA.trials; trial, sequence(trial,:), responseVariables];
    save(strcat('y054e_subj', (int2str(DATA.subject))),'DATA');

end



% % <--------------------------- IF YOU WANT TO REMOVE JUDGMENTS, REMOVE LINES FROM HERE...
% cgflip(0, 0, 0); pause(2)
% loadpict('instr13.jpg', 1);
% drawpict(1);
% waitkeydown(inf);
% cgflip(0,0,0); pause(1)
% judgmentStage
% save(strcat('y054e_subj', (int2str(DATA.subject))),'DATA');
% % <--------------------------- ... TO HERE



% end screen
cgflip(0,0,0); pause(2)
cgdrawsprite(1006,0,0); cgflip (0, 0, 0)
waitkeydown(inf, 52); % wait until ESC pressed
stop_cogent

rmpath('functions');  % Andy - reorganised program files
rmpath('instructions');  % Andy - reorgansied program files