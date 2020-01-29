function vpl = posProcessadorImexr(dakotaResponseFile, simOutputFile, ac)

%--   Funcao:
%--   criar uma arquivo dakota response que grava a producao 
%--   acumuladar do oleo , agua e gas  por tempo extraidos de um 
%--   arquivo de saida do simulador. Posteriormente os dados serao
%--   recuperados para calcular o valor presente liquido - VPL
%--   Parametros de entrada:
%--   dakotaResultFile: (string) nome do arquivo dakota response 
%--   simOutputFile: (string) nome do arquivo do results report
%--   Parametro de saida
%--   resultado: matriz resultado
%--

global std_fit

[resFile, msg] = fopen(dakotaResponseFile, 'wt');
if resFile < 0
  printf(stderr, 'Error opening file %s\n', dakotaResponseFile);
  printf(stderr, 'Error msg is %s\n', msg);
  exit;
end
%--
[fid, msg] = fopen(simOutputFile, 'rt');
if fid < 0
  printf(stderr, 'Error opening file %s\n', simOutputFile);
  printf(stderr, 'Error msg is %s\n', msg);
  exit;
end

for k=1:9
    lixo=fgets(fid);
end
k=1;
while ~feof(fid)
    [A,count]=fscanf(fid,'%f',4);
    if count==0
        break
    end;
    d(k)=A(1);
    op_ac(k)=A(2);
    ap_ac(k)=A(3);
    ai_ac(k)=A(4);    
    k=k+1;
end

resultado(1,:)=d;
resultado(2,:)=op_ac;
resultado(3,:)=ap_ac;
resultado(4,:)=0.0*d;
resultado(5,:)=ai_ac;

vpl = -abs(VPL(resultado,ac)/std_fit);

fprintf(resFile,'%20.9e vpl\n',vpl);
   
% fecha os arquivos
fclose(fid);
fclose(resFile);
