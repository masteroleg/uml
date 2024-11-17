@echo off

REM Имя коммита по умолчанию — текущее время
for /f %%a in ('powershell -command "(Get-Date).ToString(\"yyyy-MM-dd HH:mm:ss\")"') do set commit_message=Backup on %%a

REM Проверка, если передан аргумент для сообщения коммита
if "%~1" NEQ "" (
  set commit_message=%~1
)

REM Добавление всех файлов в stage
echo Adding all files to Git...
git add .

REM Создание коммита с заданным сообщением
echo Creating commit...
git commit -m "%commit_message%"

REM Отправка изменений в удаленный репозиторий
echo Pushing to remote repository...
git push origin main

echo Backup complete.
