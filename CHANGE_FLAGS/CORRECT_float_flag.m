% -========================================================
%   USAGE : CORRECT_float_flag(floatname,dacname,varargin)
%   PURPOSE : plot Argo profiles and modify quality flags in netcdf files using a GUI
% -----------------------------------
%   INPUT :
%    floatname  (char)  e.g. '690258'
%    dacname    (char) e.g.  'coriolis'
%
%   OPTIONNAL INPUT :
%    'ERASE' (logical)  ERASE=1 if float netcdf files (stored in  a local directory)  are replaced by those available on GDAC, ERASE = 0 (default) if not.
%    'VPN' (logical)   0  full mode. VPN=1 more suitable if used with VPN connection (default)
%    'FLAG' (logical)  1 plot the flags (default) 0 do not plot the flags
%    'NB_PROF' (float) number of profiles sampled before and after the analysed profile you want to plot (default is 1)
% -----------------------------------
%   OUTPUT :
% -----------------------------------
%   HISTORY  : created (2016) ccabanes
%
%   CALLED SUBROUTINES: 
% -------------------------------------
% GIT BRANCH: PourOXY
% ========================================================
function CORRECT_float_flag(floatname,dacname,varargin)

% Commented by T. Reynaud 08/09/2020
%init_path

C=load_configuration('config.txt');

DIR_FTP_CORIOLIS=C.DIR_FTP_CORIOLIS;
CONFIG.FILE_TOPO=C.FILE_TOPO_LOW;
CONFIG.DIR_FTP=C.DIR_FTP;
CONFIG.DIR_PLOT=C.DIR_PLOT;

% FLOTEUR ANALYSE
CONFIG.floatname=floatname;
CONFIG.dacname=dacname;
n=length(varargin);

if n/2~=floor(n/2)
    error('check the imput arguments')
end

f=varargin(1:2:end);
c=varargin(2:2:end);
s = cell2struct(c,f,2);
ERASE=0;
VPN=1;
FLAG=1;
NB_PROF=1;
if isfield(s,'ERASE')==1;ERASE=s.ERASE;end;
if isfield(s,'VPN')==1;VPN=s.VPN;end;
if isfield(s,'FLAG')==1;FLAG=s.FLAG;end;
if isfield(s,'NB_PROF')==1;NB_PROF=s.NB_PROF;end;
CONFIG.VPN=VPN;
CONFIG.FLAG=FLAG;
CONFIG.NB_PROF=NB_PROF;

% if ERASE==1
    % destinf=[CONFIG.DIR_FTP '/' CONFIG.dacname '/' CONFIG.floatname '/'];
    % status0=rmdir(destinf,'s');
% end

% if ~exist([CONFIG.DIR_FTP '/' CONFIG.dacname '/' CONFIG.floatname])|| ERASE==1
    % sourcef=[DIR_FTP_CORIOLIS '/' CONFIG.dacname '/' CONFIG.floatname '/*.nc'];
    % destinf=[CONFIG.DIR_FTP '/' CONFIG.dacname '/' CONFIG.floatname '/'];
    % status1=copyfile(sourcef,destinf);
    % disp(['copy status (1 is ok): ' num2str(status1) ])
% end
% if ~exist([CONFIG.DIR_FTP '/' CONFIG.dacname '/' CONFIG.floatname '/profiles/'])|| ERASE==1
    % sourcef=[DIR_FTP_CORIOLIS '/' CONFIG.dacname '/' CONFIG.floatname '/profiles/R*.nc'];
    % destinf=[CONFIG.DIR_FTP '/' CONFIG.dacname '/' CONFIG.floatname '/profiles/'];
    % status2=copyfile(sourcef,destinf);
    % sourcef=[DIR_FTP_CORIOLIS '/' CONFIG.dacname '/' CONFIG.floatname '/profiles/D*.nc'];
    % destinf=[CONFIG.DIR_FTP '/' CONFIG.dacname '/' CONFIG.floatname '/profiles/'];
    % status3=copyfile(sourcef,destinf);
    % disp(['copy status Core Files (1 is ok): '  num2str(status2) ', ' num2str(status3)])
	% sourcef=[DIR_FTP_CORIOLIS '/' CONFIG.dacname '/' CONFIG.floatname '/profiles/BR*.nc'];
    % destinf=[CONFIG.DIR_FTP '/' CONFIG.dacname '/' CONFIG.floatname '/profiles/'];
    % status2=copyfile(sourcef,destinf);
    % sourcef=[DIR_FTP_CORIOLIS '/' CONFIG.dacname '/' CONFIG.floatname '/profiles/BD*.nc'];
    % destinf=[CONFIG.DIR_FTP '/' CONFIG.dacname '/' CONFIG.floatname '/profiles/'];
    % status3=copyfile(sourcef,destinf);
    % disp(['copy status Core Files (1 is ok): '  num2str(status2) ', ' num2str(status3)])
% end


flag_diag_App_v2('Config',CONFIG)

%change_flag('Config',CONFIG)

