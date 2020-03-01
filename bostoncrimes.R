#top 10 offense code group
crime <- crimetest %>% group_by(OFFENSE_CODE_GROUP) %>% summarise(count=n()) %>% arrange(desc(count))
crime <- crime[1:10,]
ggplot(crime[1:10,]) + geom_col(aes(x=OFFENSE_CODE_GROUP,y=count,fill=OFFENSE_CODE_GROUP))+coord_flip()+labs(title="Count of offense code group")



#hour polar coord
crimetest %>% ggplot() + geom_bar(aes(x=HOUR, fill=factor(HOUR)))+coord_polar()+labs(title="Crime frequency by hour")



#year plot
crimetest %>% filter(OFFENSE_CODE_GROUP=="Motor Vehicle Accident Response") %>% group_by(YEAR) %>% summarise(count=n(),na.rm=TRUE) %>% ggplot() + geom_col(aes(x=YEAR, y=count, fill=factor(YEAR)))+labs(title="Count of motor vehicle accidents each year")



#top 10 district with most frequent crime
crimedistrict <- crimetest %>%  filter(DISTRICT !="External") %>% group_by(DISTRICT) %>% summarise(count=n(),na.rm=TRUE) %>% arrange(desc(count))
crimedistrict <- crimedistrict [1:10,]
crimedistrict  %>% ggplot() + geom_col(aes(x=DISTRICT, y=count, fill=DISTRICT))+labs(title="top 10 district with most crimes")



#how to get Google maps

if(!requireNamespace("devtools")) install.packages("devtools")
devtools::install_github("dkahle/ggmap")
library("ggmap")
ggmap::register_google(key = "AIzaSyBBxmhUSNJxZ26EJ7avY6II6zCBHd3kHJE")

devtools::session_info()
datacrime <- crimetest %>%  filter(DISTRICT !="External")

p <- qmap("Boston , BOS",zoom = 12)  + geom_point(data = datacrime, mapping=aes(x= Long ,y= Lat, color=DISTRICT)) + coord_map()
print(p)