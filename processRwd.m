function processRwd(templateFile, outputFile)
%
%  processRwd: 
%    Copy results report template file to output file,
%    substituting the names of files.

    [inpf, msg] = fopen(templateFile, 'rb');
    if inpf == -1
        fprintf(stderr, 'Error opening file %s\n', templateFile);
        fprintf(stderr, 'Error message is: ', msg);
        exit(1)
    end

    [outf, msg] = fopen(outputFile, 'wb');
    if outf == -1
        fprintf(stderr, 'Error opening file %s\n', outputFile);
        fprintf(stderr, 'Error message is: ', msg);
        exit(1)
    end


x='<file>';
[d imexBaseName e] =fileparts(outputFile);
y=imexBaseName;

line = fgetl(inpf);
line=strrep(line,x,y);
fprintf(outf, '%s\n',line);

while 1
  line=fgetl(inpf);
  fprintf(outf,'%s\n',line);
  if feof(inpf)
      break
  end;
end


    fclose(inpf);
    fclose(outf);
