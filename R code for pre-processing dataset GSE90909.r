##R code for pre-processing dataset GSE90909:

install.packages("factoextra")
library(factoextra)

library(GEOquery)
library(Biobase)
data <- getGEO(‘GSE90909’)

## to get the phenoData which contains donor/dose/type for each sample
phenoGSE90909 <- as.data.frame(data[["GSE90909_series_matrix.txt.gz"]]@phenoData@data)
expGSE90909 <- as.data.frame(exprs(data[[1]])) #extracting expression data
ph2 <- data.frame(phenoGSE90909$geo_accession)
ph2 <- cbind(ph2, phenoGSE90909$title)     
ph2 <- cbind(ph2, phenoGSE90909$”characteristics_ch1”)  
ph2 <- cbind(ph2, phenoGSE90909$"characteristics_ch1.1")   
colnames(ph2) <- c("sample", "info", "dose", “dose_rate”)

##to get the genelist from featureData
featureGSE90909 <- as.data.frame(data[["GSE90909_series_matrix.txt.gz"]]@featureData@data)
genelistGSE90909 <- as.data.frame(cbind(featureGSE90909$ID, featureGSE90909$GENE_SYMBOL))
workGSE90909 <- cbind(genelistGSE90909, expGSE90909)
Twork90909 <- t(workGSE90909)
rownames(Twork90909)[2] = "Gene"
rownames(Twork90909)[1] = "ID"

ph3 <- rbind("Gene", ph2)
ph3 <- rbind("ID", ph3)

#colnames(ph3)[1] = "Sample"
#colnames(ph3)[2] = "Donor"

ph4 <- cbind(ph3, Twork90909)

## remove “dose: ” text & “dose rate: ” text & “ Gy”  text
ph4$dose <- gsub("dose: ", "", ph4$dose)
ph4$dose_rate <- gsub("dose rate: ", "", ph4$dose_rate)
ph4$dose <- gsub(" Gy", "", ph4$dose)

## export it to csv
write.csv(ph4,"GSE90909.csv", row.names = FALSE)

#To extract only the chosen samples:
workdose3 <- cbind(rownames(phenoGSE90909),phenoGSE90909$`dose:ch1`,phenoGSE90909$`time:ch1`,phenoGSE90909$`treatment:ch1`,phenoGSE90909$`condition/tp dx:ch1`,phenoGSE90909$`chemo before tp:ch1`,phenoGSE90909$`subject number:ch1`)

colnames(workdose3) <- c("Sample", “Donor, "Dose")

workdose4 <- rbind("ID", workdose3)
workdose4 <- rbind("Gene", workdose4)
workdose4 <- cbind(workdose4, Twork90909)
