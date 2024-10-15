function [behav1,brain1]=coattend5(behav,brain)





[~,a,b] = intersect(behav.IID,brain.subjectkey);

behav1= behav(a,:);
brain1= brain(b,:);


behav1.IID = []; 
brain1.subjectkey = []; 