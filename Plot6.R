library(ggplot2)

# reading data

nei<-readRDS('exdata-data-NEI_data/summarySCC_PM25.rds')
scc<-readRDS('exdata-data-NEI_data/Source_Classification_Code.rds')

# formating data

LaBaltimore<-nei[nei$fips=='24510' | nei$fips=='06037', ]
LaBaltimoremotor<-LaBaltimore[LaBaltimore$type == "ON-ROAD", c(1,4,6)]

# grouping data

LaBaltimoremotor$fips<-as.numeric(LaBaltimoremotor$fips)
LaBaltimoremotor<-dplyr::group_by(LaBaltimoremotor, fips, year)
LaBaltimoremotor$fips<-as.factor(LaBaltimoremotor$fips)
LaBaltimoremotor<-dplyr::summarize_all(LaBaltimoremotor, sum)

# plotting via ggplot2

g<-ggplot(LaBaltimoremotor, aes(year, Emissions, colour = fips)) + geom_line()+
    scale_x_continuous(labels = c('1999','2002','2005','2008'),
                       breaks = c(1999,2002,2005,2008)) +
    ggtitle(label="Motor Vehicle Emissions: Los-Angeles vs Baltimore") +
    geom_point()

ggsave(plot=g, filename="Plot6.png", width=6, height=6)

