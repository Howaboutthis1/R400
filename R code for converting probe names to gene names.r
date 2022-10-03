##R code for converting probe names to gene names:

for(i in 1:nrow(newDFX)) {
  CN <- rownames(newDFX[i,])
  print("Looking to replace...")
  print(CN)
  for(j in 1:nrow(Probe2Gene2)) {
    if(CN == Probe2Gene2[j,1]){
      print(Probe2Gene2[j,2])
      rownames(newDFX[i,]) = Probe2Gene2[j,2]
      print(rownames(newDFX[i,]))
      break
    }
  }
}


for(i in 1:nrow(outDonorPH4GeneT)) {
  CN <- rownames(outDonorPH4GeneT[i,])
  cat("Looking to replace... ", CN)
  for(j in 1:nrow(Probe2Gene2)) {
    if(CN == Probe2Gene2[j,1]){
     ## print(Probe2Gene2[j,2])
      rownames(outDonorPH4GeneT[i,]) = Probe2Gene2[j,2]
      print(rownames(outDonorPH4GeneT[i,]))
      break
    }
  }
}
