%
% function
% [dephmld,tpotmld,psalmld,sig0mld]=calmld_val(sig01,deph1,tpot1,psal1,critere,valcrit)
%
% Function qui calcule la profondeur de la
% couche de melange en fonction de divers
% criteres
% critere = 
% 'dsig'      : sig0(1er niv) - sig0(base mld) <= valcrit
% 'dt'         : tpot(1er niv) - tpot(base mld) <= valcrit
% 'dsig&dt' : sig0(1er niv) - sig0(base mld) <= valcrit(1)
%               et tpot(1er niv) - tpot(base mld) <= valcrit(2)
% 'dsigdt'     : sig0(1er niv) - sig0(base mld) <= dsigm
%               et tpot(1er niv) - tpot(base mld) <= valcrit
%             avec dsigm = sigm(psal(1er niv),tpot(1er niv),0) 
%                        - sigm(psal(1er niv),tpot(1er niv)-valcrit,0)
%
% le 1er niveau est egal a : 1er niv = 10 m
%
% creation V. Thierry juin 2005
%

function [dephmld,tpotmld,psalmld,sig0mld]=calmld_val(sig01,deph1,tpot1,psal1,critere,valcrit)

len=length(sig01);
ifin=find((isfinite(sig01)==1) & (deph1>=0));
casnan='n';

if isempty(ifin) == 1
  casnan='y';
elseif deph1(ifin(1))<=10 % 1er niveau fini doit etre == 10 m
  iz=ifin(1);
  indmld=iz;
  sig20=sig01(iz);
  tpo20=tpot1(iz);
  psa20=psal1(iz);
  conti='y';
  while strcmp(conti,'y') == 1
    iz=iz+1;
    indmld=iz-1;
    if iz <= len
      
      switch critere
	
	case 'dsig'
	  signp1=sig01(iz);
          if isfinite(signp1) & (signp1 <= sig20+valcrit)
            conti='y';
          else
	    conti='n';
	  end
	  
	case 'dt'
	  tponp1=tpot1(iz);
	  if isfinite(tponp1) & (abs(tponp1-tpo20)<= valcrit)
            conti='y';
          else
	    conti='n';
	  end
	  
	case 'dsig&dt'
	  signp1=sig01(iz);
	  tponp1=tpot1(iz);
	  
	  if isfinite(tponp1) & (abs(tponp1-tpo20) <= valcrit(2)) & (signp1 <= sig20+valcrit(1))
            conti='y';
          else
	    conti='n';
	  end
	  
	case 'dsigdt'
	  [svan,sigma1]=swstat90(psa20,tpo20,0);
	  [svan,sigma2]=swstat90(psa20,tpo20-valcrit,0);
	  dsigm=abs(sigma2-sigma1);
	  signp1=sig01(iz);
	  tponp1=tpot1(iz);
	  
	  if isfinite(tponp1) & (abs(tponp1-tpo20) <= valcrit) & (signp1 <= sig20+dsigm)
            conti='y';
          else
	    conti='n';
	  end
	  
      end
 
    else
      conti='n';
    end
  end
else
  casnan='y';
  deph1(ifin(1));
end


if strcmp(casnan,'n') == 1
  dephmld=deph1(indmld);
  sig0mld=mynanmean(sig01(1:indmld));
  tpotmld=mynanmean(tpot1(1:indmld));
  psalmld=mynanmean(psal1(1:indmld));
  
  
elseif strcmp(casnan,'y') == 1
  dephmld=NaN;
  sig0mld=NaN;
  tpotmld=NaN;
  psalmld=NaN;
end
