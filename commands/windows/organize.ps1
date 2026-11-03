@echo off
for %%a in (*) do (
    if /I not "%%~xa"=="" if /I not "%%~fa"=="%%~f0" (
        if not exist "%%~xa" mkdir "%%~xa"
        move "%%~a" "%%~xa\"
    )
)
