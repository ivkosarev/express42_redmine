В данном репозитории лежит набор инструкций для создания Docker контейнера с Redmine.
Написан он сумбурно и во многом неправильно, но факт есть факт, оно работает ¯\_(ツ)_/¯

Для его работы используется:
1. PostgreeSQL
2. Ruby 2.6.5
3. Bundler
***
Чтобы запустить Redmine изданного репозитория достаточно выполнить несколько простых дествий:

1. Сконировать репозиторий и перейти в его каталог
2. Собрать образ (docker build)
3. Дождаться сборки образа
4. Запустить контейнер с открытием портов.