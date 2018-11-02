
### https://rpubs.com/jmhome/K-means
### 군집분석이란?
### 군집 분석은 비지도학습(Unsupervised learning) 분석 기법 중 하나입니다. 쉽게 말해서, 사전 정보 없이 자료를 컴퓨터에게 주고, “유사한 대상끼리 묶어보아라!” 라고 명령을 내리는 분석 방법입니다.
### 

### 군집 분석은 유사한 대상끼리 그룹핑 하는 분석
### K-means 군집 분석은 비계층적 군집 분석 방법을 사용

library(caret)
set.seed(1712)

inTrain <- createDataPartition(y = iris$Species, p = 0.7, list = F)
training <- iris[inTrain,]
testing <- iris[-inTrain,]
training
testing

# 3.2 표준화
# K-means 군집 분석은 관측치 간의 거리를 이용하기 때문에 
# 변수의 단위가 결과에 큰 영향을 미칩니다. 
# 그래서 변수를 표준화 하는 작업이 필요한데요, 
# scale 함수를 사용해서 표준화
training.data <- scale(training[-5])
summary(training.data)

# 3.3
# 모델 작성 - 3개의 군집으로 나누기
iris.kmeans <- kmeans(training.data[,-5], centers = 3, iter.max = 10000)
iris.kmeans$centers

# 3.4
# 군집 분석 결과를 training 데이터셋에 할당하고, 결과를 확인
# 결과를 보니 setosa는 잘 분류해 내었지만 versicolor나 virginica 종은 잘 구분해 내지 못함.
training$cluster <- as.factor(iris.kmeans$cluster)
qplot(Petal.Width, Petal.Length, colour = cluster, data = training)
table(training$Species, training$cluster)

# 3.5
# K-means 군집분석에서 군집 중심의 갯수를 결정하는 방법
# 몇개의 군집 중심이 적당한지 결정하는 방법에는 여러가지가 있습니다. 
# 그중 자주 사용하는 NbClust 패키지를 사용하는 방법과 
# 군집 내  sum of squares를 사용하는 방법
install.packages("NbClust")
library(NbClust)

nc <- NbClust(training.data, min.nc = 2, max.nc = 15, method = "kmeans")

# ## 인덱스 : D 인덱스는 클러스터의 수를 결정하는 그래픽 방식입니다.
## D 지수의 플롯에서 우리는 상당한 무릎을 찾습니다 (Dindex에서 중요한 피크

### *** Hubert 지수는 클러스터 수를 결정하는 그래픽 방식입니다.
## Hubert 지수의 플롯에서 우리는 a에 해당하는 유의 한 무릎을 찾습니다.
## 측정 값의 유의 한 증가, 즉 Hubert의 유의 한 피크
## 색인 두 번째 차이점 플롯.

par(mfrow=c(1,1))
barplot(table(nc$Best.n[1,]),
        xlab="Numer of Clusters", ylab="Number of Criteria",
        main="Number of Clusters Chosen")
# NbClust 함수는 3개의 군집이 적당하다고 함.

# 3.6 이번에는 Some of square means
wssplot <- function(data, nc = 15, seed = 1234) {
  wss <- (nrow(data) - 1) * sum(apply(data, 2, var))
  for (i in 2:nc) {
    set.seed(seed)
    wss[i] <- sum(kmeans(data, centers=i)$withinss)}
  plot(1:nc, wss, type="b", xlab = "Number of Clusters",
       ylab = "Within groups sum of squares")}

wssplot(training.data)

# 3.7
install.packages("e1071")
library(e1071)
training.data <- as.data.frame(training.data)
modFit <- train(x = training.data[,-5], 
                y = training$cluster,
                method = "rpart")

testing.data <- as.data.frame(scale(testing[-5]))
testClusterPred <- predict(modFit, testing.data) 
table(testClusterPred ,testing$Species)
