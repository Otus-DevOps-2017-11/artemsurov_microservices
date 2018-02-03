# artemsurov_microservices
## HW14
```
Был уствновлен docker
Запущен образ docker run hello-world
Изучено что:
```
1. Сама команда docker run = docker create + docker start + docker attach* (при добавлении -i)
>docker ps (показывает запущенные контейнеры ) | docker -a (показыввает все)

2. Команды: 
> docker start <u_container_id>
> docker attach <u_container_id>
```Позваляют запустить кокретный контейнер и потом присоединится к нему SSH```

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

Разница между docker run --rm -ti tehbilly/htop и docker run --rm --pid host -ti tehbilly/htop в том, что в первом случае это вывод информации о процессах в контейнере, а во втором информация о процессах из инстанса.

## HW16
Было созданно первое микросервисное приложение!
Для  каждого микросервиса был создан dockerfile  со своими настройками.

