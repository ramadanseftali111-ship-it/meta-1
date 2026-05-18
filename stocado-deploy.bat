@echo off
echo ========================================
echo   STOCADO ENTEGRASYONU DEPLOY
echo ========================================
echo.

echo [1/4] Functions klasorune gidiliyor...
cd functions

echo [2/4] Paketler yukleniyor...
call npm install

echo [3/4] Ust klasore donuluyor...
cd ..

echo [4/4] Firebase'e deploy ediliyor...
call firebase deploy --only functions

echo.
echo ========================================
echo   DEPLOY TAMAMLANDI!
echo ========================================
echo.
echo Test icin Functions URL'ini tarayicida ac.
echo Loglar icin: firebase functions:log
echo.
pause
