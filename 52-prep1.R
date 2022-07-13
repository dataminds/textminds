## 시각화

# 자료(data) 시각화: 탐색적분석
# 정보 시각화:

# 시각화를 하는 이유?

anscombe
str(anscombe)

mean(anscombe$x1)
mean(anscombe$x2)
mean(anscombe$x3)
mean(anscombe$x4)
mean(anscombe$y1)
mean(anscombe$y2)
mean(anscombe$y3)
mean(anscombe$y4)

mean(anscombe[ ,1])
mean(anscombe[ ,2])
mean(anscombe[ ,3])
mean(anscombe[ ,4])
mean(anscombe[ ,5])
mean(anscombe[ ,6])
mean(anscombe[ ,7])
mean(anscombe[ ,8])

apply(anscombe, 2, mean)
apply(anscombe, 2, sd)

cor(anscombe$x1, anscombe$y1)
cor(anscombe$x2, anscombe$y2)
cor(anscombe$x3, anscombe$y3)
cor(anscombe$x4, anscombe$y4)

lm(x1 ~ y1, anscombe)
lm(x2 ~ y2, anscombe)
lm(x3 ~ y3, anscombe)
lm(x4 ~ y4, anscombe)

plot(anscombe$x1, anscombe$y1)
plot(anscombe$x2, anscombe$y2)
plot(anscombe$x3, anscombe$y3)
plot(anscombe$x4, anscombe$y4)

plot(y1 ~ x1, anscombe)
plot(y2 ~ x2, anscombe)
plot(y3 ~ x3, anscombe)
plot(y4 ~ x4, anscombe)

anscombe %>% plot(y1 ~ x1, .)

anscombe$x1

anscombe %>% .$x1

ggplot2

install.packages("ggplot2")
library(ggplot2)

ggplot(data = anscombe) +
  geom_point(mapping = aes(x = x2, y = y2))

anscombe %>%
  ggplot() +
  geom_point(aes(x1, y1)) +
  geom_line(aes(x2, y2))

anscombe %>%
  ggplot(aes(x1, y1)) +
  geom_point() +
  geom_line() +
  geom_smooth(method = lm)


anscombe %>%
  ggplot(aes(x1, y1)) +
  geom_point() +
  geom_smooth(method = lm)

anscombe %>%
  ggplot(aes(x2, y2)) +
  geom_point() +
  geom_smooth(method = lm)

anscombe %>%
  ggplot(aes(x3, y3)) +
  geom_point() +
  geom_smooth(method = lm)

anscombe %>%
  ggplot(aes(x4, y4)) +
  geom_point() +
  geom_smooth(method = lm) +
  labs(title = "안스콤의 4개조",
       subtitle = "X4와 Y4의 관계",
       caption = "Source: Anscombe") +
  theme(plot.title = element_text(size = 20),
        plot.subtitle = element_text(color = "blue", size = 13))


















































