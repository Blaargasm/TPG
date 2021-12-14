rm(list=ls())

#import libraries, set seed
library(ggplot2)
library(qcc)
set.seed(1029)

#read in data, xform 'Avg_Load' to time series data
edata = read.csv(file = 'Support/MonthlyData.csv')
ndata = subset(edata, select = -c(Date))
edata$Date = ts(edata$Date, start = 2016, frequency = 12)
edata$Avg_Load = as.numeric(edata$Avg_Load)

#Plot average monthly load
tdata = ts(ndata, start = 2016, frequency = 12)
print(tdata)
plot(tdata)

write.csv(tdata,"Support/tData.csv", row.names = FALSE)

#Triple exponential smoothing with additive seasonality
#low alpha and beta values indicate no overall trend in the data
esa = HoltWinters(x = tdata)
esa


#triple exponential smoothing with multiplicative seasonality
#low alpha and beta values indicate no overall trend in the data
esm = HoltWinters(x = tdata, seasonal = 'multiplicative')
esm

#isolate seasonal factors for each data point in a matrix
emat = esm$fitted[,4]
print(emat)
plot(emat, type='l')
