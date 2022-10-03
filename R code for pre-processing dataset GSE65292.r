##R code for pre-processing dataset GSE65292:

install.packages("factoextra")
library(factoextra)

library(GEOquery)
library(Biobase)
data <- getGEO(‘GSE65292’)

## to get the phenoData which contains donor/dose/type for each sample
phenoGSE65292 <- as.data.frame(data[["GSE65292_series_matrix.txt.gz"]]@phenoData@data)

expGSE65292 <- as.data.frame(exprs(data[[1]])) #extracting expression data


ph2 <- data.frame(phenoGSE65292$geo_accession)
ph2 <- cbind(ph2, phenoGSE65292$ title)      ## i.e.,  “0Gy_rep1”
ph2 <- cbind(ph2, phenoGSE65292$”characteristics_ch1”)     ## i.e.,  “dose: 0.56 Gy”
ph2 <- cbind(ph2, phenoGSE65292$"characteristics_ch1.1")   ## i.e.,  “dose rate: Acute”
colnames(ph2) <- c("sample", "info", "dose", “dose_rate”)

##to get the genelist from featureData
featureGSE65292 <- as.data.frame(data[["GSE65292_series_matrix.txt.gz"]]@featureData@data)
genelistGSE65292 <- as.data.frame(cbind(featureGSE65292$ID, featureGSE65292$GENE_SYMBOL))

workGSE65292 <- cbind(genelistGSE65292, expGSE65292)
Twork65292 <- t(workGSE65292)
rownames(Twork65292)[2] = "Gene"
rownames(Twork65292)[1] = "ID"

ph3 <- rbind("Gene", ph2)
ph3 <- rbind("ID", ph3)

#colnames(ph3)[1] = "Sample"
#colnames(ph3)[2] = "DoseData"

ph4 <- cbind(ph3, Twork65292)

## remove “dose: ” text & “dose rate: ” text & “ Gy”  text
ph4$dose <- gsub("dose: ", "", ph4$dose)
ph4$dose_rate <- gsub("dose rate: ", "", ph4$dose_rate)
ph4$dose <- gsub(" Gy", "", ph4$dose)

## export it to csv
write.csv(ph4," GSE65292.csv", row.names = FALSE)

#To extract only the chosen samples:
workdose3 <- cbind(rownames(phenoGSE65292),phenoGSE65292$`dose:ch1`,phenoGSE65292$`time:ch1`,phenoGSE65292$`treatment:ch1`,phenoGSE65292$`condition/tp dx:ch1`,phenoGSE65292$`chemo before tp:ch1`,phenoGSE65292$`subject number:ch1`)

colnames(workdose3) <- c("Sample", "Dose","Time","Treatment","Condition","chemo before","Subject number")

workdose4 <- rbind("ID", workdose3)
workdose4 <- rbind("Gene", workdose4)
workdose4 <- cbind(workdose4, Twork65292)

##Pull healthy non-treatment samples and add gene and probe names
workdose4.Healthy.noTRT <- data.frame(subset(workdose4,workdose4[,5]=="Healthy" & workdose4[,4]=="none"))
workdose4.Healthy.noTRT<- rbind(workdose4[2,], workdose4.Healthy.noTRT)
workdose4.Healthy.noTRT<- rbind(workdose4[1,], workdose4.Healthy.noTRT)
