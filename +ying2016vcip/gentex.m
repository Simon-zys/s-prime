function gentex

path = ying2016vcip.settings.roma_path;
title = 'Supplementary Material for Paper 61 \\ Illumination-Robust Approach for Feature-Based Road Detection';
author = 'Anonymous VCIP Submission';


%% gen '.tex' file automatically
disp('%%This tex file is generated by matlab code automatically, see "gentex.m"');
disp('\documentclass[landscape,8pt]{article}'); % twocolumn,a4paper
disp('\usepackage[pdftex]{graphicx}');
disp('\DeclareGraphicsExtensions{.eps}');
disp('\usepackage{subfigure}'); %[tight,footnotesize]
disp('\renewcommand{\thesubfigure}{\thefigure.\arabic{subfigure}}');
disp('\usepackage{geometry}');
disp('\geometry{left=0.5cm,right=0.5cm,top=2cm,bottom=2cm}');
disp(char(10));

disp('\begin{document}');
fprintf('\\title{%s}\n',title);
fprintf('\\author{%s}\n',author);
disp('\maketitle');
disp(char(10));


dataset = 'roma';
situation = subfolder(path);
imagelist = {'img.mov', 'imgnormal.mov', 'imgadvlight.mov', 'imghighcurv.mov'};
scenarios = {'Normal', 'Adverse Light', 'Curved Road'};

addpath(path); % call loadlist

% disp(['\section{',dataset,'}']);
disp(['\section{Overall}']);
n = 1; % 'img.mov' - the list of all the original images
for m = 1:length(situation)
    movFile = fullfile(path,situation{m},imagelist{n});
    files = loadlist(movFile);
    disp('\begin{figure}[!h]\centering'); % 
    for i = 1:length(files)
        [~, name, ~] = fileparts(files{i});
        disp(['\subfigure[' name ']{' ... 
                         '\includegraphics[width=0.5in]{' name '}' ...
            '}']);% \label{fig:' ,dataset,situation{m},name, '}
        %if mod(i,3)==0, disp('\\'); end
    end
    disp(['\caption{', ...
        sprintf('%s/%s/%s',dataset,situation{m},imagelist{n}), ...
        '}']);
    disp(['\end{figure}' 10]);
end

disp('\clearpage ');
% disp('\cleardoublepage');

disp(['\section{Scenarios}']); % Challenging
for n = 2:length(imagelist)
    disp(['\subsection{',scenarios{n-1},'}']);
    disp('\begin{figure}[!h]\centering'); % \centering
    
    for m = 1:length(situation)
		movFile = fullfile(path,situation{m},imagelist{n});
		files = loadlist(movFile);
		for i = 1:length(files)
			[~, name, ~] = fileparts(files{i});
			disp(['\subfigure[' name ']{' ... 
				             '\includegraphics[width=0.5in]{' name '}' ...
				'}']);% \label{fig:' ,dataset,situation{m},name, '}
			%if mod(i,3)==0, disp('\\'); end
		end
    end
    disp(['\caption{', ...
			sprintf('%s/%s/%s',dataset,situation{m},imagelist{n}), ...
			'}']);
    disp(['\end{figure}' 10]);
    %if mod(i,2)==0, disp('\clearpage'); end
end

disp('\end{document}');