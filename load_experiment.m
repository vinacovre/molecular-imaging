%Select the text file with the experiment information


[fname dname] = uigetfile({'*.txt;*.rtf','Text-Files (*.txt,*.rtf)';...
    '*.mat','MAT-Files (*.mat)';...
    '*.czi','CSZ-Files (*.czi)';...
    '*.avi','AVI-Files (*.avi)'},...
    'Select the Experiment File');
%dname = uigetdir(':C','Select Folder With Files');

file = fopen(fullfile(dname,fname));

% Split file name and file type
[fname,ftype] = strtok(fname,'.');

if strcmp(lower(ftype),'.mat') % If user opens a .mat file
    
    load(strcat(fname,'.mat'));
    
    switch lower(type)
        case 'pearl'
            [images700,images800,imagesWhite] = script_pearl_data(dname);
        case 'csz'
            % code for script_csz
        case 'odissey'
            [images700, images800,hasWhite,numberOfScans] = script_odyssey_data(dname);
        case 'avi'
            [images700, images800,hasWhite,numberOfScans] = script_avi_data(dname);
        otherwise
            h = msgbox('Invalid Type', 'Error','error');
            quit
    end
    
elseif strcmp(lower(ftype),'.czi')
    
    % code for script_csz
    
else % If user opens a text file
    
     tline=fgets(file);
     a=textscan(tline,'%s','delimiter','=');
     b=a{1,1};
     
    
    % Code for getting the type in the text file for each OS
    if isunix
        type=b{2,1};
        %type = information{1,2}{7,1}(1:end-1);
    elseif ispc
        type=b{2,1};
        %type = char(information{1,2});
    else
        disp('Platform not supported')
    end
    
    switch lower(type)
        case 'pearl'
            fclose(file);
            [images700,images800,imagesWhite,textData,hasWhite,numberOfScans]=script_pearl_data(dname);
        case 'csz'
            % code for script_csz
        case 'odyssey'
            [images700,images800,hasWhite,numberOfScans] = script_odyssey_data(dname);
        otherwise
            h = msgbox('Invalid Type', 'Error','error');
            quit
    end
    
end