#!/bin/bash
#Проверка наличия файла access.log
if [ ! -f "access.log" ]; then
  echo "Файл access.log не найден!"
  exit 1
fi

#Создание файла в котором будет хранится отчет по логам
> report.txt

#Получение общего числа логов
total_requests=$(wc -l < access.log)
#Получение уникальных ip
unique_ips=$(awk '{print $1}' access.log | sort | uniq | wc -l)
#Получение самого популярно URL
popular_url=$(awk '{print $7}' access.log | sort | uniq -c | sort -nr | head -n 1)
echo "Отчет о логе веб-сервера">>report.txt
echo "===========================">>report.txt
echo "Общее количество запросов: $total_requests">>report.txt
echo "Количество уникальных IP-адресов: $unique_ips">>report.txt
echo "">>report.txt
echo "Количество запросов по методам:" >> report.txt
awk '{count[$6]++} END {for (item in count) print substr(item, 2), count[item]}' access.log >> report.txt
echo "">>report.txt
echo "Самый популярный  URL: $popular_url">>report.txt
echo "Отчет сохранен в файл: report.txt"