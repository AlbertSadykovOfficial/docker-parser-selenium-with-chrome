FROM python:3.8

MAINTAINER Albert Sadykov <albertsadykov@ro.ru>

WORKDIR /app

#####----[ Уставнавливаем зависимости ]----######################################################################################

# Уставнавливаем зависимости парсера
# 1) common - Общие
RUN pip install --no-cache-dir beautifulsoup4==4.11.1 redis==4.3.4 urllib3==1.26.11 click==8.1.3

# 2) selenium - для парсера через браузер (для рендеринга)
RUN pip install --no-cache-dir selenium==4.7.2 selenium-wire==5.1.0

#####----[ Устанавливаем Google Chrome и Chromium (нужны для selenium) ]----#####################################################

# Добавляем репозиторий google для apt
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=$(dpkg --print-architecture)] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

# Обновляем apt
RUN apt-get -y update

# Устанавливаем google-chrome
RUN apt-get install -y google-chrome-stable
RUN apt-get install -y libglib2.0-0 \
    libnss3 \
    libgconf-2-4 \
    libfontconfig1


#####----[ Установка графической оболочки (X11) ]----#############################################################################

# Графическая оболочка X11-server
RUN apt-get install xvfb -y
# set display port to avoid crash
ENV DISPLAY=:99

##################################################################################################################################
