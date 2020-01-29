function time = calendario(ac,ano)

Tc = ac.T; % Tempo de concessão do reservatório 

pos = 0;
for i = 1:Tc
	if mod(ano,400) == 0 
		bissexto = 29;
	elseif mod(ano,4) == 0  
		bissexto = 29;
	else
		bissexto = 28;	
	end

	mes(1).dias = (31);
	mes(2).dias = (bissexto);
	mes(3).dias = (31);
	mes(4).dias = (30);
	mes(5).dias = (31);
	mes(6).dias = (30);
	mes(7).dias = (31);
	mes(8).dias = (31);
	mes(9).dias = (30);
	mes(10).dias = (31);
	mes(11).dias = (30);
	mes(12).dias = (31);

	for j = 1:12
		pos = pos + 1;
		if pos == 1			
		time(pos,1) = mes(j).dias;
		time(pos,2) = 0;
		else
		time(pos,1) = time(pos-1,1) + mes(j).dias;
		time(pos,2)=0;
		end
	end
	ano = ano + 1;
end
time(pos,:)=[];


