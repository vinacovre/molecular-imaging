%Select the text file with the experiment information


[fname dname] = uigetfile({'*.txt;*.rtf','Text Files (*.txt,*.rtf)'; '*.mat','MAT-files (*.mat)'},'Select the Experiment File');

file = fopen(fullfile(dname,fname));
[information,value] = textscan(file,'%s %s');

% Split file name and file type
[fname,ftype] = strtok(fname,'.');

if(strcmp(ftype,'.mat')) % If user opens a .mat file
    
    load(strcat(fname,'.mat'));
    switch lower(type)
        case 'pearl'
            [images700,images800,imagesWhite] = script_pearl_data(dname);
        otherwise
            h = msgbox('Invalid Type', 'Error','error');
            quit
    end
    
else % If user opens a text file
    
    % Code for getting the type in the text file for each OS
    if isunix
        type = information{1,2}{7,1}(1:end-1);
    elseif ispc
        type = char(information{1,2});
    else
        disp('Platform not supported')
    end
    
    switch lower(type)
        case 'pearl'
            [images700,images800,imagesWhite]=script_pearl_data(dname);
        otherwise
            h = msgbox('Invalid Type', 'Error','error');
            quit
    end
    
end