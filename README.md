# Zabbix Handy Backup Monitor

Мониторинг заданий Handy Backup Professional через Zabbix Agent (Windows Server 2012+).

## Возможности

- Автообнаружение задач Handy Backup из reporting.xml
- Проверка статуса последнего запуска (SUCCESS / FAIL)
- Подсчёт количества проигнорированных ошибок
- Алерт при FAIL

## Требования

- Zabbix Server 7.0+
- Zabbix Agent 7.0+ на Windows Server
- Handy Backup Professional 8+

## Установка

### 1. Скопируйте файлы на сервер с Handy Backup

- `hb_status.ps1` → `C:\zabbix_agent\hb_status.ps1`
- `hb_discover.cmd` → `C:\zabbix_agent\hb_discover.cmd`

### 2. Добавьте UserParameter'ы в конфиг Zabbix Agent

```ini
UserParameter=handybackup.discover,C:\zabbix_agent\hb_discover.cmd
UserParameter=handybackup.status[*],powershell -ExecutionPolicy Bypass -File C:\zabbix_agent\hb_status.ps1 $1

Перезапустите агент.
### 3. Импортируйте шаблон

Импортируйте template_handy_backup.yaml в Zabbix.


### 4. Привяжите шаблон к хосту
Как работает

    handybackup.discover — читает reporting.xml, возвращает JSON со списком задач.

    handybackup.status[{#TASK}] — ищет последний .log.err задачи и возвращает статус.

## Примечания

    Имена задач извлекаются из reporting.xml (может быть много дубликатов, Zabbix берёт уникальные).

    Статус определяется по строкам Успешно завершено / Не выполнено! в логах.

    Логи читаются в кодировке UTF-16 LE.
