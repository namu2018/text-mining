
### Basic
### ggvis packages
### REF : https://ggvis.rstudio.com/ggvis-basics.html

library(ggvis)

### 01. 점의 크기와 투명도 조정
mtcars %>% 
  ggvis(~wt, ~mpg, 
        size := input_slider(10, 100),
        opacity := input_slider(0, 1)
  ) %>% 
  layer_points()

### 02. 점의 크기와 투명도 조정
mtcars %>% 
  ggvis(~wt) %>% 
  layer_histograms(width =  input_slider(0, 2, step = 0.10, label = "width"),
        center = input_slider(0, 2, step = 0.05, label = "center"))


keys_s <- left_right(10, 1000, step = 50)
mtcars %>% ggvis(~wt, ~mpg, size := keys_s, opacity := 0.5) %>% layer_points()

### 03. toolTip을 추가하기
mtcars %>% ggvis(~wt, ~mpg) %>% 
  layer_points() %>% 
  add_tooltip(function(df) df$wt)


### 04. 원 그리기
t <- seq(0, 2 * pi, length = 100)
df <- data.frame(x = sin(t), y = cos(t))
df %>% ggvis(~x, ~y) %>% layer_paths(fill := "red")

### 05. 텍스트 쓰기
df <- data.frame(x = 3:1, y = c(1, 3, 2), label = c("a", "b", "c"))
df %>% ggvis(~x, ~y, text := ~label) %>% layer_text()
df %>% ggvis(~x, ~y, text := ~label) %>% layer_text(fontSize := 50)

### 06. multiple layer
### 동일한 플롯에서 여러 레이어를 결합하여 풍부한 그래픽을 만들 수 있다. 
mtcars %>% 
  ggvis(~wt, ~mpg) %>% 
  layer_smooths() %>% 
  layer_points()

iris %>%
  ggvis( x = ~Sepal.Length, y = ~Sepal.Width, size = ~Petal.Length) %>%
  layer_points()

iris %>%
  ggvis( x = ~Sepal.Length, y = ~Sepal.Width, 
         fill = input_select("red", "black", "blue", label = "Select Color"),
    size = input_slider(100,500, label="Select Size"), opacity = 0.3 ) %>% layer_points()
