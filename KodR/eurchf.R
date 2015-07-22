library(xts)
library(lubridate)
library(magrittr)
library(TTR)
library(Cairo)
data = read.csv("eurchf_d.csv")

date = data$Data %>% ymd
close = data[,5]


close = xts(close, order.by = date)
close = close["2014-10/2015-03"]
rets = (log(close) %>% diff)*100


CairoPDF(file = "EURCHF.pdf",  width = 9, height = 6)
plot(index(rets),rets, main = "EURCHF", type = "p", pch = 19, xaxt = "n")

out = rets[rets< -15]

points(index(out), as.numeric(out), col = "red", cex = 1.5, pch = 19)
scale = pretty(index(rets))
scale = sort(c("2015-01-15", as.character(scale)))

axis(1, scale %>% ymd, scale)

dev.off()

file.copy("EURCHF.pdf", "../wykresy/EURCHF.pdf",overwrite = TRUE)

rets["/2015-01-14"] %>% na.omit %>% range
rets["2015-01-16/"] %>% na.omit %>% range
