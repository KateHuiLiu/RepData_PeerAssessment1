activityData <- read.csv("./repdata-data-activity/activity.csv")
totalStepsPerDay <- aggregate(activityData$steps, by=list(activityData$date), FUN=sum)
colnames(totalStepsPerDay) <- c("date", "totalSteps")
qplot(date, totalSteps, data = totalStepsPerDay, geom = "histogram", stat = "identity")

dailyActivity <- aggregate(activityData$steps, by=list(activityData$interval), FUN=mean, na.rm = TRUE)
colnames(dailyActivity) <- c("interval", "dailyAvgSteps")
head(dailyActivity)
plot(dailyActivity, type = "l")

missingActivityData<- activityData[is.na(activityData$steps),]
originalActivityData<- activityData[!is.na(activityData$steps),]
filledActivityData<- merge(missingActivityData, dailyActivity, by="interval" )
filledActivityData<- filledActivityData[,c(1,3,4)]
colnames(filledActivityData)<-c("interval","date","steps")
newActivityData <- rbind(filledActivityData, originalActivityData)
