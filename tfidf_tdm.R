## tfidf

단어의 빈도는 문서의 의미를 나타내는 지표 역할을 한다. 단어의 빈도이므로 term frequency(tf)라고 한다. 지금까지 `count()`함수로 문서에서 단어의 수를 계산한 방식이다. 그러나 문서에서 등장하는 빈도가 높다해서 반드시 문서의 의미를 나타내지는 않는다. "은/는/이/가"와 같은 조사는 모든 문서에서 사용되는 단어이므로 문서의 의미를 파악하는게 기여하지 않는다.

이런 단어는 정제과정에서 불용어로 전처리하지만, 불용어로 분류해 제거한 단어 중에는 의미있는 단어인 경우도 있다는데 있다.

모든 문서에 등장하는 단어빈도의 역수와 단어의 빈도를 곱하면, 특정 문서에서 많이 사용되는지 계산할 수 있다.

"은/는/이/가"처럼 대부분의 문서에 등장하는 단어를 불용어처리를 하지 않고, 상대빈도를 낮게 계산해 처리하는 기법이 단어빈도-역문서빈도(term frequency-inverse document frequency: tfidf)다.



### tf(term frequency)

개별 문서(d)에 등장하는 단어(t)의 수. 예를 들어, `단어1`이 `문서1`에서 10번 등장했다면 `문서1`에서의 `단어1`의 tf는 10이다. `문서5`에서 5번 사용됐다면 `문서5`에서 `단어1`의 tf는 5가 된다.

\begin{equation}
tf(t, d) = \frac{문서에 등장한 단어의 빈도}{문서에 등장한 모든 단어의 총빈도}
\end{equation}

```{r}
sky_v <-  c( "The sky is blue.",
             "The sun is bright today.",
             "The sun in the sky is bright.",
             "We can see the shining sun, the bright sun.")

tf <- tibble(text = sky_v) %>%
  unnest_tokens(sentence, text, token = "sentences") %>%
  mutate(lineID = row_number()) %>%
  mutate(lineID = as.factor(lineID)) %>%
  unnest_tokens(word, sentence) %>%
  anti_join(stop_words) %>%
  count(lineID, word) %>%
  cast_tdm(term = word, document = lineID, value = n) %>%
  as.matrix()

tf


sky_tf <- tibble(text = sky_v) %>%
  unnest_tokens(sentence, text, token = "sentences") %>%
  mutate(lineID = row_number()) %>%
  mutate(lineID = as.factor(lineID)) %>%
  unnest_tokens(word, sentence) %>%
  anti_join(stop_words) %>%
  count(lineID, word) %>% # tf
  arrange(lineID)  %>%
  rename(tf = n) %>%
  mutate(N = length(unique(lineID))) #total number of documnets

sky_tf




```

'blue':  1번행에서 tf는 1이고, 2,3,4번행에서는 0

'sun':  1번행에서 tf는 0이고, 2,3,4번행에서는 각각 1 1 2



### df(document frequency)

특정 단어(t)가 나타난 문서(D)의 수. 예를 들어, `단어1`이 `문서1`과 `문서5`에만 나타났다면 `단어1`에 대한 df는 2다. `단어2`가 `문서1`부터 `문서10`에 걸쳐 10개 문서에서 모두 나타났다면 `단어2`에 대한 df는 10으로서 모든 문서에서 사용되는 단어임을 나타낸다.

\begin{equation}
df(t, D)
\end{equation}

```{r}
df <- rowSums(tf != 0)
df

```

'blue': 1번행에만 등장했으므로 1

'sun': 2,3, 4번 행에 등장했으므로 3


### idf(inverse document frequency)

전체 문서의 수(N)를 해당 단어의 df로 나눈 뒤 로그를 취한 값. 값이 클수록 특정 문서에서만 등장하는 특이한 단어라는 의미가 된다.

\begin{equation}
idf(t, D) = log(\frac{N}{df})
\end{equation}

분모가 0이 되면 무한대가 되므로 df에 1을 더한다.

```{r}
idf <- log( ncol(tf) / (1 + rowSums(tf != 0)) )
idf

```

3개 행에 걸쳐 등장하는 'is' 'bright' 'sun'의 idf는 0

1개 행에만 등장한 'blue' 'we'의 idf는 0.69


### tfidf
tf와 idf를 곱한 값. 특정 문서에서 등장하는 정도를 나타내므로 문서의 의미를 나타내는 지표로 사용할 수 있다.

\begin{equation}
tfidf(t, d, D) = tf(t, d) * idf(t, D)
\end{equation}

- `t`: 단어
- `d`: 개별 문서
- `D`: 개별 문서의 집합(말뭉치)


```{r}
diag(idf)


```

```{r}
sky_tfidf <- tf*idf
sky_tfidf

```

긴 문장에는 단어의 수가 많기 때문에 긴 문장에 들어 있는 단어는 실제보다 중요성이 큰 것으로 나타날 가능성이 있다. 아래의 방식으로 정규화하면 최종적인 tfidf가 나온다.


```{r}
sky_tfidf / sqrt( colSums(sky_tfidf^2))


```
