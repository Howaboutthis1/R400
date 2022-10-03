##To test G90909-1000 gene set on 2-dataset model:
yfit_R1000NR_G90909_on_G65292_G58613 = modelR1000NR_RUSBoostTrees.predictFcn(R1000N_G90909N_Test)

cmR1000NR_G90909_on_G65292_G58613 = confusionchart((R1000N_G90909N.Dose),(yfit_R1000NR_G90909_on_G65292_G58613),'RowSummary','row-normalized','ColumnSummary','column-normalized','Title','R1000NR-G90909-on-G65292-G58613')
