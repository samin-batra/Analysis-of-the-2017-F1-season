source('ergastR-core.R')
races = racesData.df(2017)
num_races = nrow(races)
drivers = driversData.df(2017)
drivers = drivers[,"driverId"]
#delta = 0
pos_diff = data.frame(race = character(),churn = numeric())
for(i in 1:19){
  delta = 0
  #winner = raceWinner(2017,i)
  #print(winner)
  results = resultsData.df(2017,i)
  num_drivers = nrow(results)
  #print(results)
  race = races[races$round==i,"circuitId"]
  for(j in 1:length(as.character(drivers))){
    driver_id = as.character(drivers[j])
    print(driver_id)
    res_1 = results[grepl("Finished",results$status),]
    res_2 = results[grepl("Lap",results$status),]
    results = rbind(res_1,res_2) 
    res = results[results$driverId==driver_id,c('pos','grid')]
    if(nrow(res)!=0)  {
      print(delta)
      delta = delta + abs(res$pos-res$grid)
      print(delta)
    }
  }
  churn = delta/num_drivers
  temp = data.frame(race,churn)
  pos_diff<-rbind(pos_diff,temp)
  
}
pos_diff
g<-ggplot(pos_diff,aes(x=race,y=churn,group=1))
g<-g+geom_line()
g+theme_classic(base_size=11,base_family = "")
