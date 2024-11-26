@echo off

REM Имя коммита по умолчанию — текущее время
for /f %%a in ('powershell -command "(Get-Date).ToString(\"yyyy-MM-dd HH:mm:ss\")"') do set commit_message=Backup on %%a

REM Проверка, если передан аргумент для сообщения коммита
if "%~1" NEQ "" (
  set commit_message=%~1
)

REM Сначала загрузка изменений из удаленного репозитория
echo Pulling changes from remote repository...
git pull origin main

REM Проверка на ошибки pull
if %errorlevel% NEQ 0 (
  echo Error during git pull. Exiting...
  exit /b %errorlevel%
)

REM Добавление всех файлов в stage
echo Adding all files to Git...
git add .

REM Создание коммита с заданным сообщением
echo Creating commit...
git commit -m "%commit_message%"

REM Проверка на ошибки commit
if %errorlevel% NEQ 0 (
  echo No changes to commit or error during commit. Proceeding to push...
)

REM Отправка изменений в удаленный репозиторий
echo Pushing to remote repository...
git push origin main

REM Проверка на ошибки push
if %errorlevel% NEQ 0 (
  echo Error during git push. Exiting...
  exit /b %errorlevel%
)

echo Synchronization complete.
