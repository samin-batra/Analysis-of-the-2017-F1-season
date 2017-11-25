source('ergastR-core.R')
constructors = constructorStandings.df(2017,1)
constructors = constructors[constructors$constructorId,]
races = racesData.df(2017)
temp<-data.frame(constructorId = character(),maxtime = numeric(),race = character())
for(j in 1:nrow(constructors)){
  for(i in 1:19){
    quali = qualiResults.df(2017,i)
    quali = quali %>% group_by(constructorId) %>% summarize(maxtime = min(Q1_time))
    quali = quali[quali$constructorId==as.character(constructors$constructorId[j]),]
    
    quali$race = races[races$round==i,"circuitId"]
    temp = rbind(temp,quali)
    #temp
  }
}
g<-ggplot(temp,aes(x=race,y=maxtime,group=constructorId,colour=constructorId))
g+geom_line()
