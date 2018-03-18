控制流程 課堂練習
================

#### `if(){ }else{}`和`ifelse()`在本質上有什麼不同?

#### 解答

ifelse 可一次判斷多個元素，可判斷向量。<br/> 其他條件判斷函數則無法判斷向量，且會產生Warning Message。

<hr/>
#### 新增一個數值`score`，值設定為80

撰寫if- else if - else條件判斷式，依`score`變數數值判斷，邏輯如下：

-   小於60分，印出“回家洗洗睡再戰下學年"
-   大於等於60分，小於75分，印出"低空飛過"
-   大於等於75分，小於90分，印出"普通"
-   大於等於90分，印出"挑戰學霸"

#### 解答

``` r
score<-80

if(score<60){
  print("回家洗洗睡再戰下學年")
  }else if(score>=60 & score<75){
    print("低空飛過")
    }else if(score>=75 & score<90){
      print("普通")
      }else {
      print("挑戰學霸")
    }
```

    ## [1] "普通"

<hr/>
#### 基於`iris`資料內的`Sepal.Length`欄位，新增一個`Type`欄位<br>

#### 邏輯：

-   如果`Sepal.Length` 大於5.5，`Type`設定為"長"
-   小於等於5.5，`Type`設定為"短"

#### 解答

``` r
iris$Type<-""
iris$Type<-ifelse(iris$Sepal.Length>5.5,"長","短")

#為精簡版面僅顯示前後六行供同學參考
head(iris)
```

    ##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species Type
    ## 1          5.1         3.5          1.4         0.2  setosa   短
    ## 2          4.9         3.0          1.4         0.2  setosa   短
    ## 3          4.7         3.2          1.3         0.2  setosa   短
    ## 4          4.6         3.1          1.5         0.2  setosa   短
    ## 5          5.0         3.6          1.4         0.2  setosa   短
    ## 6          5.4         3.9          1.7         0.4  setosa   短

``` r
tail(iris)
```

    ##     Sepal.Length Sepal.Width Petal.Length Petal.Width   Species Type
    ## 145          6.7         3.3          5.7         2.5 virginica   長
    ## 146          6.7         3.0          5.2         2.3 virginica   長
    ## 147          6.3         2.5          5.0         1.9 virginica   長
    ## 148          6.5         3.0          5.2         2.0 virginica   長
    ## 149          6.2         3.4          5.4         2.3 virginica   長
    ## 150          5.9         3.0          5.1         1.8 virginica   長

<hr/>
#### 新增一向量`a`，包含1~20的所有奇數，請撰寫一個for迴圈，逐一印出向量`a`內的元素，但遇到13的倍數時，直接跳出迴圈，不繼續執行

#### 解答

``` r
a<-seq(1,20,2)

for (i in a){
if(i %%13==0){
 break 
}
print(i)
}
```

    ## [1] 1
    ## [1] 3
    ## [1] 5
    ## [1] 7
    ## [1] 9
    ## [1] 11

<hr/>
#### 在`USArrests`集中，新增一個`QOL`變數，描述生活品質與是否適合居住，判別邏輯如下：如果謀殺率`Murder`大於10，直接設為“不宜人居”，若謀殺率`Murder`小於等於10，則需再考慮毆打侵犯率`Assault`，若毆打侵犯率大於100，設為“要非常小心”，若毆打侵犯率小於等於100，則需再考慮市區人口`UrbanPop`，超過70設定為"很擠"，其他就設定為“可以住”。請用nested if else完成上述生活品質分類。最後美國共有幾個州屬於"可以住"類別？

#### 解答

``` r
USArrests$QOL<-""
USArrests$QOL<- ifelse(USArrests$Murder>10,"不宜人居",
                 ifelse(USArrests$Assault>100,"要非常小心",
                        ifelse(USArrests$UrbanPop>70,"很擠","可以住")))
table(USArrests$QOL)
```

    ## 
    ##   不宜人居     可以住       很擠 要非常小心 
    ##         15          9          1         25

<hr/>
#### 務必用`if-else`（傳統式）搭配`for()`迴圈撰寫！在`airquality`中新增一個變數`Outdoor`，描述這天的空氣品質是否適合出門，若臭氧`Ozone`大於20，且太陽光強度`Solar radiation`大於100，`Outdoor`設定為“不適合出門”，若臭氧`Ozone`小於20，且太陽光強度`Solar radiation`小於100，設定為“適合出門”，其他情況請設定為”未知“。<br/>

完成設定後，資料集內有幾天為“不適合出門”、“適合出門”和“未知”？<br/>

請將程式碼貼上，並在後方貼上答案

#### 解答

``` r
USArrests$QOL<-""
USArrests$QOL<- ifelse(USArrests$Murder>10,"不宜人居",
                 ifelse(USArrests$Assault>100,"要非常小心",
                        ifelse(USArrests$UrbanPop>70,"很擠","可以住")))
table(USArrests$QOL)
```

    ## 
    ##   不宜人居     可以住       很擠 要非常小心 
    ##         15          9          1         25

<hr/>
