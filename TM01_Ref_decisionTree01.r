# 01 분류와 회귀 나무(CART, Classification and Regression Trees)

# 패키지 : rpart
# rpart {formula, data }
# predict.rpart(object, 
               newdata,   # 예측 수행 데이터 
               type=c("vector", "prob", "class", "matrix")
               )
               
# [실습]
install.packages("rpart")
library(rpart)

m <- rpart(Species ~ ., data=iris)
m
plot(m)
text(m)

# 그림 보강
install.packages("rpart.plot")
library(rpart.plot)
prp(m, type=4, extra=2, digits=3)

# prp 함수 이용
# type=4 모든 노드에 레이블 붙이기
# extra=2 관측값과 각 노드에서 예측된 데이터의 비율을 출력 

# 예측
head(predict(m, newdata=iris, type="class"))


# 조건부 추론 나무
# 패키지 : party
# 1. 통계적 유의성 판단없이 노드를 분할하는데 과적합(Overfitting)
# 2. 다양한 값으로 분할 가능한 변수가 다른 변수에 비해 선호된다.
# 라이브러리 :ctree를 적용하여 Species 예측 모델을 생성.

# 변수와 반응값(분류) 사이의 연관 관계를 측정하여 노드 분할에 사용할 변수 선택.
install.packages("party")
library(party)
m1 <- ctree(Species ~ . , data=iris)
iris$Species
m1
plot(m1)

# predict.BinaryTree(
#    obj,      # BinaryTree 객체
#    newdata,  # 예측을 수행할 데이터 
#    type=c("response", "node", "prob")
#)

