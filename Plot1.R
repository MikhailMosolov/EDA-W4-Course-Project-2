# reading data

nei<-readRDS('exdata-data-NEI_data/summarySCC_PM25.rds')
scc<-readRDS('exdata-data-NEI_data/Source_Classification_Code.rds')

# calculation total pollution

totalPollution<-tapply(nei$Emissions, nei$year, sum)

# building 1st plot

png(file="Plot1.png", width=480, height=480)
plot(names(totalPollution), totalPollution, xlab="years", xaxt="n", type="l")
axis(1, at = seq(1999, 2008, by = 3))

# graphical options

points(names(totalPollution), totalPollution,pch=20)
title(main="PM25 Pollution")

dev.off()
