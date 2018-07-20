plot2<-function(df) {
    plot(df$fixed2,df$Global_active_power,type="l",xlab="",ylab="Global Active Power (Killowatts)") 
}
savePlot2<-function(df) {
    png("plot2.png")
    plot2(df)
    dev.off()
}