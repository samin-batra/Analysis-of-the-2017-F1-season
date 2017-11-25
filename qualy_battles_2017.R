source('ergastR-core.R')
constructors = constructorStandings.df(2017)
constructors = constructors[,c('constructorId')]
qualibattles = data.frame(constructorId=character(),driverId=character(),advantage=numeric())
temp = data.frame(constructorId=character(),driverId=character(),advantage=numeric())
for(i in constructors){
  quali_results = qualiResults.df(2017,constructorRef = i)
  faceoff = dcast(quali_results[,c('code','position','round')],round~code,value.var = 'position')
  #print("Faceoff is")
  #print(faceoff)
  constructorId=c(i)
  
  for(j in 2:ncol(faceoff)){
    driverId=c(names(faceoff)[j])  
    advantage = sum((j-1)==apply(faceoff[,-1],1,which.min))
    temp_1 = data.frame(constructorId,driverId,advantage)
    qualibattles = rbind(qualibattles,temp_1)
  }
}
g = ggplot(qualibattles,aes(x=constructorId,group=driverId,y=advantage))
g = g+geom_bar(stat="identity",position="dodge",width=0.9)  
g = g+geom_text(aes(y=advantage+0.2,label=driverId),position=position_dodge(width=0.9),size=2)
