source('ergastR-core.R')
races_2017 = racesData.df(2017)
races_2016 = racesData.df(2016)
races = merge(races_2017,races_2016,by="circuitId",sort = FALSE)
q_diff = data.frame(race = character(),difference = numeric())
for(i in 1:19){
  q_2017 = qualiResults.df(2017,i)
  if(i>=12){
    q_2016 = qualiResults.df(2016,i+1)
  }
  else{
    q_2016 = qualiResults.df(2016,i)
  }
  race = races[races$round.x==i,"circuitId"]
  difference = q_2016[q_2016$position==1,"Q3_time"]-q_2017[q_2017$position==1,"Q3_time"]
  temp = data.frame(race,difference)
  q_diff = rbind(q_diff,temp)
}
q_diff
g<-ggplot(q_diff,aes(x=race,y=difference,group=1))
g<-g+geom_line()
g<-g+theme_classic(base_size=11,base_family="")

