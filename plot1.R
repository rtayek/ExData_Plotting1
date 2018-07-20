plot1<-function(df) {
    hist(df$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (Killowatts)") 
}
savePlot1<-function(df) {
    # make sure that width of 480 pixels and a height of 480 pixels.
    # looks like that is the default
    png("plot1.png")
    plot1(df)
    dev.off()
}
