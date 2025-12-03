% defining Block diagrams in MATLAB
% Every example is followed by its schematics
% Very first block diagram in Matlab
sysg1 = [4];
numg2 = [2]; denumg2 = [1 9 8]; 
sysg2 = tf(numg2,denumg2);
sysh = [0.2];
numg3 = [1]; denumg3 = [1 0];
sysg3 = tf(numg3,denumg3);
sys2 = feedback(sysg2,sysh);
sys1 = series(sysg1,sys2);
sys3 = series(sys1,sysg3);
sys = feedback(sys3,[1]);
