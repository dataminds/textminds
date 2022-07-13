Sys.getlocale()
localeToCharset()

# 미국 로케일로 로케일을 변환하기
Sys.setlocale(category = 'LC_ALL',locale = 'english')
localeToCharset()

# Sys.setlocale("LC_ALL", "en_US.UTF-8") 맥용.

# 우리나라로 로케일 변경하기
Sys.setlocale(category = 'LC_ALL',locale='korean')
localeToCharset()

# http://r-bong.blogspot.com/2016/03/rstudio_26.html
