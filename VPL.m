
function vpl = VPL(ResultsImex, ac)
  % VPL: Calculo do Valor Presente Liquido (VPL) de um fluxo de caixa.
  % --------------------------------------------------------------------------
  % vpl = VPL(tax)
  %
  % vpl   -  Valor Presente Liquido                                       (out)
  % tax   -  taxa de desconto em % ao dia                                 (in)
  % --------------------------------------------------------------------------
  % -------------------------------------------------------------------------
  % OTIMIZACAO DINAMICA DAS VAZOES DE PRODUCAO E INJECAO EM POCOS DE PETROLEO
  % -------------------------------------------------------------------------
  % Universidade Federal de Pernambuco
  % Programa de Pos-Gradua�ao Engenharia Civil / Estruturas
  %
  % Petrobras
  % Centro de Pesquisas - CENPES
  % 
  % --------------------------------------------------------------------------
  % Criado:        08-Nov-2005      Diego Oliveira
  %
  % Moficacao:     18-Jan-2006      Diego Oliveira
  %                Incorporacao da funcao que gerava o fluxo de caixa.
  % --------------------------------------------------------------------------
  
  Oleo_Produzido_Ac = ResultsImex(2,:);
  Agua_Produzida_Ac = ResultsImex(3,:);
  Agua_Injetada_Ac = ResultsImex(5,:);
  Dias = ResultsImex(1,:);
  R_Oleo_Produzido = 25;
  C_Agua_Produzida = 5;
  C_Agua_Injetada = 2;
  tma = 0.093;
  %outros_custos;
  
  %Producoes Acumuladas
  op_ac = Oleo_Produzido_Ac;
  ap_ac = Agua_Produzida_Ac;
  ai_ac = Agua_Injetada_Ac;
  
  %Receita
  rop=R_Oleo_Produzido; %receita liquida unitaria do oleo
  %OPEX
  cap=C_Agua_Produzida; %custo unitaria da agua produzida
  cai=C_Agua_Injetada;  %custo unitaria da agua injetada
  %CAPEX
  %capex=outros_custos;
  
  %Verificacao de Compatibilidade
  % n_op = length(Oleo_Produzido_Ac);
  % n_ap = length(Agua_Produzida_Ac);
  % n_ai = length(Agua_Injetada_Ac);
  % n_d  = length(Dias);
  % if (n_op~=n_ap)%~=n_ai~=n_d)
  %     error('dimensao das curvas de producao sao diferentes!');
  % else
  n = length(Oleo_Produzido_Ac);
  % end
  
  %Curvas de Producao e Injecao
  % Oleo Produzido
  op_aux1=[op_ac 0];
  op_aux2=[0 op_ac];
  op = op_aux1-op_aux2;
  op = op(1:n);
  % Agua Produzida
  ap_aux1=[ap_ac 0];
  ap_aux2=[0 ap_ac];
  ap = ap_aux1-ap_aux2;
  ap = ap(1:n);
  % Agua Injetada
  ai_aux1=[ai_ac 0];
  ai_aux2=[0 ai_ac];
  ai = ai_aux1-ai_aux2;
  ai = ai(1:n);
  
  %Montagem do Fluxo de Caixa
  for i=1:n
    %if i==1
    %  FC(i)=op(i)*rop-(ap(i)*cap+ai(i)*cai+capex);
    %end
    FC(i)=op(i)*rop-(ap(i)*cap+ai(i)*cai);
  end
  
  %Atualizacao do Fluxo de Caixa
  tax = ((1+tma)^(1/365)-1);
  S=0;
  for i=1:n
    fator_desconto = 1/((1+tax)^(Dias(i)));
    S = S + FC(i)*fator_desconto;
  end
  
  vpl = S;
