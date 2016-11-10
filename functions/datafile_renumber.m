function [] = datafile_renumber(directory_name, file_extension, title, counterbalancing)
% DATAFILE_RENUMBER:  renumbers the datafiles in a folder according to
% their counterbalancing condition. Maximum of 9 counterbalancing
% conditions and 99 participants in a condition.

    data_filenames = dir([directory_name, '/*', file_extension]);  % get all of the files in the directory
    
    counters = zeros(2, numel(counterbalancing));  % setup counters for renaming files
    counters(1, :) = counterbalancing;  % headings
     
    for a = 1:length(data_filenames)
        
        filename = data_filenames(a).name;

        load([directory_name, '/', filename], 'DATA')
        
        group = DATA.group;
        % need to find group in counters(1, :)
        counter_index = find(counters(1, :) == group);
        counters(2, counter_index) = counters(2, counter_index) + 1;
        
        if counters(2, counter_index) < 10
            participant = str2double([int2str(group), '0', int2str(counters(2, counter_index))]);
        elseif counters(2, counter_index) >= 10
            participant = str2double([int2str(group), int2str(counters(2, counter_index))]);
        else
            error('shouldn''t be this many participants')
        end
        
        DATA.subject = participant;
        DATA.title = title;       
        
        new_filename = [directory_name, '/', title, '_participant', int2str(participant)];
        save(new_filename, 'DATA')

    end

end
