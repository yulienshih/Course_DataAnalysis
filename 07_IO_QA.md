資料讀取與匯出 課堂練習
================
### 問題
#### 有一個網路上的csv檔，下載網址為https://goo.gl/RdngMn ，請問如何以撰寫程式碼的方式匯入R中作分析? <br/>

#### 匯入後，此表格有幾個欄位?

### 解答

**直接寫程式碼**

``` r
library(readr)
data_csv<-read_csv("https://goo.gl/RdngMn")
```

    ## Parsed with column specification:
    ## cols(
    ##   .default = col_character()
    ## )

    ## See spec(...) for full column specifications.

**注意**：上述輸出**Parsed with column specification:...**是指將每個欄位指定成特定資料型態，並非錯誤訊息。

若複製檔案路徑，需使用```/```，並在檔案路徑後加上檔名及副檔名，需以雙引號```""```包住整個路徑。

如：```read_csv("C:/Users/DH_LAB/Desktop/106_student.csv")```

``` r
length(data_csv)  ##欄位數寫法1
```

    ## [1] 22

``` r
dim(data_csv)[2]  ##欄位數寫法2
```

    ## [1] 22

``` r
ncol(data_csv)    ##欄位數寫法3
```

    ## [1] 22


**直接匯入資料**

<br /> ![test](https://github.com/CGUIM-BigDataAnalysis/BigDataCGUIM/blob/master/106/QA_figure/import1_0320.JPG)<br />
依據資料型態至`Import Datasets` 選擇匯入方式，以此題而言，資料為CSV格式，故選`From CSV...`<br/>
<br /> ![test](https://github.com/CGUIM-BigDataAnalysis/BigDataCGUIM/blob/master/106/QA_figure/import2_0320.jpg)<br />

**注意：**
若複製檔案路徑，需使用```/```，並在檔案路徑後加上檔名及副檔名

更改變數名稱、檔案輸入相關選項可參考[課堂講義](https://github.com/CGUIM-BigDataAnalysis/BigDataCGUIM/blob/master/106/07_IO.md)

<hr/>

### 問題

#### 下列哪幾種檔案可以匯入R作分析?

### 解答

Excel檔、MySQL資料庫檔、純文字檔 (.txt)、圖片檔等，部分清單參見[課堂講義](https://github.com/CGUIM-BigDataAnalysis/BigDataCGUIM/blob/master/106/07_IO.md)

<hr/>

### 問題

#### Open Data常用的資料格式有哪幾個?

### 解答

csv檔、JSON檔、XML檔

<hr/>

### 問題

#### 嘗試在政府資料開放平臺中，找到紫外線即時監測資料，並嘗試將XML檔案讀到R中，取出所有測站的名稱與紫外線強度資料。

Windows電腦有編碼問題，若讀出資料是亂碼，請將資料轉成BIG5<br/> 方法如下:`iconv(文字向量,from="UTF8",to="big5")`

-   `xmlParse(xml檔案路徑)`
-   `xpathSApply(資料集,要選取的資料XML的tag名稱,xmlValue)`

### 解答

``` r
# 資料下載網址：http://opendata2.epa.gov.tw/UV/UV.xml　（紫外線即時監測資料）
library(XML)
UV <- xmlParse("http://opendata2.epa.gov.tw/UV/UV.xml")
SiteName<-xpathSApply(UV,"//SiteName",xmlValue)
#iconv(SiteName,from="UTF8",to="big5")  #如果資料出現亂碼再跑這行
SiteName
```

    ##  [1] "淡水"   "板橋"   "桃園"   "苗栗"   "沙鹿"   "彰化"   "南投"  
    ##  [8] "斗六"   "阿里山" "塔塔加" "朴子"   "新營"   "橋頭"   "屏東"  
    ## [15] "嘉義"   "臺中"   "澎湖"   "宜蘭"   "金門"   "日月潭" "臺東"  
    ## [22] "蘭嶼"   "新屋"   "基隆"   "成功"   "臺北"   "恆春"   "鞍部"  
    ## [29] "新竹"   "臺南"   "玉山"   "高雄"   "馬祖"   "花蓮"

``` r
UVI<-xpathSApply(UV,"//UVI",xmlValue)
#iconv(UVI,from="UTF8",to="big5")  #如果資料出現亂碼再跑這行
UVI
```

    ##  [1] "0"    "0"    "0"    "0"    "0"    "0"    "0"    "0"    ""     "0"   
    ## [11] "0"    "0"    "0"    "0"    "0.00" "0.00" "0.09" "0.00" "0.00" "0.00"
    ## [21] "0.00" "0.00" "0.00" "0.00" "0.00" "0.00" "0.00" "0.00" "0.00" "0.00"
    ## [31] "0.00" "0.00" "0.00" "0.00"

``` r
##將資料整理成資料框寫法
UV_dataset<-data.frame(SiteName=xpathSApply(UV,"//SiteName",xmlValue),
            UVI=xpathSApply(UV,"//UVI",xmlValue))
UV_dataset
```

    ##    SiteName  UVI
    ## 1      淡水    0
    ## 2      板橋    0
    ## 3      桃園    0
    ## 4      苗栗    0
    ## 5      沙鹿    0
    ## 6      彰化    0
    ## 7      南投    0
    ## 8      斗六    0
    ## 9    阿里山     
    ## 10   塔塔加    0
    ## 11     朴子    0
    ## 12     新營    0
    ## 13     橋頭    0
    ## 14     屏東    0
    ## 15     嘉義 0.00
    ## 16     臺中 0.00
    ## 17     澎湖 0.09
    ## 18     宜蘭 0.00
    ## 19     金門 0.00
    ## 20   日月潭 0.00
    ## 21     臺東 0.00
    ## 22     蘭嶼 0.00
    ## 23     新屋 0.00
    ## 24     基隆 0.00
    ## 25     成功 0.00
    ## 26     臺北 0.00
    ## 27     恆春 0.00
    ## 28     鞍部 0.00
    ## 29     新竹 0.00
    ## 30     臺南 0.00
    ## 31     玉山 0.00
    ## 32     高雄 0.00
    ## 33     馬祖 0.00
    ## 34     花蓮 0.00

<hr/>

### 問題
#### 在xml中，<name>Belgian Waffles</name> 這樣的文字，又稱作?
### 解答
element
<hr/>

### 問題
#### 使用jsonlite匯入JSON檔後，一開始的資料結構會是?
### 解答
列表
<hr/>

### 問題
#### 為什麼我們需要API來擷取資料?
### 解答

<hr/>
### 問題
#### 嘗試在政府資料開放平臺中，找到景點 - 觀光資訊資料庫，
http://gis.taiwan.net.tw/XMLReleaseALL_public/scenic_spot_C_f.json
取出所有景點名稱Name，種類Orgclass，地址Add，以及開放時間Opentime，並將這些資料整理成資料框 (回答程式碼)
最後分析台灣的景點中，各種類的景點各占多少? (回答程式碼與程式輸出)。
提示: Name是Info tag裡面的attribute，跟單純取tag內文方法不同，若需取attribute內的值，範例如下
xpathSApply(xmlData,‘//Tag名稱’,xmlGetAttr,‘attribute名稱')

### 解答
``` r
library(jsonlite)
library(RCurl)
SpotData<-fromJSON("http://gis.taiwan.net.tw/XMLReleaseALL_public/scenic_spot_C_f.json")
str(SpotData)
SpotData_dataframe<-data.frame(Name = SpotData$XML_Head$Infos$Info$Name,
            Orgclass = SpotData$XML_Head$Infos$Info$Orgclass,
            Add = SpotData$XML_Head$Infos$Info$Add,
            Opentime = SpotData$XML_Head$Infos$Info$Opentime)
table(SpotData_dataframe$Opentime)
``` r

<hr/>

### 問題
#### 試著擷取桃園市公共自行車服務資料http://data.tycg.gov.tw/api/v1/rest/datastore/a1b4714b-3b75-4ff8-a8f2-cc377e4eaa0f?format=json並將記錄所有車站的位置與腳踏車數的資料框捷取出來，並檢查此資料表有幾個欄位?幾個觀察值?。貼上程式碼回答。

### 解答
``` r
#library(jsonlite)  #若console已載入套件，不需重複執行
#library(RCurl)     #若console已載入套件，不需重複執行
BikeData<-fromJSON("http://data.tycg.gov.tw/api/v1/rest/datastore/a1b4714b-3b75-4ff8-a8f2-cc377e4eaa0f?format=json")
str(BikeData)  
BikeData_dataframe<-
  data.frame(StationName = BikeData$result$records$sna,
            BikeCount = BikeData$result$records$sbi)
dim(BikeData_dataframe)
``` r
由桃園公共自行車即時服務資料的主要欄位說明可知sna表示車站名稱、sbi1表示腳踏車數，以dim檢視資料表維度，共有2個欄位、100筆觀察值

<hr/>

### 問題
#### 試著擷取台北市今日施工資訊資料http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=201d8ae8-dffc-4d17-ae1f-e58d8a95b162請問今日有幾筆施工資料?

### 解答
``` r
library(jsonlite)  #若console已載入套件，不需重複執行
library(RCurl)     #若console已載入套件，不需重複執行
ConstructionData<-fromJSON("http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=201d8ae8-dffc-4d17-ae1f-e58d8a95b162")
str(ConstructionData)  
Data_today<-ConstructionData$result$results$APPTIME
Data_today[substring(Data_today,1,7)=="1070326"]  #資料只到1061121?

``` r

<hr/>

### 問題
#### 請試著爬PTT科技工作版https://www.ptt.cc/bbs/Tech_Job/index.html，取出所有標題，請問第四個標題是?

- 使用read_html(“欲擷取的網站網址”)函數讀取網頁
- 使用html_nodes()函數擷取所需內容 (條件為CSS或xpath標籤)
- 使用html_text()函數處理/清洗擷取內容，留下需要的資料
- 使用html_attr()函數擷取資料參數（如連結url）

### 解答
``` r
library(rvest)
PPT_Job<-read_html("https://www.ptt.cc/bbs/Tech_Job/index.html")%>%
html_nodes(".title a")%>%
html_text()
PPT_Job[4]
``` 
使用SelectorGadget:綠色為要選取的項目、黃色表與綠色同層的元件、紅色為不想選取的元件


<hr/>

### 問題
#### 試著爬誠品網路書店的中文書優惠專區http://www.eslite.com/lowest_list.aspx?cate=156 請把第一頁的特價書書名爬出來。

- 想要挑戰的同學，可以試著把折數跟價錢也爬出來，但強烈建議使用SelectorGadget擴充套件

### 解答
``` r
library(rvest)
#書名
BookName<-
  read_html("http://www.eslite.com/lowest_list.aspx?cate=156")%>%
  html_nodes("h3 a")%>%
  html_text()
#原價
OriginalPrice<-
  read_html("http://www.eslite.com/lowest_list.aspx?cate=156")%>%
  html_nodes("div+ p span")%>%
  html_text()
#折扣
Discount<-
  read_html("http://www.eslite.com/lowest_list.aspx?cate=156")%>%
  html_nodes("p+ p > span")%>%
  html_text()
#折扣價
DiscountPrice<-
  read_html("http://www.eslite.com/lowest_list.aspx?cate=156")%>%
  html_nodes("p span span")%>%
  html_text()
  
BookInfo <-
  data.frame(BookName = BookName,
              OriginalPrice = OriginalPrice,
              Discount = Discount, 
              DiscountPrice= DiscountPrice)
BookInfo
``` 

<hr/>

### 問題
#### 請試著用Rfacebook套件爬你最有興趣的粉絲專頁，抓取今年度(2018/01/01-今天)的貼文，平均按讚數是多少?按讚數最高的是哪一篇，內容是什麼?貼上程式碼，並貼上按讚數最高那篇的內文

** 提示: seq since until for迴圈 **

### 解答
``` r
library(Rfacebook) #初次使用須先安裝
token<-"EAACEdEose0cBAIEjKDXpWhy6qRXAWWWMRMsZCDDGbgTwcdJ2m5RJMacWBJNR4QOt9yWn79dI7UGIZAKbuwsLZBZBCsbhcdOvVjtKPoAA4DWbpZCnup9EiNzcFIIsOiY3PbByliZAAuSaw3GsYEMElPYxRWY1Aj21C9pQ1WgoZBgdHeblrJhGKxQu4szwNm2FNwZD"

lastDate<-Sys.Date()
DateVector<-seq(as.Date("2018-01-01"),lastDate,by="1 days")
DateVectorStr<-as.character(DateVector)
DateVectorStr

#將token複製到此處 
totalPage<-NULL

for(i in 1:(length(DateVectorStr)-1)){
    tempPage<-getPage("sodagreen.band", token,
                since = DateVectorStr[i],
                until = DateVectorStr[i+1])
    totalPage<-rbind(totalPage,tempPage)
}
nrow(totalPage)
```

<hr/>

### 問題
#### 在R中，若想要每分鐘都自動用API擷取資料，該如何做呢? (請GOOGLE，Windows & Linux是使用不同方法，擇一回答)
### 解答

<hr/>

### 問題
#### 請試著爬PTT科技工作版https://www.ptt.cc/bbs/Tech_Job/index.html，只能取出一頁標題，觀察網頁，發現可以一直按”上頁”查看之前的文章，請問如何一次爬十頁的文章呢?

** 提示: 每頁有個編號，搭配for迴圈 **

### 解答
``` r
library(rvest)
PPT_Job_title_total<-NULL
for (i in c(3009:2999)){
PPT_Job_title<-
  read_html(paste0("https://www.ptt.cc/bbs/Tech_Job/index",i,".html"))%>%
  html_nodes(".title a")%>%
  html_text()
  
PPT_Job_title_total<-c(PPT_Job_title_total,PPT_Job_title)}
``` 

<hr/>

### 問題
#### Rfacebook裡面的getUser()是做什麼的? 請試著用自己的帳戶測試，並貼上程式碼作答。

### 解答

```r
getUsers("me", token, private_info = FALSE)
getUsers("871525749529330", token, private_info = FALSE)
getUsers("871525749529330", token, private_info = TRUE)
```
