При первом запуске команды:
    ansible-playbook clone.yml
произошло клонирование репозитория в патку /home/appuser/reddit 
При повторном запуске после команды
    ansible app -m command -a 'rm -rf ~/reddit'  (удаление каталога ~/reddit)
произошло сново клонирование приложения, при этом в секции PLAY RECAP
    appserver                  : ok=2    changed=1    unreachable=0    failed=0   
указано, что удачно выролнено 2 таска (ok=2) и 1 таск совершил изменения состояния.

    TASK [Clone repo] *****************************************************************************************************************************
    task path: /home/maksim/education/otus/DevOps/maksim-se_infra/ansible/clone.yml:5
    changed: [appserver] => {"after": "5c217c565c1122c5343dc0514c116ae816c17ca2", "before": null, "changed": true}
Скрипт динамического инвенторя для ansible - dynamicInventory.sh
Запускается командой: 
    ansible all -m ping -i dynamicInventory.sh


********************************
Описание дом. работы HW-11
1. установил virtualbox и vagrant
2. создали конфиг для  vagrant
3. прописали provisioners
4. распределили плейбуки packer_db и packer_app по ролям
5. Добавили конфиигурирование имени пользователя в playbooks и значение пльзователя по-умолчанию в        defaults/main.yml в роли app. В Vagrantfile переопределяем значение по-умолчанию.
6. В качестве задание со * добавили конфигурирование nginx прокси: изменили адрес для запуска puma на локальный, что бы на него мог ссылаться nginx.