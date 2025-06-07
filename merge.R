rm(list=ls())
fp = read.csv("/Users/suchibratapatra/Desktop/Copy/_fp_orginal.csv")[-c(1,2)]
ktrans = read.csv("/Users/suchibratapatra/Desktop/Copy/_ktrans_original.csv")[-c(1,2)]
tau = read.csv("/Users/suchibratapatra/Desktop/Copy/_tau_original.csv")[-c(1,2)]
ve = read.csv("/Users/suchibratapatra/Desktop/Copy/_ve_orginal.csv")[-c(1,2)]
vp = read.csv("/Users/suchibratapatra/Desktop/Copy/_vp_original.csv")[-c(1,2)]
dim(fp) ; head(names(fp),5)
dim(ktrans) ; head(names(ktrans),5)
dim(tau) ; head(names(tau),5)
dim(ve); head(names(ve),5)
dim(vp); head(names(vp),5)


# Finding Out Which Obs is Missing
missing_obs = which(is.na(match(fp[,1],tau[,1])))
tau[,missing_obs] = 
  
## Imputation_of_missing_values


colnames(fp) = paste("fp" ,colnames(fp),sep="_")
colnames(ktrans) = paste("ktrans" ,colnames(ktrans),sep="_")
colnames(tau) = paste("tau" ,colnames(tau),sep="_")
colnames(ve) = paste("ve" ,colnames(ve),sep="_")
colnames(vp) = paste("vp" ,colnames(vp),sep="_")

head(names(fp),5)
head(names(ktrans),5)
head(names(tau),5)
head(names(ve),5)
head(names(vp),5)

dfs = list(fp, ktrans, tau, ve, vp)

min_rows = min(sapply(dfs, nrow))
dfs = lapply(dfs, function(df) df[1:min_rows, ])
interleaved = as.data.frame(do.call(cbind, unlist(lapply(1:ncol(fp), function(i) lapply(dfs, function(df) df[[i]])), recursive = FALSE)))
colnames(interleaved) = unlist(lapply(1:ncol(fp), function(i) paste0(c("fp", "ktrans", "tau", "ve", "vp"), "_", i)))
dfs = list(fp, ktrans, tau, ve, vp)

# Truncating one Rows
min_rows = min(sapply(dfs, nrow))
dfs = lapply(dfs, function(df) df[1:min_rows, ])

# Merging the Data Frames
new_data_frame = do.call(cbind, unlist(lapply(1:ncol(fp), function(i) lapply(dfs, function(df) df[i])), recursive = FALSE))
new_data_frame = new_data_frame[-seq(1,10,1)]

