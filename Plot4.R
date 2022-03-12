# reading data

nei<-readRDS('exdata-data-NEI_data/summarySCC_PM25.rds')
scc<-readRDS('exdata-data-NEI_data/Source_Classification_Code.rds')

# matching all 'comb and 'coal via grepl

comb<-grep("comb", scc$Short.Name, ignore.case = T)
coal<-grep("coal", scc$Short.Name, ignore.case = T)
combcoal<-intersect(scc$Short.Name[comb], scc$Short.Name[coal])

# gaining proper codes

codes<-scc[scc$Short.Name %in% combcoal, 1]

# addressing the data

neicombcoal<-nei[nei$SCC %in% codes, 4:6]

# calculating yearly emissions

emissions<-tapply(neicombcoal$Emissions, neicombcoal$year, sum)

# plotting

png(file="Plot4.png", width=480, height=480)
plot(names(emissions), emissions, xlab="years", xaxt="n", type="l")
axis(1, at = seq(1999, 2008, by = 3))

# graphical options

points(names(emissions), emissions,pch=20)
title(main="US Coal Combustion Emissions")

dev.off()

