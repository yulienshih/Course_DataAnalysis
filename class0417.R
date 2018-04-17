#1. 在iris資料集中，iris$Sepal.Length的平均值與中位數分別是?
mean(iris$Sepal.Length)
sd(iris$Sepal.Length)
library(dplyr)
summarise(iris,
          mean(iris$Sepal.Length),
          sd(iris$Sepal.Length))
iris%>%
  summarise_if(is.numeric,mean)  ##可看到所有欄位的平均

iris%>%
  summarise_if(is.numeric,median)  ##可看到所有欄位的中位數


#2. 在mtcars資料集中，各汽缸數cyl與自/手排車的關係可用列聯表的方式呈現，並可計算自/手排車的
#汽缸數百分比，可輕鬆看出其差異，請用R計算自/手排車中，各汽缸數所占百分比。
#0是手排、1是自排
mytable<-table(mtcars$cyl,mtcars$am)
prop.table(mytable,margin = 2)

#3. 在dplyr套件中，幫row和column做子集的函數是?
# 1. group_by() 可以選擇用什麼欄位作分組依據
# 2. select()  針對column做子集
# 3. summarise() 計算統計值
# 4. filter() 針對row做子集

#4. 試著取出NBA上個球季(“16-17”)的球員資料，請試著新增一個欄位”命中率”，並記得轉換成百分比以及四捨五入到小數點第二位，請問最高命中率的球員姓名、隊伍、守備位置以及出場數為? (取前十名，用%>%)
library(SportsAnalytics)
NBA1617<-fetch_NBAPlayerStatistics("16-17")
NBA1617%>%
  mutate(rate = round(FieldGoalsMade/FieldGoalsAttempted*100),digits= 2)%>%
  select(Name:GamesPlayed,rate)%>%
  arrange(desc(rate))%>%
  head(10)

NBA1617%>%filter(Assists>100&Steals>20&Team=="SAN")%>%
  arrange(desc(GamesPlayed))

##3. 9 Patty Mills
### 5. 試著取出NBA上個球季(“16-17”)的球員資料，請取出各隊得分最高的球員資料。(用%>%)
# ** 提示: slice()**
library(SportsAnalytics)
NBA1617<-fetch_NBAPlayerStatistics("16-17")
NBA1617%>%
arrange(desc(TotalPoints))%>%
  group_by(Team)%>%slice(1)

### 6. 在探索式資料分析中，若要計算airquality資料集裡面各月的臭氧Ozone濃度、 Wind 風速、 Temp 氣溫的平均值和標準差，可以用dplyr套件以及mean()函數和sd()函數做分組計算，請試著用一段程式碼完成平均值標準差計算，並輸出一個資料框(請取欄位名稱)。
#na.rm=T 可以去除NA值
airquality%>%
  summarise(is.numeric,median) 
