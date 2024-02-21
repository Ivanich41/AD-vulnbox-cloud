# AD-vulnbox-cloud
Cloud based vulnbox solution
## Предварительная подготовка
Необходимы установить утилиты: [yc](https://cloud.yandex.ru/ru/docs/cli/quickstart), [terrafrom](https://developer.hashicorp.com/terraform/install?product_intent=terraform), [ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) 

А также необходимо выолнить иницианлизацию CLI Yandex cloud:
```
yc init
```
Добавьте ваш открытый ключ(и) в файл [metadata.yml](./metadata.yml) в формате массива yaml

![array](./static/array.png)

## Создание машины 
Виртуальная машина создаётся с помощью Terraform в Яндекс Облаке.
Для начала выполните импорт перемееных окружения для конкретной работы terraform в яндекс облаке:
```bash
export YC_TOKEN=$(yc iam create-token)
export YC_CLOUD_ID=$(yc config get cloud-id)
export YC_FOLDER_ID=$(yc config get folder-id)
```
Далее инициализируйте провайдера и примените конфигурацию terraform:
```bash
terraform init
terraform apply --auto-approve 
```
Начнётся создание машины.
--- 
## TODO:
- ~~Сценарий развертки машины с помощью terraform~~ 
- Сценарий предподготовки с помощью Ansible 
- Readme 
- [Возможно] Подготовка образа в Packer