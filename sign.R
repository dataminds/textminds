sign_v <- "[`~∼!@#$%^&*()_+={}|,<>?¿，．；｀━￣―｜。°、·‥¨…〃∥＼
´ˇ˘˝˚˙¸˛¡ːⅦⅤⓒ'“‘’Δ前（）［］｛｝‘’“”〔〕〈〉《》「」『』【】±×
÷≠≤≥∞∴∂∇≡≒≪≫∽∵∧∨￢⇒⇔＄％￦Ｆ′″℃￡￥℉
㎕㎖㎘㏄㎣㎥㎚㎛㎜㎝㎞㎟㎠㎡㎢㏊㎍㎎㎏㎈㎉㏈㎐㎐㎑Ω＃
＆＊§※☆★○●◎◇◆□■△▲▽▼→←↑↓↔〓◁◀▷▶♤♠♡♥♧♣⊙◈▣◐◑▒▤▥▨▧▦▩♨☏☎☜☞
¶†↕↗↙↖↘♩♪♬㉿㈜™®º©ª─│㉠㉡㉢㉣㉤㉥㉦㉧㉮㉯㉰㉱㉲㉳㉴㉵
㈀㈁㈂㈃㈄㈅㈆㈇㈎㈏㈐㈑㈒㈓㈔㈕０１２３４５６７８９ⅰⅱⅲⅳⅴⅵⅶⅷⅸⅹⅠⅡⅢⅣⅤⅥⅦⅧⅨⅩ½⅓⅔¼¾ㆍㅣΔΩαβπ]"


str_remove(sign_v, "\\w+")

"!@#$... 전각ㆍΔΩαβπ문자 %^&*()" %>% str_remove("[:punct:]+")

ai_tk %>% count(cat, word, sort = T) %>%
  bind_log_odds(set = cat, feature = word, n = n) %>%
  arrange(log_odds_weighted)

ai_tk %>% count(cat, word, sort = T) %>%
  bind_tf_idf(term = word, document = word, n = n) %>%
  arrange(idf)

"◆"
"‘라씨"
"'트롬" %>% str_detect()
