##Match Gene name to Probe:

gse[["GSE90909_series_matrix.txt.gz"]]@featureData@data[["GENE_SYMBOL"]][[12000]]
gse[["GSE90909_series_matrix.txt.gz"]]@featureData@data[["ID"]][[12000]]
Ntest <- data.frame(rbind(colnames(outROWnametestXRAYCTRL),outROWnametestXRAYCTRL))
Ntestout <- Ntest

for(i in 4:ncol(Ntest)) {
    cat("i= ", i, "probe: ",Ntest[1,i], "\n")
    for(j in 4:12289){
        if(Ntest[1,i] == gse[["GSE90909_series_matrix.txt.gz"]]@featureData@data[["ID"]][[j]] && gse[["GSE90909_series_matrix.txt.gz"]]@featureData@data[["GENE_SYMBOL"]][[j]] != ""){
            print("found")
            cat("j= ",j, "  Gene Symbol= |", gse[["GSE90909_series_matrix.txt.gz"]]@featureData@data[["GENE_SYMBOL"]][[j]] , "|\n")
            cat("Gene Name: ", gse[["GSE90909_series_matrix.txt.gz"]]@featureData@data[["GENE_NAME"]][[j]], "\n\n")
            Ntestout[1,i] <- gse[["GSE90909_series_matrix.txt.gz"]]@featureData@data[["GENE_SYMBOL"]][[j]]
            break
        }
    }
}
outROWnametestXRAYCTRL <- Ntestout
