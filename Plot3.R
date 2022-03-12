library(ggplot2)

# reading data

nei<-readRDS('exdata-data-NEI_data/summarySCC_PM25.rds')
scc<-readRDS('exdata-data-NEI_data/Source_Classification_Code.rds')

# subsetting by fips

Baltimore<-nei[nei$fips=='24510',]

# sorting data by source types ang getting list of length 4

Baltimore1<-cbind(Baltimore[,4:6])
Baltimore2<-dplyr::group_by(Baltimore1, type, year)
Baltimore3<-dplyr::summarize_all(Baltimore2, sum)

# plotting via ggplot2

g<-ggplot(Baltimore3, aes(year, Emissions,  colour = type)) + geom_line()+
    scale_x_continuous(labels = c('1999','2002','2005','2008'),
                       breaks = c(1999,2002,2005,2008)) +
    ggtitle(label="Baltimore PM25")

ggsave(plot=g, filename="Plot3.png", width=4, height=4)

