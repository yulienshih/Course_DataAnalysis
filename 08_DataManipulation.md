資料處理與清洗 課堂練習
================

### 問題

#### 爬DCard長庚大學版 (不用使用瀑布式爬蟲，爬第一頁就好)，取出文章標題、作者以及按愛心的人數，並做成一個資料框。請問按愛心的人數的欄位型態是? 請轉換為字串後寫回資料框中。<https://www.dcard.tw/f/cgu>VV

\*\* 提示: `rvest`套件爬蟲、`data.frame`製作資料框 \*\*

### 解答

``` r
library(rvest)
```

    ## Loading required package: xml2

``` r
DCardCGU<-"https://www.dcard.tw/f/cgu"
DCardContent<-read_html(DCardCGU)
post_title <- DCardContent %>% html_nodes(".PostEntry_unread_2U217") %>% html_text()
post_author<- DCardContent %>% html_nodes(".PostAuthor_root_3vAJf") %>% html_text()
post_like<- DCardContent %>% html_nodes(".Like_counter_1enlP") %>% html_text()

DCardCGU_posts <- 
  data.frame(title = post_title,
             author=post_author, 
             likeN=post_like, stringAsFactor = F)
class(DCardCGU_posts$post_like)
DCardCGU_posts$post_like<-as.numeric(DCardCGU_posts$post_like)

DCardCGU_posts
```

</hr>
### 問題

#### 請試著爬PTT科技工作版https://www.ptt.cc/bbs/Tech\_Job/index.html，一次爬十頁的文章標題後，請試著找出標題中包含”面試”字串的位置，並試著將包含”面試”字串的標題單獨選出來  VV

\*\* 提示: 上禮拜的詳解、標題存成向量就好、`grep()`或是`grepl()`、`[ ]`\*\*

### 解答

``` r
PPT_Job_title_total<-NULL
for (i in c(3020:3011)){
    PPT_Job_title<-
        read_html(paste0("https://www.ptt.cc/bbs/Tech_Job/index",i,".html"))%>%
        html_nodes(".title a")%>%
        html_text()
    PPT_Job_title_total<-c(PPT_Job_title_total,PPT_Job_title)
}
#找「面試」字串位置
grep("面試",PPT_Job_title_total)
```

    ##  [1]  12  41  74  80  81  88 103 113 135 145 160

``` r
#單獨選「面試」字串的標題
##用grep()
PPT_Job_title_total[grep("面試",PPT_Job_title_total)]
```

    ##  [1] "[心得] 我的面試之旅 (電子業採購)"       
    ##  [2] "[請益] 住豪宅的話面試的地址資料該填嗎？"
    ##  [3] "[面試] 欣銓品保輪班工程師"              
    ##  [4] "[請益] 聯陽半導體行政管理職面試疑問"    
    ##  [5] "[面試] 杜邦-品保/製程工程師"            
    ##  [6] "[請益] 華泰電子和光寶科技面試"          
    ##  [7] "[請益] 3/15 中科GG面試通知？"           
    ##  [8] "[請益] 微星 RD_EMC/EMI 工程師 邀請面試" 
    ##  [9] "[面試] 雷泰/村田/台達/Recruit(日商)"    
    ## [10] "[討論] 面試性向測驗"                    
    ## [11] "[討論] 面試多久後被通知錄取？"

``` r
##用grepl()
PPT_Job_title_total[grepl("面試",PPT_Job_title_total)]
```

    ##  [1] "[心得] 我的面試之旅 (電子業採購)"       
    ##  [2] "[請益] 住豪宅的話面試的地址資料該填嗎？"
    ##  [3] "[面試] 欣銓品保輪班工程師"              
    ##  [4] "[請益] 聯陽半導體行政管理職面試疑問"    
    ##  [5] "[面試] 杜邦-品保/製程工程師"            
    ##  [6] "[請益] 華泰電子和光寶科技面試"          
    ##  [7] "[請益] 3/15 中科GG面試通知？"           
    ##  [8] "[請益] 微星 RD_EMC/EMI 工程師 邀請面試" 
    ##  [9] "[面試] 雷泰/村田/台達/Recruit(日商)"    
    ## [10] "[討論] 面試性向測驗"                    
    ## [11] "[討論] 面試多久後被通知錄取？"

</hr>
### 問題

#### 請試著爬PTT科技工作版https://www.ptt.cc/bbs/Tech\_Job/index.html，一次爬十頁的文章標題後，請試著將”海邊”字串取代為”鴻海”、”滷肉”取代為”聯詠”，取代完畢後，請問”鴻海”出現在幾個標題中? VV

\*\* 提示: 上禮拜的詳解、標題存成向量就好、`gsub()`、`grep()`或是`grepl()` \*\*

### 解答

``` r
PPT_Job_title_total<-NULL
for (i in c(3020:3011)){
    PPT_Job_title<-
        read_html(paste0("https://www.ptt.cc/bbs/Tech_Job/index",i,".html"))%>%
        html_nodes(".title a")%>%
        html_text()
    PPT_Job_title_total<-c(PPT_Job_title_total,PPT_Job_title)
}

PPT_Job_title_total<-gsub("海邊","鴻海",PPT_Job_title_total)
PPT_Job_title_total<-gsub("滷肉","聯詠",PPT_Job_title_total)
length(PPT_Job_title_total[grep("鴻海",PPT_Job_title_total)])
```

    ## [1] 12

</hr>
### 問題

#### 請試著用Graph API或是Rfacebook套件，取出長庚大學 @cgu.edu.tw 粉絲專頁上今年度 (2018/01/01到今天) 的所有貼文，並將貼文全文以『，。 ？ ！ 』(皆為全形標點) 做切割，把整段文字中切成單句結構。

### 解答

``` r
library(Rfacebook) 
```

    ## Loading required package: httr

    ## Loading required package: rjson

    ## Loading required package: httpuv

    ## 
    ## Attaching package: 'Rfacebook'

    ## The following object is masked from 'package:methods':
    ## 
    ##     getGroup

``` r
token<-"EAACEdEose0cBANGbivXnCy8mpCnKZBCgiJwEWHNUcup6jCFuUmDd9lpS4mbrtnn2UonOu2fr66fNVZArmdWjDZCHWMyN9pgKyZCpR30frekntJ8CZCZAoKoJZBD7UtjJZAZBdAfB8b86okmtmoQvCifG0nFDQUUEyturwVEwVcr2a4k2ZBUOtjZCA2OAjZASvjG7W6gZD"   #將token複製到此處  

lastDate<-Sys.Date()  #系統日期
DateVector<-seq(as.Date("2018-01-01"),lastDate,by="1 days")
DateVectorStr<-as.character(DateVector)

totalPage<-NULL

for(i in 1:(length(DateVectorStr)-1)){
    tempPage<-getPage("cgu.edu.tw", token,
                since = DateVectorStr[i],
                until = DateVectorStr[i+1])
    totalPage<-rbind(totalPage,tempPage)
}
```

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 1 posts 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 1 posts 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 1 posts 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 1 posts 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 1 posts 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 1 posts 0 posts

    ## No public posts were found : cgu.edu.tw

    ## 2 posts

``` r
strsplit(totalPage$message,split = " |，|。|？|！")
```

    ## [[1]]
    ## [1] "https://www.facebook.com/cgurecruit/posts/899319000230618"
    ## 
    ## [[2]]
    ## [1] "新加坡將在2021年完成第一座質子治療設施"                              
    ## [2] "需培育醫學物理師"                                                    
    ## [3] "新加坡國立大學理學院為了規劃理想的醫學物理學本科生和研究生的養成計劃"
    ## [4] "相中長庚優秀的醫學物理學程及豐富的質子治療教學研究能量"              
    ## [5] "促成這次簽約合作"                                                    
    ## [6] "將於2018年暑假開始推動"                                              
    ## 
    ## [[3]]
    ## [1] "<U+653C><U+3E64><U+613C><U+3E30><U+623C><U+3E63><U+653C><U+3E64><U+623C><U+3E65><U+383C><U+3E39>賀"
    ## [2] "本校踢進106學年度大專足球聯賽一般男生組前四強"                       
    ## [3] "<U+653C><U+3E64><U+613C><U+3E30><U+623C><U+3E63><U+653C><U+3E64><U+623C><U+3E65><U+383C><U+3E61>\n\n3月31日下午1時將於本校足球場迎戰文化大學"
    ## [4] "爭奪冠亞軍決賽門票"                                                  
    ## [5] "\n\n大家一起幫本校足球隊加油"                                        
    ## [6] ""                                                                    
    ## [7] "\n\nhttp://www.ssu.org.tw/news/news_content.php?nid=8926&key="       
    ## 
    ## [[4]]
    ## [1] "賀"                                                      
    ## [2] "本校李明義特聘教授研究團隊在心臟病發預警創新醫材研發成果"
    ## [3] "獲IEEE"                                                  
    ## [4] "JBHI"                                                    
    ## [5] "期刊評選為Cover"                                         
    ## [6] "paper"                                                   
    ## [7] "feature"                                                 
    ## [8] "article"                                                 
    ## 
    ## [[5]]
    ##  [1] "2018年「長庚器官捐贈與大體老師追思大會」3月24日下午在長庚大學國際會議廳舉行"
    ##  [2] ""                                                                           
    ##  [3] "近千人與會緬懷先人無私的大愛精神"                                           
    ##  [4] ""                                                                           
    ##  [5] "家屬前往校內「遺愛人間」紀念牌獻花"                                         
    ##  [6] ""                                                                           
    ##  [7] "悼念他們摯愛而又偉大的親人"                                                 
    ##  [8] ""                                                                           
    ##  [9] "現場佈置由三千紙鶴"                                                         
    ## [10] ""                                                                           
    ## [11] "隨風飄搖"                                                                   
    ## [12] "傳達與會者思念"                                                             
    ## [13] "也祝福因大愛重生的受贈者"                                                   
    ## [14] ""                                                                           
    ## [15] "延續生命的美好"                                                             
    ## [16] ""                                                                           
    ## [17] "展開新生"                                                                   
    ## [18] ""                                                                           
    ## 
    ## [[6]]
    ## [1] "教育部高教深耕計畫補助65件大學特色領域研究中心"            
    ## [2] "科技部從中選出來自8所大學的18件計畫加碼補助"               
    ## [3] "長庚大學新興病毒感染研究中心以出色表現名列其中"            
    ## [4] "研究團隊希望透過未來五年的研究"                            
    ## [5] "可以成為世界上解開腸病毒神經毒性機轉的前驅研究中心"        
    ## [6] "其成果將可突破性提供腸病毒重症或病毒性腦炎治療的方式及策略"
    ## 
    ## [[7]]
    ## [1] "長庚大學2009年首創國內第一個新興病毒感染研究中心"          
    ## [2] "由施信如教授帶領的研究團隊"                                
    ## [3] "與不同領域的專家共同合作新興病毒感染症病毒株的辨識檢驗工作"
    ## [4] "進而開發抗病毒藥物及免疫療法等相關研究"                    
    ## [5] "各項成果深受國際肯定"                                      
    ## [6] "近日更獲科技部大學特色領域研究中心重點補助"                
    ## [7] "是私校唯一獲此殊榮"                                        
    ## [8] "再次展現長庚大學頂尖研究能量"                              
    ## 
    ## [[8]]
    ## [1] "楊智偉院長以國際腎病學會(ISN)東亞北亞區理事會副主席的身分出席"
    ## [2] "分享台灣經驗"

<hr />
### 問題

#### 在桃園市政府資料開放平台中，找到路外停車資訊資料(每分鐘更新) <http://data.tycg.gov.tw/api/v1/rest/datastore/0daad6e6-0632-44f5-bd25-5e1de1e9146f?format=json> ，試著將資料使用API的方式讀入R，並找到存放資料的位置，請問，在資料中，桃園市停車場是設在公園的有幾個?(名稱`parkName`有包含"公園"字串)  

\*\* 提示: `fromJSON()`、`$`、`grep()` \*\*

### 解答

``` r
library(jsonlite)
```

    ## 
    ## Attaching package: 'jsonlite'

    ## The following objects are masked from 'package:rjson':
    ## 
    ##     fromJSON, toJSON

``` r
library(RCurl)
```

    ## Loading required package: bitops

``` r
ParkingData<-fromJSON("http://data.tycg.gov.tw/api/v1/rest/datastore/0daad6e6-0632-44f5-bd25-5e1de1e9146f?format=json")
str(ParkingData) 
```

    ## List of 2
    ##  $ success: logi TRUE
    ##  $ result :List of 5
    ##   ..$ resource_id: chr "0daad6e6-0632-44f5-bd25-5e1de1e9146f"
    ##   ..$ fields     :'data.frame':  12 obs. of  2 variables:
    ##   .. ..$ type: chr [1:12] "int4" "text" "text" "text" ...
    ##   .. ..$ id  : chr [1:12] "_id" "parkId" "areaId" "areaName" ...
    ##   ..$ records    :'data.frame':  79 obs. of  12 variables:
    ##   .. ..$ parkName    : chr [1:79] "府前地下停車場" "新民立體停車場" "西門地下停車場" "新埔停車場" ...
    ##   .. ..$ areaId      : chr [1:79] "1" "1" "1" "1" ...
    ##   .. ..$ wgsX        : num [1:79] 121 121 121 121 121 ...
    ##   .. ..$ totalSpace  : int [1:79] 344 195 538 109 514 45 61 64 201 80 ...
    ##   .. ..$ introduction: chr [1:79] "桃園市政府管轄之停車場" "桃園區公所管轄之公有停車場" "桃園區公所管轄之公有停車場" "桃園區公所管轄之公有停車場" ...
    ##   .. ..$ wgsY        : num [1:79] 25 25 25 25 25 ...
    ##   .. ..$ parkId      : chr [1:79] "P-TY-001" "P-TY-003" "P-TY-004" "P-TY-005" ...
    ##   .. ..$ address     : chr [1:79] "桃園區縣府路一號" "桃園區民權路32號" "桃園區四維街39號" "桃園區新埔六街與南平路交叉口" ...
    ##   .. ..$ payGuide    : chr [1:79] "停車費率:30 元/小時。停車時數未滿一小時者，以一小時計算。逾一小時者，其超過之不滿一小時部分，如不逾三十分鐘者，以半小時計算；如"| __truncated__ "收費費率：30元/小時。停車時數未滿一小時者，以一小時計算。逾一小時者，其超過之不滿一小時部分，如不逾三十分鐘者，以半小時計算；如"| __truncated__ "收費費率：30元/小時。停車時數未滿一小時者，以一小時計算。逾一小時者，其超過之不滿一小時部分，如不逾三十分鐘者，以半小時計算；如"| __truncated__ "收費費率：20元/小時。停車時數未滿一小時者，以一小時計算。逾一小時者，其超過之不滿一小時部分，如不逾三十分鐘者，以半小時計算；如"| __truncated__ ...
    ##   .. ..$ _id         : int [1:79] 1 2 3 4 5 6 7 8 18 9 ...
    ##   .. ..$ surplusSpace: chr [1:79] "248" "48" "123" "開放中" ...
    ##   .. ..$ areaName    : chr [1:79] "桃園區" "桃園區" "桃園區" "桃園區" ...
    ##   ..$ total      : int 79
    ##   ..$ limit      : int 100

``` r
length(grep("公園",ParkingData$result$record$parkName))
```

    ## [1] 8

<hr />
### 問題

#### 在桃園市政府資料開放平台中，找到路外停車資訊資料(每分鐘更新) <http://data.tycg.gov.tw/api/v1/rest/datastore/0daad6e6-0632-44f5-bd25-5e1de1e9146f?format=json> ，試著將資料使用API的方式讀入R，並找到存放資料的位置，請問，在資料中，各地區(areaname)有幾個停車場? VV

提示: fromJSON()、$、table()

\*\* 提示: `fromJSON()`、`$`、`grep()` \*\*

### 解答

``` r
library(jsonlite)
library(RCurl)
ParkingData<-fromJSON("http://data.tycg.gov.tw/api/v1/rest/datastore/0daad6e6-0632-44f5-bd25-5e1de1e9146f?format=json")
str(ParkingData) 
```

    ## List of 2
    ##  $ success: logi TRUE
    ##  $ result :List of 5
    ##   ..$ resource_id: chr "0daad6e6-0632-44f5-bd25-5e1de1e9146f"
    ##   ..$ fields     :'data.frame':  12 obs. of  2 variables:
    ##   .. ..$ type: chr [1:12] "int4" "text" "text" "text" ...
    ##   .. ..$ id  : chr [1:12] "_id" "parkId" "areaId" "areaName" ...
    ##   ..$ records    :'data.frame':  79 obs. of  12 variables:
    ##   .. ..$ parkName    : chr [1:79] "府前地下停車場" "新民立體停車場" "西門地下停車場" "新埔停車場" ...
    ##   .. ..$ areaId      : chr [1:79] "1" "1" "1" "1" ...
    ##   .. ..$ wgsX        : num [1:79] 121 121 121 121 121 ...
    ##   .. ..$ totalSpace  : int [1:79] 344 195 538 109 514 45 61 64 201 80 ...
    ##   .. ..$ introduction: chr [1:79] "桃園市政府管轄之停車場" "桃園區公所管轄之公有停車場" "桃園區公所管轄之公有停車場" "桃園區公所管轄之公有停車場" ...
    ##   .. ..$ wgsY        : num [1:79] 25 25 25 25 25 ...
    ##   .. ..$ parkId      : chr [1:79] "P-TY-001" "P-TY-003" "P-TY-004" "P-TY-005" ...
    ##   .. ..$ address     : chr [1:79] "桃園區縣府路一號" "桃園區民權路32號" "桃園區四維街39號" "桃園區新埔六街與南平路交叉口" ...
    ##   .. ..$ payGuide    : chr [1:79] "停車費率:30 元/小時。停車時數未滿一小時者，以一小時計算。逾一小時者，其超過之不滿一小時部分，如不逾三十分鐘者，以半小時計算；如"| __truncated__ "收費費率：30元/小時。停車時數未滿一小時者，以一小時計算。逾一小時者，其超過之不滿一小時部分，如不逾三十分鐘者，以半小時計算；如"| __truncated__ "收費費率：30元/小時。停車時數未滿一小時者，以一小時計算。逾一小時者，其超過之不滿一小時部分，如不逾三十分鐘者，以半小時計算；如"| __truncated__ "收費費率：20元/小時。停車時數未滿一小時者，以一小時計算。逾一小時者，其超過之不滿一小時部分，如不逾三十分鐘者，以半小時計算；如"| __truncated__ ...
    ##   .. ..$ _id         : int [1:79] 1 2 3 4 5 6 7 8 18 9 ...
    ##   .. ..$ surplusSpace: chr [1:79] "248" "48" "123" "開放中" ...
    ##   .. ..$ areaName    : chr [1:79] "桃園區" "桃園區" "桃園區" "桃園區" ...
    ##   ..$ total      : int 79
    ##   ..$ limit      : int 100

``` r
table(ParkingData$result$record$areaName)
```

    ## 
    ## 八德區 大溪區 中壢區 平鎮區 桃園區 新屋區 楊梅區 龍潭區 龜山區 蘆竹區 
    ##      7      4     18      8     14      2     12      2      7      5

</hr>
### 問題

#### 在桃園市政府資料開放平台中，找到路外停車資訊資料(每分鐘更新) <http://data.tycg.gov.tw/api/v1/rest/datastore/0daad6e6-0632-44f5-bd25-5e1de1e9146f?format=json> ，請試者基於各停車場介紹(introduction)，分出公有私有停車場，並將判斷結果“公有”、”私有”存在新欄位`Type`中，請問資料中有幾個私有停車場?

\*\* 提示: `Type<-`、`ifelse()` 、`grepl()`、`政府` \*\*

### 解答

``` r
library(jsonlite)
library(RCurl)
ParkingData<-fromJSON("http://data.tycg.gov.tw/api/v1/rest/datastore/0daad6e6-0632-44f5-bd25-5e1de1e9146f?format=json")
str(ParkingData) 
```

    ## List of 2
    ##  $ success: logi TRUE
    ##  $ result :List of 5
    ##   ..$ resource_id: chr "0daad6e6-0632-44f5-bd25-5e1de1e9146f"
    ##   ..$ fields     :'data.frame':  12 obs. of  2 variables:
    ##   .. ..$ type: chr [1:12] "int4" "text" "text" "text" ...
    ##   .. ..$ id  : chr [1:12] "_id" "parkId" "areaId" "areaName" ...
    ##   ..$ records    :'data.frame':  79 obs. of  12 variables:
    ##   .. ..$ parkName    : chr [1:79] "府前地下停車場" "新民立體停車場" "西門地下停車場" "新埔停車場" ...
    ##   .. ..$ areaId      : chr [1:79] "1" "1" "1" "1" ...
    ##   .. ..$ wgsX        : num [1:79] 121 121 121 121 121 ...
    ##   .. ..$ totalSpace  : int [1:79] 344 195 538 109 514 45 61 64 201 80 ...
    ##   .. ..$ introduction: chr [1:79] "桃園市政府管轄之停車場" "桃園區公所管轄之公有停車場" "桃園區公所管轄之公有停車場" "桃園區公所管轄之公有停車場" ...
    ##   .. ..$ wgsY        : num [1:79] 25 25 25 25 25 ...
    ##   .. ..$ parkId      : chr [1:79] "P-TY-001" "P-TY-003" "P-TY-004" "P-TY-005" ...
    ##   .. ..$ address     : chr [1:79] "桃園區縣府路一號" "桃園區民權路32號" "桃園區四維街39號" "桃園區新埔六街與南平路交叉口" ...
    ##   .. ..$ payGuide    : chr [1:79] "停車費率:30 元/小時。停車時數未滿一小時者，以一小時計算。逾一小時者，其超過之不滿一小時部分，如不逾三十分鐘者，以半小時計算；如"| __truncated__ "收費費率：30元/小時。停車時數未滿一小時者，以一小時計算。逾一小時者，其超過之不滿一小時部分，如不逾三十分鐘者，以半小時計算；如"| __truncated__ "收費費率：30元/小時。停車時數未滿一小時者，以一小時計算。逾一小時者，其超過之不滿一小時部分，如不逾三十分鐘者，以半小時計算；如"| __truncated__ "收費費率：20元/小時。停車時數未滿一小時者，以一小時計算。逾一小時者，其超過之不滿一小時部分，如不逾三十分鐘者，以半小時計算；如"| __truncated__ ...
    ##   .. ..$ _id         : int [1:79] 1 2 3 4 5 6 7 8 18 9 ...
    ##   .. ..$ surplusSpace: chr [1:79] "248" "48" "123" "開放中" ...
    ##   .. ..$ areaName    : chr [1:79] "桃園區" "桃園區" "桃園區" "桃園區" ...
    ##   ..$ total      : int 79
    ##   ..$ limit      : int 100

``` r
table(ParkingData$result$record$introduction)
```

    ## 
    ##             八德區公所管轄之公有停車場 
    ##                                      2 
    ##             中壢區公所管轄之公有停車場 
    ##                                     11 
    ##             平鎮區公所管轄之公有停車場 
    ##                                      7 
    ##               長庚醫院管轄之私有停車場 
    ##                                      3 
    ##                   長庚醫院管轄之停車場 
    ##                                      1 
    ## 桃園市立圖書館平鎮分館管轄之公有停車場 
    ##                                      1 
    ##         桃園市立圖書館管轄之公有停車場 
    ##                                      1 
    ##       桃園市政府交通局管轄之公有停車場 
    ##                                      4 
    ##           桃園市政府交通局管轄之停車場 
    ##                                      4 
    ##   桃園市政府風景區管理所轄之公有停車場 
    ##                                      2 
    ##                 桃園市政府管轄之停車場 
    ##                                     10 
    ##             桃園區公所管轄之公有停車場 
    ##                                      9 
    ##             新屋區公所管轄之公有停車場 
    ##                                      2 
    ##             楊梅區公所管轄之公有停車場 
    ##                                     12 
    ##             龍潭區公所管轄之公有停車場 
    ##                                      2 
    ##             龜山區公所管轄之公有停車場 
    ##                                      3 
    ##             蘆竹區公所管轄之公有停車場 
    ##                                      5

``` r
ParkingData$result$record$Type<-
  ifelse(grepl("私有",ParkingData$result$record$introduction),"私有",
  ifelse(grepl("公有",ParkingData$result$record$introduction),"公有",
  ifelse(grepl("政府",ParkingData$result$record$introduction),"公有",
  ifelse(grepl("醫院",ParkingData$result$record$introduction),"私有",""))))
```

</hr>
### 問題

#### 在桃園市政府資料開放平台中，找到路外停車資訊資料http://data.tycg.gov.tw/api/v1/rest/datastore/0daad6e6-0632-44f5-bd25-5e1de1e9146f?format=json ，請試著取出計費方式說明(payguide)的第6-7個字元，並存在新的欄位Price中。備註: 沒按照格式打的計費方式，取出的價錢會很怪，有興趣的同學可以試著想該怎麼處理所有的價錢資料。

\*\* 提示: fromJSON()、$Price&lt;-、substr() \*\*

### 解答???

``` r
#library(jsonlite)
#library(RCurl)
ParkingData<-fromJSON("http://data.tycg.gov.tw/api/v1/rest/datastore/0daad6e6-0632-44f5-bd25-5e1de1e9146f?format=json")
str(ParkingData) 
```

    ## List of 2
    ##  $ success: logi TRUE
    ##  $ result :List of 5
    ##   ..$ resource_id: chr "0daad6e6-0632-44f5-bd25-5e1de1e9146f"
    ##   ..$ fields     :'data.frame':  12 obs. of  2 variables:
    ##   .. ..$ type: chr [1:12] "int4" "text" "text" "text" ...
    ##   .. ..$ id  : chr [1:12] "_id" "parkId" "areaId" "areaName" ...
    ##   ..$ records    :'data.frame':  79 obs. of  12 variables:
    ##   .. ..$ parkName    : chr [1:79] "府前地下停車場" "新民立體停車場" "西門地下停車場" "新埔停車場" ...
    ##   .. ..$ areaId      : chr [1:79] "1" "1" "1" "1" ...
    ##   .. ..$ wgsX        : num [1:79] 121 121 121 121 121 ...
    ##   .. ..$ totalSpace  : int [1:79] 344 195 538 109 514 45 61 64 201 80 ...
    ##   .. ..$ introduction: chr [1:79] "桃園市政府管轄之停車場" "桃園區公所管轄之公有停車場" "桃園區公所管轄之公有停車場" "桃園區公所管轄之公有停車場" ...
    ##   .. ..$ wgsY        : num [1:79] 25 25 25 25 25 ...
    ##   .. ..$ parkId      : chr [1:79] "P-TY-001" "P-TY-003" "P-TY-004" "P-TY-005" ...
    ##   .. ..$ address     : chr [1:79] "桃園區縣府路一號" "桃園區民權路32號" "桃園區四維街39號" "桃園區新埔六街與南平路交叉口" ...
    ##   .. ..$ payGuide    : chr [1:79] "停車費率:30 元/小時。停車時數未滿一小時者，以一小時計算。逾一小時者，其超過之不滿一小時部分，如不逾三十分鐘者，以半小時計算；如"| __truncated__ "收費費率：30元/小時。停車時數未滿一小時者，以一小時計算。逾一小時者，其超過之不滿一小時部分，如不逾三十分鐘者，以半小時計算；如"| __truncated__ "收費費率：30元/小時。停車時數未滿一小時者，以一小時計算。逾一小時者，其超過之不滿一小時部分，如不逾三十分鐘者，以半小時計算；如"| __truncated__ "收費費率：20元/小時。停車時數未滿一小時者，以一小時計算。逾一小時者，其超過之不滿一小時部分，如不逾三十分鐘者，以半小時計算；如"| __truncated__ ...
    ##   .. ..$ _id         : int [1:79] 1 2 3 4 5 6 7 8 18 9 ...
    ##   .. ..$ surplusSpace: chr [1:79] "248" "48" "123" "開放中" ...
    ##   .. ..$ areaName    : chr [1:79] "桃園區" "桃園區" "桃園區" "桃園區" ...
    ##   ..$ total      : int 79
    ##   ..$ limit      : int 100

``` r
table(ParkingData$result$record$introduction)
```

    ## 
    ##             八德區公所管轄之公有停車場 
    ##                                      2 
    ##             中壢區公所管轄之公有停車場 
    ##                                     11 
    ##             平鎮區公所管轄之公有停車場 
    ##                                      7 
    ##               長庚醫院管轄之私有停車場 
    ##                                      3 
    ##                   長庚醫院管轄之停車場 
    ##                                      1 
    ## 桃園市立圖書館平鎮分館管轄之公有停車場 
    ##                                      1 
    ##         桃園市立圖書館管轄之公有停車場 
    ##                                      1 
    ##       桃園市政府交通局管轄之公有停車場 
    ##                                      4 
    ##           桃園市政府交通局管轄之停車場 
    ##                                      4 
    ##   桃園市政府風景區管理所轄之公有停車場 
    ##                                      2 
    ##                 桃園市政府管轄之停車場 
    ##                                     10 
    ##             桃園區公所管轄之公有停車場 
    ##                                      9 
    ##             新屋區公所管轄之公有停車場 
    ##                                      2 
    ##             楊梅區公所管轄之公有停車場 
    ##                                     12 
    ##             龍潭區公所管轄之公有停車場 
    ##                                      2 
    ##             龜山區公所管轄之公有停車場 
    ##                                      3 
    ##             蘆竹區公所管轄之公有停車場 
    ##                                      5

``` r
ParkingData$result$record$Price<-substr(ParkingData$result$record$payGuide,6,7)

###
#for (i in c(1:length(ParkingData$result$records$payGuide))){
#  ParkingData$result$record$Price2[i]<-
#  strsplit(ParkingData$result$record$payGuide," |:|：|/|／")[[i]][2]
#}
```

</hr>
