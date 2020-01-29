function cleanup(runDir,imexFile)
  
  %clean up after every run
  delete(fullfile(runDir,imexFile.Input));
  delete(fullfile(runDir,imexFile.Output));
  delete(fullfile(runDir,imexFile.Results));
  delete(fullfile(runDir,imexFile.Index));
  delete(fullfile(runDir,imexFile.Log));
  delete(fullfile(runDir,imexFile.rwd));        % novo!
  delete(fullfile(runDir,imexFile.rwo));        %
