filename = 'y054e_subj';

all_data = zeros(67, 2);

for a = 1:67
    load([filename, num2str(a), '.mat'], 'DATA')
    all_data(a, 1:2) = [DATA.subject DATA.group];
end

