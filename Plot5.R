# reading data

nei<-readRDS('exdata-data-NEI_data/summarySCC_PM25.rds')
scc<-readRDS('exdata-data-NEI_data/Source_Classification_Code.rds')

# Baltimore data

Baltimore<- Baltimore<-nei[nei$fips==24510,]

# getting motor vehicle codes

motorvehicle<-grep("motor vehicle", scc$Short.Name, ignore.case = T)
motorvehiclestrings<-scc$Short.Name[motorvehicle]
motorvehiclecodes<-scc[scc$Short.Name %in% motorvehiclestrings, 1]

# formating Baltimore set

Baltimorevehicle<-Baltimore[Baltimore$SCC %in% motorvehiclecodes , 4:6]

# resulted in two rows: too small to be true?

# filtering data by fips and onroad criterias

Baltimoremotor<- Baltimore<-nei[nei$fips=='24510' & nei$type == 'ON-ROAD', 4:6]

# calculating yearly emissions 

emissions<-tapply(Baltimoremotor$Emissions, Baltimoremotor$year, sum)

# plotting

png(file="Plot5.png", width=480, height=480)
plot(names(emissions), emissions, xlab="years", xaxt="n", type="l")
axis(1, at = seq(1999, 2008, by = 3))

# graphical options

points(names(emissions), emissions,pch=20)
title(main="Baltimore Motor Vehicle (ON-ROAD) Emissions")

dev.off()



