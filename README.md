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

## HW23
* Настройка монитринга за контейнерами
* Настройка Grafana и создания дашбордов для нее
* Настрокак alertmanager для оповещения в случае необходимости

## HW25
В приложения появился трэсинг с помощью зипкина,
были добавлены контейнеры ElasticStack, Zipkin, Kibana,Fluentd.
В так же настроенны и изучена работа с Kibana и Fluentd.

## HW 27
Домашнее задание посвященное работе с docker-compose
Команда, чтобы создать машину 
```
docker-machine create --driver google \
   --google-project  docker-XXXXXX  \
   --google-zone europe-west1-b \
   --google-machine-type g1-small \
   --google-machine-image $(gcloud compute images list --filter ubuntu-1604-lts --uri) \
   master-1
```

Для генерации токенов 
>docker swarm join-token manager/worker

Команда, чтобы добавить машину:
```
docker swarm join --token
SWMTKN-1-5dkxha7z0h9vfxqsoepxqybmehcs7mvfrtml00s8hxnn2nrgep-
chln12zdzd1805uensy5xouj7 10.132.0.6:2377
```

> docker stack deploy --compose-file=<(docker-compose -f docker-compose.yml config 2>/dev/null) DEV - команда чтобы раскатать конфиг

Выполнил основную часть д/з

## Hw 28 Kubernetes

# Сеть
Создадим новую VPC сеть:
```
gcloud compute networks create kubernetes-the-hard-way --subnet-mode custom
```
 и подсеть

```
gcloud compute networks subnets create kubernetes \
  --network kubernetes-the-hard-way \
  --range 10.240.0.0/24
```

# Firewall
Создадим правило для Firewall внутри сети:
```
gcloud compute firewall-rules create kubernetes-the-hard-way-allow-internal \
  --allow tcp,udp,icmp \
  --network kubernetes-the-hard-way \
  --source-ranges 10.240.0.0/24,10.200.0.0/16
```

Правило для внешнего доступа
```
gcloud compute firewall-rules create kubernetes-the-hard-way-allow-external \
  --allow tcp:22,tcp:6443,icmp \
  --network kubernetes-the-hard-way \
  --source-ranges 0.0.0.0/0
```

# Заняли внешний IP

```
gcloud compute addresses create kubernetes-the-hard-way \
  --region $(gcloud config get-value compute/region)
```

Проверить его наличие:
```
gcloud compute addresses list --filter="name=('kubernetes-the-hard-way')"
```

# По создаем Compute Instances:

Kubernetes Controllers
```
for i in 0 1 2; do
  gcloud compute instances create controller-${i} \
    --async \
    --boot-disk-size 200GB \
    --can-ip-forward \
    --image-family ubuntu-1604-lts \
    --image-project ubuntu-os-cloud \
    --machine-type n1-standard-1 \
    --private-network-ip 10.240.0.1${i} \
    --scopes compute-rw,storage-ro,service-management,service-control,logging-write,monitoring \
    --subnet kubernetes \
    --tags kubernetes-the-hard-way,controller
done
```

Kubernetes Workers
```
for i in 0 1 2; do
  gcloud compute instances create worker-${i} \
    --async \
    --boot-disk-size 200GB \
    --can-ip-forward \
    --image-family ubuntu-1604-lts \
    --image-project ubuntu-os-cloud \
    --machine-type n1-standard-1 \
    --metadata pod-cidr=10.200.${i}.0/24 \
    --private-network-ip 10.240.0.2${i} \
    --scopes compute-rw,storage-ro,service-management,service-control,logging-write,monitoring \
    --subnet kubernetes \
    --tags kubernetes-the-hard-way,worker
done
```
# Создаем сертифицированные центры и работаем со сертификатами
https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/04-certificate-authority.md