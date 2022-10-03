##R code for pre-processing dataset GSE58613:

library(GEOquery)
library(Biobase)
data <- getGEO('GSE58613')
data <- as.data.frame(exprs(data[[1]])) #extracting expression data

install.packages("factoextra")
library(factoextra)

## to get the phenoData which contains donor/dose/type for each sample
phenoGSE58613 <- as.data.frame(GSE58613data[["GSE58613_series_matrix.txt.gz"]]@phenoData@data)


##Format the data to get the sample/dose/donor/type
ph2 <- data.frame(phenoData$geo_accession)
ph2 <- cbind(ph2, phenoData$ title)
ph2 <- cbind(ph2, phenoData$`donor:ch1`)
colnames(ph2) <- c("sample", "info", "donor")

library(stringr)
ph3 <- ph2

for(i in 1:nrow(ph3)){
    (ph3[i,2] = str_remove(ph3[i,2], "Gy"))}

for(i in 1:nrow(ph3)){
    (ph3[i,2] = str_remove(ph3[i,2], "rep"))}

for(i in 1:nrow(ph3)){
    (ph3[i,2] = str_remove(ph3[i,2], "blood"))}

## remove double spaces before splitting
for(i in 1:nrow(ph3)){
    (ph3[i,2] = str_replace(ph3[i,2], "  ", " "))}

for(i in 1:nrow(ph3)){
    (ph3[i,2] = str_replace(ph3[i,2], "Neutron", "1"))}

for(i in 1:nrow(ph3)){
    (ph3[i,2] = str_replace(ph3[i,2], "X-ray", "2"))}

for(i in 1:nrow(ph3)){
    (ph3[i,2] = str_replace(ph3[i,2], "Control", "0 0"))}

outPH3 <- data.frame(str_split_fixed(ph3$info, " ", 4))
colnames(outPH3) <- c("Sample", "Dose", "Type", "Donor")
outPH3[,1] <- ph3[,1]
outDonorPH4 <- cbind(outPH3, dataT2)
## remove redundant first col : GSMs are in rownames
outDonorPH4 <- outDonorPH4[,-1]


##--Convert dose/type/donor from char to numeric-----------------------------------------
## check types of col 1-5
sapply(outDonorPH4[1:5],class)
outDonorPH4$Dose <- as.numeric(outDonorPH4$Dose)
outDonorPH4$Type <- as.numeric(outDonorPH4$Type)
outDonorPH4$Donor <- as.numeric(outDonorPH4$Donor)
## again check types of col 1-5
sapply(outDonorPH4[1:5],class)

## replace NAs with col avgs
for(i in 1:ncol(outDonorPH4)){
    outDonorPH4[is.na(outDonorPH4[,i]), i] <- mean(outDonorPH4[,i], na.rm = TRUE)
}
