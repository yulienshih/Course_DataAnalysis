Untitled
================

Import Data

    ## 
    ## Attaching package: 'readr'

    ## The following object is masked from 'package:curl':
    ## 
    ##     parse_date

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

    ## Parsed with column specification:
    ## cols(
    ##   洲別 = col_character(),
    ##   國別 = col_character(),
    ##   `學位生-正式修讀學位外國生` = col_integer(),
    ##   `學位生-僑生(含港澳)` = col_integer(),
    ##   `學位生-正式修讀學位陸生` = col_integer(),
    ##   `非學位生-外國交換生` = col_integer(),
    ##   `非學位生-外國短期研習及個人選讀` = col_integer(),
    ##   `非學位生-大專附設華語文中心學生` = col_integer(),
    ##   `非學位生-大陸研修生` = col_integer(),
    ##   `非學位生-海青班` = col_integer(),
    ##   境外專班 = col_integer()
    ## )
    ## Parsed with column specification:
    ## cols(
    ##   洲別 = col_character(),
    ##   國別 = col_character(),
    ##   `學位生-正式修讀學位外國生` = col_integer(),
    ##   `學位生-僑生(含港澳)` = col_integer(),
    ##   `學位生-正式修讀學位陸生` = col_integer(),
    ##   `非學位生-外國交換生` = col_integer(),
    ##   `非學位生-外國短期研習及個人選讀` = col_integer(),
    ##   `非學位生-大專附設華語文中心學生` = col_integer(),
    ##   `非學位生-大陸研修生` = col_integer(),
    ##   `非學位生-海青班` = col_integer(),
    ##   境外專班 = col_integer()
    ## )

    ## Parsed with column specification:
    ## cols(
    ##   洲別 = col_character(),
    ##   國別 = col_character(),
    ##   學位生_正式修讀學位外國生 = col_integer(),
    ##   `學位生_僑生(含港澳)` = col_integer(),
    ##   學位生_正式修讀學位陸生 = col_integer(),
    ##   非學位生_外國交換生 = col_integer(),
    ##   非學位生_外國短期研習及個人選讀 = col_integer(),
    ##   非學位生_大專附設華語文中心學生 = col_integer(),
    ##   非學位生_大陸研修生 = col_integer(),
    ##   非學位生_海青班 = col_integer(),
    ##   境外專班 = col_integer()
    ## )
    ## Parsed with column specification:
    ## cols(
    ##   洲別 = col_character(),
    ##   國別 = col_character(),
    ##   學位生_正式修讀學位外國生 = col_integer(),
    ##   `學位生_僑生(含港澳)` = col_integer(),
    ##   學位生_正式修讀學位陸生 = col_integer(),
    ##   非學位生_外國交換生 = col_integer(),
    ##   非學位生_外國短期研習及個人選讀 = col_integer(),
    ##   非學位生_大專附設華語文中心學生 = col_integer(),
    ##   非學位生_大陸研修生 = col_integer(),
    ##   非學位生_海青班 = col_integer(),
    ##   境外專班 = col_integer()
    ## )

### 請問哪些國家來台灣唸書的學生最多呢？請取出前十名的國家與總人數，由大到小排序(5分)。

``` r
library(knitr)
ForeignStudent_count<-ForeignStudent%>%
  group_by(`國別`)%>%
  summarise(`來台灣唸書的學生數`=sum(Total))%>%
  arrange(desc(`來台灣唸書的學生數`))
```

    ## Warning: package 'bindrcpp' was built under R version 3.4.4

``` r
kable(head(ForeignStudent_count,10))
```

| 國別     | 來台灣唸書的學生數 |
|:---------|:------------------:|
| 中國大陸 |       152524       |
| 馬來西亞 |        62031       |
| 香港     |        31940       |
| 日本     |        28200       |
| 越南     |        21670       |
| 澳門     |        20302       |
| 印尼     |        19620       |
| 南韓     |        16948       |
| 美國     |        14846       |
| 泰國     |        7035        |

Import Data

    ## Parsed with column specification:
    ## cols(
    ##   學校類型 = col_character(),
    ##   學校代碼 = col_character(),
    ##   學校名稱 = col_character(),
    ##   `學位生-正式修讀學位外國生` = col_integer(),
    ##   `學位生-僑生(含港澳)` = col_integer(),
    ##   `學位生-正式修讀學位陸生` = col_integer(),
    ##   `非學位生-外國交換生` = col_integer(),
    ##   `非學位生-外國短期研習及個人選讀` = col_integer(),
    ##   `非學位生-大專附設華語文中心學生` = col_integer(),
    ##   `非學位生-大陸研修生` = col_character(),
    ##   `非學位生-海青班` = col_integer(),
    ##   境外專班 = col_integer()
    ## )
    ## Parsed with column specification:
    ## cols(
    ##   學校類型 = col_character(),
    ##   學校代碼 = col_character(),
    ##   學校名稱 = col_character(),
    ##   `學位生-正式修讀學位外國生` = col_integer(),
    ##   `學位生-僑生(含港澳)` = col_integer(),
    ##   `學位生-正式修讀學位陸生` = col_integer(),
    ##   `非學位生-外國交換生` = col_integer(),
    ##   `非學位生-外國短期研習及個人選讀` = col_integer(),
    ##   `非學位生-大專附設華語文中心學生` = col_integer(),
    ##   `非學位生-大陸研修生` = col_character(),
    ##   `非學位生-海青班` = col_integer(),
    ##   境外專班 = col_integer()
    ## )

    ## Parsed with column specification:
    ## cols(
    ##   學校類型 = col_character(),
    ##   學校代碼 = col_character(),
    ##   學校名稱 = col_character(),
    ##   學位生_正式修讀學位外國生 = col_integer(),
    ##   `學位生_僑生(含港澳)` = col_integer(),
    ##   學位生_正式修讀學位陸生 = col_integer(),
    ##   非學位生_外國交換生 = col_integer(),
    ##   非學位生_外國短期研習及個人選讀 = col_integer(),
    ##   非學位生_大專附設華語文中心學生 = col_integer(),
    ##   非學位生_大陸研修生 = col_integer(),
    ##   非學位生_海青班 = col_integer(),
    ##   境外專班 = col_integer()
    ## )
    ## Parsed with column specification:
    ## cols(
    ##   學校類型 = col_character(),
    ##   學校代碼 = col_character(),
    ##   學校名稱 = col_character(),
    ##   學位生_正式修讀學位外國生 = col_integer(),
    ##   `學位生_僑生(含港澳)` = col_integer(),
    ##   學位生_正式修讀學位陸生 = col_integer(),
    ##   非學位生_外國交換生 = col_integer(),
    ##   非學位生_外國短期研習及個人選讀 = col_integer(),
    ##   非學位生_大專附設華語文中心學生 = col_integer(),
    ##   非學位生_大陸研修生 = col_integer(),
    ##   非學位生_海青班 = col_integer(),
    ##   境外專班 = col_integer()
    ## )

哪間大學的境外生最多呢？請取出前十名的大學與總人數，由大到小排序(5分)。

``` r
library(knitr)
ForeignStudentBySchool_count<-ForeignStudentBySchool%>%
  group_by(`學校名稱`)%>%
  summarise(`來台灣唸書的學生數`=sum(Total))%>%
  arrange(desc(`來台灣唸書的學生數`))

kable(head(ForeignStudentBySchool_count,13))
```

| 學校名稱         | 來台灣唸書的學生數 |
|:-----------------|:------------------:|
| 無法區分校別     |        92586       |
| 國立臺灣師範大學 |        22113       |
| 國立臺灣大學     |        18199       |
| 中國文化大學     |        16074       |
| 銘傳大學         |        16057       |
| 淡江大學         |        13887       |
| 國立政治大學     |        11626       |
| 國立成功大學     |        10982       |
| 輔仁大學         |        9499        |
| 逢甲大學         |        9474        |
| 中原大學         |        7662        |
| 義守大學         |        7068        |
| 國立交通大學     |        6926        |

用bar chart呈現各個國家(全部)來台灣唸書的學生人數(10分)。

``` r
ForeignStudent_count_tidy<-group_by(ForeignStudent_count, `國別`) %>%
  tally(`來台灣唸書的學生數`, sort = TRUE) %>%
  group_by(`國別` = factor(c(`國別`[1:98], rep("Other", n() - 98)),
                            levels = c(`國別`[1:98], "Other"))) %>%
  tally(n)%>%
  arrange(desc(`nn`))

library(ggplot2)

ggplot()+geom_bar(data=ForeignStudent_count_tidy[1:30,],
                  aes(x=reorder(`國別`, -`nn`),y=`nn`),
                  stat = "identity") 
```

![](mtcars_v1_tidy_data_files/figure-markdown_github/unnamed-chunk-5-1.png)

用面量圖呈現各個國家來台灣唸書的學生人數，人數越多顏色越深(10分)

``` r
colnames(ForeignStudent_count_tidy)<-c('Taiwan','count')
country_table<-read_csv('CountriesComparisionTable.csv')
```

    ## Parsed with column specification:
    ## cols(
    ##   ISO3 = col_character(),
    ##   English = col_character(),
    ##   Taiwan = col_character()
    ## )

``` r
ForeignStudent_count_tidy<-merge(ForeignStudent_count_tidy,country_table,by ='Taiwan')
df<-ForeignStudent_count_tidy[,c(4,2)]
colnames(df)<-c('region','value')
library(dplyr)
df<-filter(df,region!='Unmatch')
#df$ggplot_scale = scale_fill_brewer(name="StudentAmount", palette=2)

#c$render()
```

<hr>
台灣大專院校的學生最喜歡去哪些國家進修交流呢？請取出前十名的國家與總人數，由大到小排序(5分)。

``` r
library(data.table)
```

    ## 
    ## Attaching package: 'data.table'

    ## The following objects are masked from 'package:dplyr':
    ## 
    ##     between, first, last

``` r
StudyAbroad<-fread('Student_RPT_07.csv')
StudyAbroad$University<-iconv(StudyAbroad$University,'big5','utf8')
StudyAbroad$Country<-iconv(StudyAbroad$Country,'big5','utf8')
StudyAbroad$Country<-gsub('大陸地區','中國大陸',StudyAbroad$Country)
StudyAbroad$Country<-gsub('德意志聯邦共和國','德國',StudyAbroad$Country)
StudyAbroad[grepl('南韓',Country),]$Country<-'南韓'
StudyAbroad[grepl('泰',Country),]$Country<-'泰國'
StudyAbroad$Country<-gsub('共和國|王國|社會主義|和平之國','',StudyAbroad$Country)
StudyAbroad$Country<-gsub('蒙古國','蒙古',StudyAbroad$Country)
StudyAbroad$Country<-gsub('印度尼西亞','印尼',StudyAbroad$Country)
StudyAbroad$Country<-gsub('俄羅斯聯邦','俄羅斯',StudyAbroad$Country)
StudyAbroadbyCountry<-StudyAbroad%>%
 filter(Year%in%c(103,104))%>%
  group_by(Country)%>%
  summarise(CountSum = sum(Count))%>%
  arrange(desc(CountSum))
kable(head(StudyAbroadbyCountry,10))
```

| Country  |  CountSum|
|:---------|---------:|
| 中國大陸 |      9891|
| 日本     |      7142|
| 美國     |      4427|
| 南韓     |      2565|
| 德國     |      1764|
| 法國     |      1258|
| 英國     |       742|
| 西班牙   |       721|
| 加拿大   |       689|
| 新加坡   |       673|

又哪間大學的出國交流學生數最多呢？請取出前十名的大學與總人數，由大到小排序(5分)。

``` r
StudyAbroadbySchool<-StudyAbroad%>%
  filter(Year%in%c(103,104))%>%
  group_by(University)%>%
  summarise(CountSum = sum(Count))%>%
  arrange(desc(CountSum))
knitr::kable(head(StudyAbroadbySchool,10))
```

| University   |  CountSum|
|:-------------|---------:|
| 國立臺灣大學 |      2224|
| 淡江大學     |      2038|
| 國立政治大學 |      1876|
| 逢甲大學     |      1346|
| 元智大學     |      1106|
| 國立臺北大學 |       956|
| 國立交通大學 |       951|
| 東海大學     |       931|
| 東吳大學     |       873|
| 國立成功大學 |       846|

用bar chart呈現台灣大專院校(全部)的學生去各國家進修交流人數(10分)。

``` r
ggplot()+
  geom_bar(data=StudyAbroadbyCountry[1:30,],
                  aes(x=reorder(`Country`, -`CountSum`),y=`CountSum`),
                  stat = "identity") 
```

![](mtcars_v1_tidy_data_files/figure-markdown_github/unnamed-chunk-9-1.png)

用面量圖呈現台灣大專院校的學生去各國家進修交流人數，人數越多顏色越深(10分)。

``` r
colnames(StudyAbroadbyCountry)<-c('Taiwan','count')
df2<-merge(StudyAbroadbyCountry,country_table,by ='Taiwan')
df2<-df2[,c(4,2)]
colnames(df2)<-c('region','value')
library(dplyr)
df2<-filter(df2,region!='Unmatch')
#df$ggplot_scale = scale_fill_brewer(name="StudentAmount", palette=2)
#c  = CountryChoropleth$new(df2)
#c$render()
```

台灣學生最喜歡去哪些國家留學呢？請取出前十名的國家與總人數，由大到小排序(5分)。

``` r
NumbersOfStudyingAbroad<-read_csv('NumbersOfStudyingAbroad.csv')
```

    ## Warning: Missing column names filled in: 'X4' [4], 'X5' [5], 'X6' [6]

    ## Parsed with column specification:
    ## cols(
    ##   洲別 = col_character(),
    ##   國別 = col_character(),
    ##   總人數 = col_number(),
    ##   X4 = col_character(),
    ##   X5 = col_character(),
    ##   X6 = col_character()
    ## )

``` r
kable(NumbersOfStudyingAbroad[,c(2:3)]%>%
  arrange(desc(總人數))%>%
  head(10))
```

| 國別     | 總人數 |
|:---------|:------:|
| 美國     |  21127 |
| 澳大利亞 |  13582 |
| 日本     |  8444  |
| 加拿大   |  4827  |
| 英國     |  3815  |
| 德國     |  1488  |
| 紐西蘭   |  1106  |
| 波蘭     |   561  |
| 馬來西亞 |   502  |
| 奧地利   |   419  |

用面量圖呈現台灣學生去各國家留學人數，人數越多顏色越深(10分)。

``` r
names(NumbersOfStudyingAbroad)[2:3]<-c('Taiwan','count')
df3<-merge(NumbersOfStudyingAbroad[,c(2:3)],country_table,by ='Taiwan')
df3<-df3[,c(4,2)]
colnames(df3)<-c('region','value')
library(dplyr)
df3<-filter(df3,region!='Unmatch')
#df$ggplot_scale = scale_fill_brewer(name="StudentAmount", palette=2)
#c  = CountryChoropleth$new(df3)
```

來台讀書與離台讀書的來源國與留學國趨勢是否相同(5分)？

``` r
#df3: numbers of studying abroad
studyingAbroad<-df3%>%
  arrange(desc(value))%>%
  head(20)
kable(studyingAbroad)
```

| region                   |  value|
|:-------------------------|------:|
| united states of america |  21127|
| australia                |  13582|
| japan                    |   8444|
| canada                   |   4827|
| united kingdom           |   3815|
| germany                  |   1488|
| new zealand              |   1106|
| poland                   |    561|
| malaysia                 |    502|
| austria                  |    419|
| netherlands              |    400|
| vietnam                  |    364|
| north korea              |    265|
| thailand                 |    217|
| indonesia                |    210|
| russia                   |    181|
| belgium                  |    120|
| sweden                   |    113|
| philippines              |     64|
| finland                  |     37|

``` r
#df1: numbers of sources
sources<-df%>%
  arrange(desc(value))%>%
  head(20)
kable(sources)
```

| region                   |   value|
|:-------------------------|-------:|
| china                    |  152524|
| malaysia                 |   62031|
| japan                    |   28200|
| vietnam                  |   21670|
| indonesia                |   19620|
| north korea              |   16948|
| united states of america |   14846|
| thailand                 |    7035|
| france                   |    6558|
| india                    |    4845|
| germany                  |    4535|
| mongolia                 |    3843|
| Singapore                |    2928|
| canada                   |    2742|
| philippines              |    2708|
| myanmar                  |    2522|
| australia                |    1758|
| united kingdom           |    1713|
| russia                   |    1593|
| netherlands              |    1512|

``` r
colnames(sources)[2]<-'sourcesValue'

newTable<-merge(studyingAbroad,sources,by = 'region',all = T)
```
