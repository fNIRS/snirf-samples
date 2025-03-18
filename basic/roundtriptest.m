% This script update .snirf and .bnirs files using JSNIRF (JSON-formatted SNIRF)
% as human-readable source files
%
% To make changes to the sample data files, it is recommended to use a text-editor
% to modify the .jnirs file first, and then run this script to update sample files.

if (~exist('loadjsnirf', 'file'))
    error('you must first install jsnirfy toolbox from https://github.com/NeuroJSON/jsnirfy');
end
if (~exist('savebj', 'file'))
    error('you must first install jsonlab toolbox from https://github.com/NeuroJSON/jsonlab');
end
if (~exist('saveh5', 'file'))
    error('you must first install easyh5 toolbox from https://github.com/NeuroJSON/easyh5');
end

files = dir('*.snirf');

for i = 1:length(files)
    dat = loadsnirf(files(i).name);
    savesnirf(dat, regexprep(files(i).name, '\.snirf$', '.snirf'));
    savejsnirf(dat, regexprep(files(i).name, '\.snirf$', '.bnirs'), 'compression', 'zlib');
    dat = snirfdecode(dat, 'jsnirf');
    savejsnirf(dat, regexprep(files(i).name, '\.snirf$', '.jnirs'), 'compression', 'zlib');
end
