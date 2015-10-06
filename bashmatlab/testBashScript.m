% 

pwd = '/Users/victorbergelin/Repo/TATA62'

pathToScript = fullfile(pwd,'myBashScript.sh');  % assumes script is in curent directory
subject1     = 'bert';
subject2     = 'ernie';
cmdStr       = [pathToScript ' ' subject1 ' ' subject2];
system(cmdStr);