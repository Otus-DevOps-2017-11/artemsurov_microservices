# artemsurov_microservices
## HW14
```
Был установлен docker
Запущен образ docker run hello-world
Изучено что:
```
1. Сама команда docker run = docker create + docker start + docker attach* (при добавлении -i)
>docker ps (показывает запущенные контейнеры ) | docker -a (показывает все)

2. Команды: 
> docker start <u_container_id>
> docker attach <u_container_id></br>
```Позволяют запустить конкретный контейнер и потом присоединится к нему SSH```

3. А команда exec позволяет запускать внутри программы различный софт
> docker exec -it <u_container_id> bash
> docker inspect

4. Показывает инфу о аппетитах в ресурсах образов и контейнерах в системе
> docker system df 

5. Убить процесс,а потом и ~~закопать~~ удалить из системы контейнер и образ можно с помощью команд:
1) > docker kill $(docker ps -q)
2) > docker rm $(docker ps -a -q)
3) > docker rmi $(docker images -q)

## HW15
В данном домашнем задании  была выполнена авторизация на GCP для подключения дополнительной docker-machine
Так же был создан image из dockerfile и запущен контейнер.
Полученный образ был сохранен в hub.docker.

Разница между 

> docker run --rm -ti tehbilly/htop 

и

> docker run --rm --pid host -ti tehbilly/htop

в том, что в первом случае это вывод информации о процессах в контейнере, а во втором информация о процессах из инстанса.

## HW16
Было создано первое микросервисное приложение!
Для  каждого микросервиса был создан dockerfile  со своими настройками.

## HW17
В данном ДЗ было изучены конфиги сети докера в зависимости от применяемого драйвера.
1. Так при использовании ***none*** драйвера у контейнера есть доступ только к loopback интерфейсу.
Команды, чтобы проверить:
    > docker run --network none --rm -d --name net_test joffotron/docker-net-tools -c "sleep 100"

    > docker exec -ti net_test ifconfig
2. При использовании ***host*** драйвера каждый контейнер конектится к одному порту хоста и таким образом занимает его. Еше одним преимуществом является отсутствие Оверхеда на сеть со стороны докера так, как это происходит с подключением через ***bridge***
    Запустим контейнер в сетевом пространстве docker-хоста
    > docker run --network host --rm -d --name net_test joffotron/docker-net-tools -c "sleep 100"

    Сравните выводы команд:
    > docker exec -ti net_test ifconfig

    > docker-machine ssh docker-host ifconfig
3. В Докере есть 2 bridge драйвера. Первый дефолтный, второй user defined. </br>
Особенности Default Bridge Network:
    * Назначается по-умолчанию для контейнеров
    * Нельзя вручную назначать IP-адреса
    * Нет никакого Service Discovery

    Особенности User Defined Bridge
    * Если нужно отделить контейнер или группу контейнеров
    * Контейнер может быть подключен к нескольким bridge-
    сетям (даже без рестарта)
    * Работает Service Discovery
    * Произвольные диапазоны IP-адресов

Так же в данном дз был рассмотрен `docker-compose` и сконфигурирован в соответствии с первым заданием и заданием со звездочкой `docker-compose.yml`

## HW19
В данном дз научился ставить gitlab-runner, подрубил Slack и добавил роль для активации ранера из Ansible и альтернативный playbook
## HW20
В данном дз были изучен способы создания pipeline для деплоя в stage и prod с помощью GitLab Ci

## HW21
В данном дз был установлен и настроен Prometheus.
и изучены способы получения и оценки метрик с вэб сервисов.
Ссылка на запушеный контейнеры https://hub.docker.com/r/asurov/
