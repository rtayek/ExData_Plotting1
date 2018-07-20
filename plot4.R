plot4<-function(df) {
    par(mfrow=c(2, 2))
    plot(df$fixed2,df$Global_active_power,type="l",xlab="",ylab="Global Active Power (Killowatts)") 
    plot(df$fixed2,df$Voltage,type="l",xlab="datetime",ylab="Voltage") 
    plot(df$fixed2,df$Sub_metering_1,type="l",xlab="",ylab="Energy sub Metering") 
    lines(df$fixed2,df$Sub_metering_2,col="red")
    lines(df$fixed2,df$Sub_metering_3,col="blue")
    legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1,cex=0.8)
    plot(df$fixed2,df$Global_reactive_power,type="l",xlab="datetime") 
}
savePlot4<-function(df) {
    png("plot4.png")
    plot4(df)
    dev.off()
}