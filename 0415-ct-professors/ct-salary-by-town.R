library(plyr)
salary <- read.csv("ct-professor-salaries.csv")

city_list<- data.frame(table(salary$City))
colnames(city_list)<- c("City","Number.of.Colleges")

city_average <- ddply(salary, "City", summarise, 
                      Colleges = count(City),
                      Average = mean(Average.All.Pay), 
                      Professor=mean(Average.Professor),
                      Assoc.Prof=mean(Associate.Professor),
                      Asst.Prof=mean(Assistant.Professor),
                      Lecter=mean(Lecturer))

city_average <- city_average[order(city_average$Average, decreasing = TRUE),]

city_average <- join(city_average, city_list, by ="City")

write.csv(city_average, "city_average.csv")
