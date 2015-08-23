library(xts)
library(lubridate)
library(magrittr)
library(TTR)
library(Cairo)
data = read.csv("KodR/eurchf_d.csv")

date = data$Data %>% ymd
close = data[,5]


close = xts(close, order.by = date)
close = close["2014-10/2015-03"]
rets = (log(close) %>% diff)*100


CairoPDF(file = "wykresy/EURCHF.pdf",  width = 9, height = 6)
plot(index(rets),rets, main = "EURCHF", type = "p", pch = 19, xaxt = "n")

out = rets[rets< -15]

points(index(out), as.numeric(out), col = "red", cex = 1.5, pch = 19)
scale = pretty(index(rets))
scale = sort(c("2015-01-15", as.character(scale)))

axis(1, scale %>% ymd, scale)

dev.off()

#file.copy("EURCHF.pdf", "../wykresy/EURCHF.pdf",overwrite = TRUE)

rets["/2015-01-14"] %>% na.omit %>% range
rets["2015-01-16/"] %>% na.omit %>% range


set.seed(123)

par(mar = c(2.5,2.5,2,2))
x = rnorm(20)
x = cumsum(x)
library(Cairo)
CairoPDF(file = "wykresy/odst1.pdf",  width = 12, height = 8)
par(mar = c(2.5,2.5,2,2))
xx = x; xx[10] = xx[10]-5
cols = c(rep("blue",9), rep("red",1), rep("gray60",10))
plot(xx, ylab = "", col = cols, pch = 19, xlab = "", cex = 2)
legend("bottomright", c("Obserwacje przeszłe","Obserwacja bieżąca", "Obserwacje przyszłe"), col = c("blue","red","gray60"), lwd = 3)
dev.off()

CairoPDF(file = "wykresy/odst2.pdf",  width = 12, height = 8, pointsize = 16)
par(mar = c(2.5,2.5,2,2))
xx = x; xx[10:20] = xx[10:20]+6
cols = c(rep("blue",9), rep("red",1), rep("gray60",10))
plot(xx, ylab = "", col = cols, pch = 19, xlab = "", cex = 2)
legend("bottomright", c("Obserwacje przeszłe","Obserwacja bieżąca", "Obserwacje przyszłe"), col = c("blue","red","gray60"), lwd = 3)
dev.off()


