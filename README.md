# maksim-se_infra
maksim-se Infra repository

bastion_IP = 35.211.93.41

someinternalhost_IP = 10.142.0.3

testapp_IP = 35.204.75.54

testapp_port = 9292

Команад для создания VM с помощью gcloud

    gcloud compute instances create reddit-app\
    --boot-disk-size=10GB \
    --image-family ubuntu-1604-lts \
    --image-project=ubuntu-os-cloud \
    --machine-type=g1-small \
    --tags puma-server \
    --restart-on-failure

Написаны скрипты для автоматической  установки пакетом для приложения Reddit
    install_ruby.sh -- обновляет систему и устанавливает Ruby
    install_mongodb.sh -- устанавливает mongoDB для приложения
    deploy.sh -- запускает приложение Reddit

    01_provis_reddit_apps.sh -- скрипт для автоматического разворчивания приложения Reddit на VM. Команда для дапуска следующая: 

    gcloud compute instances create reddit-app\
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --metadata-from-file startup-script=01_provis_reddit_apps.sh

В скрипте прописан "костыль" для предоствращения повторного разворачивания приложения после рестарта VM.

Так же создан bucket для хранения скриптов.

    gsutil mb gs://a35b48/

Скопирован файл 01_provis_reddit_apps.sh

    gsutil cp 01_provis_reddit_apps.sh gs://a35b48/

В нём размещен стартовый файл  01_provis_reddit_apps.sh  и при создании прописан как метаданные для VM:

    gcloud compute instances create reddit-app\
    --boot-disk-size=10GB \
    --image-family ubuntu-1604-lts \
    --image-project=ubuntu-os-cloud \
    --machine-type=g1-small \
    --tags puma-server \
    --restart-on-failure \
    --metadata startup-script-url=gs://a35b48/01_provis_reddit_apps.sh

Удаление правила firewall default-puma-server производится командой:

    gcloud compute firewall-rules delete default-puma-server

Создание этого правила через cmd:

    gcloud compute firewall-rules create default-puma-server --action allow  --rules tcp:9292 --source-ranges 0.0.0.0/0



============================================================================

ДЗ №5

Написаны конфиг- и файл-переменных для создания образа reddit-base-1540324101 с предъустановленными пакетами mongodb и ruby. запускается командой:
        
    packer build -var-file=variables.json ubuntu16.json

Файл variables.json занесен в .gitignore для секурности.

Потом на основе образа reddit-base-1540324101 был создан образ с задеплоенным приложением.
Написан файл systemd для запуска приложения при старте системы.
Конфиг-файл нового образа называется immutable.json

В файле config-scripts/create-reddit-vm.sh прописана комманда для создания машины из последнего образа  reddit-full-1540329152 

gcloud compute instances create reddit-full --zone=europe-west1-b --image "reddit-full-1540329152" --machine-type f1-micro

Так же команды запуска и останова этой машины.


