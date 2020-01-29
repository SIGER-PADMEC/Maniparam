
function [tags,ac] = readDakotaParam(paramFile,var)
%readDakotaParam:
%creat a table of pairs (name,value)
%from a dakota parameter file
%paramfile: (String) file name to open
%tags: (array os structures) array of (name, value) pairs. 

% [inpf, msg] = fopen(paramFile, 'rt');
[inpf, msg] = fopen(paramFile, 'r+');

if inpf == -1
   fprintf('Error opening parameter file %s\n',paramFile);
   fprintf('Error message: %s/n', msg);
%    exit(1);
end
   
nvar=length(var);%nvar = fscanf(inpf, '%d'); 
tags = [];

for ivar = 1:nvar
%     tags(ivar).val = fscanf(inpf, '%g');
    tags(ivar).val=var(ivar);
%     tags(ivar).name = fscanf(inpf, '%s',1);
end
%tags(ivar).val = var;

%find analysis components section
while 1
    lin = fgetl(inpf);
%   if index(lin, 'analysis_components')                % octave
    if ~isempty(strfind(lin, 'analysis_components'))      % matlab
        break
    end
end
nc = sscanf(lin,'%d', 1);
ac = {};
for i = 1:nc
  ac{i} = fscanf(inpf, '%s',1);
  fgetl(inpf);
end
fclose(inpf);
