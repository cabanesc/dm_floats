function [Co]=check_LastDimArray_is(Co,DIMNAME)
% -========================================================
%  [Co]=check_LastDimArray_is(Co,DIMNAME)
%   PURPOSE : short description of the function here
% -----------------------------------
%   INPUT :
%     IN1   (class)  -comments-
%             additional description
%     IN2   (class)  -comments-
%
%   OPTIONNAL INPUT :
%    OPTION1  (class)  -comments-
% -----------------------------------
%   OUTPUT :
%     OUT1   (class)  -comments-
%             additional description
%     OUT2   (class)  -comments-
%             additional description
% -----------------------------------
%   HISTORY  : created (2009) ccabanes
%            : modified (yyyy) byxxx 
%   CALLED SUBROUTINES: none
% ========================================================


lowname=lower(DIMNAME);


if isempty(strfind(Co.obj,'ObsInSitu'))
   error('check_FirstDimArray_is not define for this type of structure')
else
    gotoend=0;
    if isfield(Co,'lastdimname')
    if strcmp(Co.lastdimname,DIMNAME)==1
	gotoend=1;
    end
    end
    
    champs = fieldnames(Co);    %champs={'psal','psalqc','psalad',....}
    Nbfields = length(champs);
    testonechange=0;
    for k=1:Nbfields            % boucle sur toutes les variables
	oneChamp=champs{k};
	if isfield(Co.(oneChamp),'data')
	    if isempty(Co.(oneChamp).data)==0
		if isfield(Co.(oneChamp),'dim')
		    isthedim=strcmp(Co.(oneChamp).dim,DIMNAME);
		    if sum(isthedim)==1
			testonechange=1;
			if gotoend==0
			    vecdim=[1:length(isthedim)];
			    vecdim(end)=vecdim(isthedim);
			    vecdim(isthedim)=length(isthedim);
			    sauv=Co.(oneChamp).dim{end};
			    Co.(oneChamp).dim{end}=DIMNAME;
			    Co.(oneChamp).dim{isthedim}=sauv;
			    if length(vecdim)>1
				Co.(oneChamp).data=permute(Co.(oneChamp).data,vecdim);
			    else
				if size(Co.(oneChamp).data,2)>1
				    Co.(oneChamp).data=Co.(oneChamp).data';
				end
			    end
			    % Sauvegarde la derniere dimension

			    Co.(lowname)=size(Co.(oneChamp).data,length(isthedim));
			    
			else
			    lowname=lower(DIMNAME);
			    Co.(lowname)=size(Co.(oneChamp).data,length(isthedim));
			end
		    end
		end
	    else
	    Co.(lowname)=0;
	    end
	end
    end
    
    
    if testonechange==0
	disp(['Does not find this dimension: ',DIMNAME])
    else
	Co.lastdimname=DIMNAME;
    end
end





