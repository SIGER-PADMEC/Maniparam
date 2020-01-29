function imexFile = makeFileName(runDir)
  
  % makeFileNames: create imex files names for
  % running imex in runDir directory
  % runDir: (string) execution directory
  
  if ~ isdir(runDir)
    [status, msg, msgid] = mkdir(runDir);
    if status ~= 1
      fprintf(stderr, 'Error making directory %s.\n', runDir);
      fprintf(stderr, 'Error message is:  %s.\n', runDir);
    end
  end
    
%   runName= tmpnam(runDir, 'imex-');                   % octave
%   [d imexBaseName e v ] =fileparts(runName);
  
%   [d imexBaseName e v ] =fileparts('imex');             % matlab
imexBaseName=['imex_' num2str(round(10000*rand))];       % isso vai dar problema em paralelo!

imexFile.Input = [imexBaseName, '.dat'];
imexFile.Output = [imexBaseName, '.out'];
imexFile.Results = [imexBaseName, '.mrf'];
imexFile.Index = [imexBaseName, '.irf'];
imexFile.Log = [imexBaseName, '.log'];
imexFile.rwd = [imexBaseName, '.rwd'];
imexFile.rwo = [imexBaseName, '.rwo'];
