# PowerShell Script for RustDesk Auto-Update

ENG

## How to use:

- git clone git@github.com:IgorMan2005/PowerShell-Script-for-RustDesk-Auto-Update.git

- Run PowerShell as administrator.

- Run the script:

```
.\Update-RustDesk.ps1
```

### What the script does:

- Checks the current version of RustDesk.
- Gets information about the latest release from GitHub.
- Compares versions and, if there is an update, downloads and installs the new version.
- Removes the temporary installer file after completion.

### Notes:

- Make sure you have access to the Internet and the GitHub API.
- The script uses silent installation mode (/S) to avoid prompting the user.
- If RustDesk is installed in a non-standard folder, change the $rustDeskPath variable

---

RU
## Как использовать:

- git clone git@github.com:IgorMan2005/PowerShell-Script-for-RustDesk-Auto-Update.git

- Запустите PowerShell с правами администратора.

- Выполните скрипт:

```
.\Update-RustDesk.ps1
```

### Что делает скрипт:

- Проверяет текущую версию RustDesk.
- Получает информацию о последнем релизе с GitHub.
- Сравнивает версии и, если есть обновление, загружает и устанавливает новую версию.
- Удаляет временный файл установщика после завершения.

### Примечания:

- Убедитесь, что у вас есть доступ к интернету и API GitHub.
- Скрипт использует тихий режим установки (/S), чтобы избежать запросов пользователю.
- Если RustDesk установлен в нестандартную папку, измените переменную $rustDeskPath

---

https://best-itpro.ru
