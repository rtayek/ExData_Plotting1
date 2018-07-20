plot3<-function(df) {
    plot(df$fixed2,df$Sub_metering_1,type="l",xlab="",ylab="Energy sub Metering") 
    lines(df$fixed2,df$Sub_metering_2,col="red")
    lines(df$fixed2,df$Sub_metering_3,col="blue")
    legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1,cex=0.8)
}
savePlot3<-function(df) {
    png("plot3.png")
    plot3(df)
    dev.off()
}