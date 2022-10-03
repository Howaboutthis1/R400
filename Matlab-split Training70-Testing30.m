#Matlab scripts:

##Two datasets were combined into a table called "R1000_BOTHN" and the samples need randomized so they are mixed together. To randomize rows of the combined datasets:

R1000_BOTHNR = R1000_BOTHN(randperm(end),:);



## Split datasets into Training and Testing sets (70% / 30% RESPECTVELY):

cv = cvpartition(size(R1000_BOTHNR,1),'HoldOut',0.3);
idx = cv.test;
R1000_BOTHNR_Train = R1000_BOTHNR(~idx,:);
R1000_BOTHNR_Test = R1000_BOTHNR(idx,:);


##Once the models are built using Matlab's Classifier App use this code to test:
##To automate construction of various gene set sizes and removing dose and sample name from cols 1 & 2:
##Replace the table names to reflecct number of genes...so ‘900’ to ‘800’; then ‘800’ to ‘700’…each time running the code in Matlab to create tables:

R900_BOTHNR_Train = R1000_BOTHNR(~idx,1:900+2);
R900_BOTHNR_Test = R1000_BOTHNR(idx,3:900+2);
yfit_R900NR_BOTH = modelR900NR.predictFcn(R900_BOTHNR_Test)
cmR900NR_BOTH = confusionchart((R0000_BOTHNR_TestDOSES.Dose),( yfit_R900NR_BOTH),'RowSummary','row-normalized','ColumnSummary','column-normalized','Title','R900NR-BOTH')
