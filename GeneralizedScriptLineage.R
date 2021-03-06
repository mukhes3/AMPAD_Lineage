FileName <- './DE_lineages/Mayo'

Dat <- read.delim('MAYO_CBE_TCX_logCPM.tsv',stringsAsFactors = F)
Dat2 <- read.delim('MAYO_CBE_TCX_Covariates.tsv',stringsAsFactors = F)

source('LineageFunctions.R')
source('MiscPreprocessing.R')


BR <- unlist(strsplit(Dat2$Tissue.Diagnosis,'\\.'))
BR <- unique(BR[c(TRUE, FALSE)])
#BR <- c('DLPFC')

Sex <- unique(Dat2$Sex)


for (i in 1:length(BR)){
  
  t <- paste(BR[i],'.csv',sep='')
  #AMP_mods <- read.csv(t)
  AMP_mods <- read.csv('TCX_DE.csv')
  
  for (j in 1:length(Sex)){
    
    l <- Normalize.Data(Dat, Dat2, AMP_mods, DelChars = T)
    Dat2 <- l$Dat2
    DatNorm  <- l$DatNorm  
    DatNorm2 <- l$DatNorm2 
    
    l <- Subset.Data.Sex.BR(DatNorm2, Dat2, BR[i],Sex[j], Tdiag = T)
    Dat4  <- l$Dat4  
    DatNorm4 <- l$DatNorm4 
    
    l2 <- c('Tissue.Diagnosis','Tissue.APOE4','AOD')
    
    Run.Lineage.BR(Dat4, DatNorm4, FileName, BR[i],Sex[j])
    
  }
  
  
}