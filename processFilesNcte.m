function processFilesNcte(templateFile, outputFile, tags, ac, marker)
%
%  processFiles: 
%    Copy template file to output file, substituting the
%    variables indicated in the tags array by their
%    corresponding values.
%    templateFile: (string) name of input template file.
%    outputFile: (string) name of processed output file.
%    tags: (array of structure) name/value pairs.
%    marker: (string) delimiter for variable

%   This will scan the file looking for variables, register
%   where each variable begins, then write out to the output
%   file a segment where there are no variables, write the value of
%   the variable, write the next segment, and so on until the end of
%   file.

    [inpf, msg] = fopen(templateFile, 'rb');
    if inpf == -1
        fprintf(1, 'Error opening file %s\n', templateFile);
        fprintf(1, 'Error message is: ', msg);
%         exit(1)
    end

    [outf, msg] = fopen(outputFile, 'wb');
    if outf == -1
        fprintf(1, 'Error opening file %s\n', outputFile);
        fprintf(1, 'Error message is: ', msg);
%         exit(1)
    end

    [fileContents, count] = fscanf(inpf, '%c', Inf);

    % Create a pattern to define a variable.
    % Starts with the marker, followed by one of more word characters,
    % and ends with a non word character.

    varPattern = [ marker, '\w+' ];

    % Find out where all variables start and end.
    [vstart, vend, vname ] = ...
        regexp(fileContents, varPattern, 'start', 'end', 'match');

    % Write output file, replacing the variables by their values.
    segStart = 1;
    for ivar = 1:length(vstart)
	   fprintf(outf, '%s',fileContents(segStart:vstart(ivar)-1));
	   for jvar = 1:length(tags)  % linear search on tag names
	      if strcmp(tags(jvar).name, vname(ivar))
		     fprintf(outf, '%g', tags(jvar).val);
		     break
          end
	   end
       segStart = vend(ivar) + 1;
    end

    % Last segment
    fprintf(outf, '%s',fileContents(segStart:end));
	
    fclose(inpf);
    fclose(outf);
