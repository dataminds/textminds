url_v <- 'http://scholar.princeton.edu/sites/default/files/bstewart/files/poliblogs2008.csv'
dest_v <- 'data/poliblogs2008.csv'

download.file(url_v, dest_v, mode = "wb")
list.files('data/.')

data <- read_csv(dest_v)
data %>% glimpse()
set.seed(37)
data %>% sample_n(300) -> data

library(stm)
# stm 코퍼스 생성
# stm패키지의 전처리(소문자화, 구둣점제거, 불용어제거, 숫자제거, 스테밍)
processed <- textProcessor(data$documents, metadata = data)
processed %>% names()
processed %>% typeof()

processed <-
ai2_df %>% textProcessor(documents = ai2_df$text,
                         metadata = .)



# wordcounts 생성 + 빈도가 낮은 용어 제거 `lower.thresh = `로 최소값 설정
out <- prepDocuments(processed$documents,
                     processed$vocab,
                     processed$meta)
out %>% names()
out %>% typeof()

docs <- out$documents
docs[[4]][1]
vocab <- out$vocab
vocab[[2]][1:10]
meta <-out$meta
meta[[2]][1:5]

meta %>% glimpse()

# 계산에 시간 소요
poliblogPrevFit <- stm(documents = out$documents,
                       vocab = out$vocab,
                       K = 20,
                       prevalence =~ cat,
                       max.em.its = 3, # 계산편의 위해 2회만. 논문저자는 75회 수행.
                       data = out$meta,
                       init.type = "Spectral")

# 계산 시간 소요
# Model selection for a fixed number of number of topics
poliblogSelect <- selectModel(documents = out$documents,
                              vocab = out$vocab,
                              K = 20,
                              prevalence =~ rating + s(day),
                              max.em.its = 75,
                              data = out$meta,
                              runs = 20,
                              seed = 37)


plotModels(poliblogSelect,
           pch=c(1,2,3,4),
           legend.position="bottomright")

# Model search across numbers of topics
storage <- searchK(out$documents, out$vocab, K = c(7, 10),
                   prevalence =~ rating + s(day), data = meta)

#
u_v <- 'https://github.com/bstewart/stm/blob/gh-pages/files/VignetteObjects.RData?raw='
load(url(u_v))


# Understanding topics through words and example documents
labelTopics(poliblogPrevFit, c(1:10))

thoughts3 <- findThoughts(poliblogPrevFit, texts = shortdoc,
                          n = 2, topics = 3)$docs[[1]]
thoughts20 <- findThoughts(poliblogPrevFit, texts = shortdoc,
                           n = 2, topics = 20)$docs[[1]]

par(mfrow = c(1, 2),mar = c(.5, .5, 1, .5))
plotQuote(thoughts3, width = 30, main = "Topic 3")
plotQuote(thoughts20, width = 30, main = "Topic 20")



# Estimating metadata/topic relationships
out$meta$rating <- as.factor(out$meta$rating)

prep <- estimateEffect(1:20 ~ rating + s(day),
                       poliblogPrevFit,
                       meta = out$meta,
                       uncertainty = "Global")
summary(prep, topics=1)

plot(poliblogPrevFit, type = "summary", xlim = c(0, .3))



# Summary visualization

# Topical content

poliblogContent <- stm(out$documents,
                       out$vocab,
                       K = 20,
                       prevalence =~ rating + s(day),
                       content =~ rating,
                       max.em.its = 75,
                       data = out$meta,
                       init.type = "Spectral")

plot(prep,
     covariate = "rating", topics = c(1:10),
     model = poliblogPrevFit, method = "difference",
     cov.value1 = "Liberal", cov.value2 = "Conservative",
     xlab = "More Conservative ... More Liberal",
     main = "Effect of Liberal vs. Conservative",
     xlim = c(-.1, .1), labeltype = "custom",
     custom.labels = c('Obama', 'Sarah Palin','Bush Presidency'))


plot(prep, "day", method = "continuous", topics = 7,
     model = z, printlegend = FALSE, xaxt = "n", xlab = "Time (2008)")
monthseq <- seq(from = as.Date("2008-01-01"),
                   to = as.Date("2008-12-01"), by = "month")
monthnames <- months(monthseq)
axis(1,
     at = as.numeric(monthseq) - min(as.numeric(monthseq)),
     labels = monthnames )

plot(poliblogContent, type = "perspectives", topics = 11)
plot(poliblogPrevFit, type = "perspectives", topics = c(12, 20))

cloud(poliblogPrevFit, topic = 7, scale = c(2,.25))

# Plotting covariate interactions

poliblogInteraction <- stm(out$documents, out$vocab, K = 20,
                           prevalence =~ rating * day, max.em.its = 75,
                           data = out$meta, init.type = "Spectral")


prep <- estimateEffect(c(20) ~ rating * day, poliblogInteraction,
                        metadata = out$meta, uncertainty = "None")
plot(prep, covariate = "day", model = poliblogInteraction,
         method = "continuous", xlab = "Days", moderator = "rating",
         moderator.value = "Liberal", linecol = "blue", ylim = c(0, .12),
         printlegend = F)
plot(prep, covariate = "day", model = poliblogInteraction,
         method = "continuous", xlab = "Days", moderator = "rating",
         moderator.value = "Conservative", linecol = "red", add = T,
         printlegend = F)
legend(0, .08, c("Liberal", "Conservative"),
           lwd = 2, col = c("blue", "red"))



mod.out.corr <- topicCorr(poliblogPrevFit)
plot(mod.out.corr)


# The function toLDAvis enables export to the LDAvis package (Sievert and Shirley 2015) which helps view topic-word distributions

# tidystm (Johannesson 2018a), a package for making ggplot2 graphics with STM output,
# stminsights (Schwemmer 2018), a graphical user interface for exploring a fitted model





















