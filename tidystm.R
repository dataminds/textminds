# https://github.com/mikajoh/tidystm

devtools::install_github("mikajoh/tidystm", dependencies = TRUE)
library(tidystm)

data(gadarian)

gadarian %>% glimpse()

processed <- textProcessor(data$documents, metadata = data)


prep <- estimateEffect(1:3 ~ treatment, gadarianFit, gadarian)

effect <- extract.estimateEffect(prep,
                                 "treatment",
                                 model = poliblogPrevFit,
                                 method = "pointestimate")

knitr::kable(effect)
