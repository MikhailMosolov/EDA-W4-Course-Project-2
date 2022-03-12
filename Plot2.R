# reading data

nei<-readRDS('exdata-data-NEI_data/summarySCC_PM25.rds')
scc<-readRDS('exdata-data-NEI_data/Source_Classification_Code.rds')

# subsetting by fips

Baltimore<-nei[nei$fips=='24510',]

# calculation total pollution in Baltimore

totalPollution<-tapply(Baltimore$Emissions, Baltimore$year, sum)

# building 2nd plot

png(file="Plot2.png", width=480, height=480)
plot(names(totalPollution), totalPollution, xlab="years", xaxt="n", type="l")
axis(1, at = seq(1999, 2008, by = 3))

# graphical options

points(names(totalPollution), totalPollution,pch=20)
title(main="Baltimore PM25 Pollution")

dev.off()
