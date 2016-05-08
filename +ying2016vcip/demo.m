%% Illumination-Robust Approach for Feature-Based Road Detection
% (Zhenqiang Ying, Ge Li, Guozhen Tan & Siwei Ma) to appear in VCIP 2016
% (IEEE International Conference on Visual Communications and Image
% Processing 2016) conference.
%
% Email: yinzhenqiang # gmail.com
% Website: https://github.com/baidut/openvehiclevision

mkdir('results');

global db;

db = exDebugger(...
    'saveAsEps','true',...
    'nameFunc',@(x)x.Name,...
    'level',1,...
    'path','.\results'...
);

path = ying2016vcip.settings.roma_path;
roma = RomaDataset(ying2016vcip.settings.roma_path);

files = roma.data.filename;

N = numel(files);
missL = false(N,1);
missM = false(N,1);
missR = false(N,1);
falseL = false(N,1);
falseM = false(N,1);
falseR = false(N,1);

for n = 1 : N
    fprintf('Processing:%s...\n',files{n});
	[fig, missL(n), missM(n), missR(n)]  = ying2016vcip.roadDetection(files{n});
    db.imdumpd(1, fig); 
    close(fig);
end

%% table
name = roma.data.name;
situation = roma.data.situation;
scenario = roma.data.scenario;

t = table(name, missL, missM, missR, falseL, falseM, falseR, ...
    situation, scenario);
writetable(t, 'eval.csv','Delimiter',',','QuoteStrings',true);
 
%%
text = evalc('ying2016vcip.gentex');
fid = fopen('results/evaluation.tex','w');
fprintf(fid, '%s', text);
fclose(fid);