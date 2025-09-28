@echo off
REM ========= CONFIG ==========
SET APP_NAME=TestFramework_ETU003222
SET SRC_DIR=src
SET WEB_DIR=webapp
SET WEB_INF_DIR=WEB-INF
SET BUILD_DIR=build
SET LIB_DIR=lib
SET TOMCAT_WEBAPPS=C:\xampp\tomcat\webapps
REM ===========================

echo Nettoyage de %BUILD_DIR% ...
if exist %BUILD_DIR% rmdir /s /q %BUILD_DIR%
mkdir %BUILD_DIR%\WEB-INF\lib

echo Copie du framework JAR dans WEB-INF/lib ...
copy %LIB_DIR%\*.jar %BUILD_DIR%\WEB-INF\lib\

echo Copie des ressources webapp ...
xcopy %WEB_DIR%\* %BUILD_DIR%\ /s /e /y

echo Copie de web.xml ...
copy %WEB_INF_DIR%\web.xml %BUILD_DIR%\WEB-INF\

echo Création du WAR ...
cd %BUILD_DIR%
jar -cvf %APP_NAME%.war *
cd ..

echo Déploiement du WAR vers Tomcat ...
if exist %TOMCAT_WEBAPPS%\%APP_NAME% rmdir /s /q %TOMCAT_WEBAPPS%\%APP_NAME%
copy %BUILD_DIR%\%APP_NAME%.war %TOMCAT_WEBAPPS%\

echo ============================
echo Application packagée en WAR et déployée
echo Vérifie dans Tomcat : http://localhost:8080/%APP_NAME%
echo ============================