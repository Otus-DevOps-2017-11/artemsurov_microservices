# artemsurov_microservices
## HW14
'''
Был уствновлен docker
Запущен образ docker run hello-world
Изучено что:
'''
1. Сама команда docker run = docker create + docker start + docker attach* (при добавлении -i)
>docker ps (показывает запущенные контейнеры ) | docker -a (показыввает все)

2. Команды: 
> docker start <u_container_id>
> docker attach <u_container_id>
'''Позваляют запустить кокретный контейнер и потом присоединится к нему SSH'''

3. А команда exec позволяет запускать внутри программы различный софт
> docker exec -it <u_container_id> bash
> docker inspect

4. Показывает инфу о аппетитах в ресурсах образов и контейнерах в системе
> docker system df 

5. Убить процесс,а потом и ~~закопать~~ удалить из системы контейнер и образ можно с помощью команд:
> docker kill $(docker ps -q)
> docker rm $(docker ps -a -q)
> >docker rmi $(docker images -q)