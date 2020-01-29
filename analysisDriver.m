function vpl = analysisDriver(dakotaResponseFile,var)

global ac

[tags] = ManipParamNp(var,ac);

templateFileName = ac.mxtpl;
runDir = ac.dir;
path(path,runDir)
templaterwd = ac.rrtpl;
imexFile = makeFileName(runDir);

tempo = ac.time;

if tempo == 0
    processFilesNcte(templateFileName,fullfile(runDir, imexFile.Input), tags, ac,'\$');
else
    processFilesNvar(templateFileName,fullfile(runDir, imexFile.Input), tags, ac,'\$');
end

processRwd(templaterwd,fullfile(runDir,imexFile.rwd));       %novo!

cwd = pwd(); cd(runDir);

% imexCmd = ['mx201010.exe -f ' imexFile.Input ' -log'];     %
imexCmd = ['"C:\Program Files (x86)\CMG\IMEX\2012.10\Win_x64\EXE\mx201210.exe" -f ' imexFile.Input ' -log -wait'];
status = system(imexCmd);

if status ~= 0
  fprintf(1,'Error running imex ! \n');
%   exit(status);
end
reportCmd = ['"C:\Program Files (x86)\CMG\BR\2012.10\Win_x64\EXE\report.exe" -f ' imexFile.rwd '  -o ' imexFile.rwo];
status = system(reportCmd);                                         %
if status ~= 0                                                      % novo!
  fprintf(stderr,'Error running report ! \n');                      %
  exit(status);                                                     %
end                                                                 %

cd(cwd);

vpl = posProcessadorImexr(dakotaResponseFile,imexFile.rwo,ac);

cleanup(runDir, imexFile);

% printf('*****Finishing analysis driver ./n')
