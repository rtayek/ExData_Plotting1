rm(list=ls())
require(RUnit)
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFileName<-"downloaded.zip"
filename<-"household_power_consumption.txt"
startDate<-as.POSIXlt("2007-02-01")
endDate<-as.POSIXlt("2007-02-03")
fixTime<-function(date,time) { # replaces the date in time with the paramer date.
    as.POSIXlt(sprintf("%s %s",date,time),format="%d/%m/%Y %H:%M:%S")
}
fixTime2<-function(month,day,year,hours,minutes,seconds) {
    print("in function fixTime")
    print(year)
    date<-paste0(c(day,month,year),collapse="/")
    time<-paste0(c(hours,minutes,seconds),collapse=":")
    fixed<-fixTime(date,time)
}
test.fixTime<-function() {
    month<-"12"
    day<-"16"
    year<-"2006"
    hours<-"17"
    minutes<-"24"
    seconds<-"00"
    print(year)
    fixTime2(month,day,year,hours,minutes,seconds)
    #fixed<-fixTime(date,time)
    checkEquals(as.numeric(month),fixed$mon+1)
    checkEquals(as.numeric(day),fixed$mday)
    checkEquals(as.numeric(year),fixed$year+1900)
    checkEquals(as.numeric(hours),fixed$hour)
    checkEquals(as.numeric(minutes),fixed$min)
    checkEquals(as.numeric(seconds),fixed$sec)
}
test.fixTimeOnDataFrameColumn<-function() {
    c1<-c("16/12/2006","16/12/2006")
    c2<-c("17:24:00","17:25:00")
    df<-data.frame(c1,c2,stringsAsFactors=F)
    df$fixed<-fixTime(df[,1],df[,2])
    str(df)
    return(df)
}
readLargeFile<-function(nrows=70000) {    # we only want: 2007-02-01 and 2007-02-02
    print("reading large file")
    df0<-read.csv(filename,sep=";",nrows=nrows,stringsAsFactors=F)
    df0$fixed<-fixTime(df0[,1],df0[,2]) # fix the time
    df1<-subset(df0,startDate<=fixed&fixed<endDate)
    rm(df0) # free up some core
    return(df1)
}
maybeReadLargeFile<-function() {
    if(!file.exists("small.csv")) {
        if(!file.exists(filename)) {
            if(!file.exists(zipFileName)) {
                print("downloading zip file.")
                system.time(download.file(url,zipFileName))
            }
            print("unzipping zip file.")
            system.time(unzip ("downloaded.zip", exdir = "."))
            print("after unzipping zip file.")
        }
        system.time(df<-readLargeFile(70000))
        if(dim(df)[1]!=2880) {
            print("incorrect amount of data!")
            return
        }
        print("writing small file.")
        system.time(write.csv(df,file="small.csv"))
        print("after writing small file.")
        rm(df)
    }
}
run<-function() { 
    maybeReadLargeFile()
    df<-read.csv("small.csv",stringsAsFactors=F)
    print("after reading small file.")
    df$fixed2<-as.POSIXlt(df$fixed)
    print("after adding fixed2.")
    return(df)   
}
df<-run()
source("plot1.R")
savePlot1(df)
source("plot2.R")
savePlot2(df)
source("plot3.R")
savePlot3(df)
source("plot4.R")
savePlot4(df)

