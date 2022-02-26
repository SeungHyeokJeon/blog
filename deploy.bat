@ECHO OFF

@REM Define commit message
SET param=%*

ECHO Deploying updates to GitHub...

cd blog

@REM Build the project
hugo -t hugo-hello-programmer-theme

@REM Define commit message
SET msg=rebuilding site %DATE% %TIME%
IF defined param (
    SET msg=%param%
)
echo %msg%

@REM Submodule commit
cd public
git add .
git commit -m "%msg%"
git push origin main

@REM Main blog commit
cd ../..
git add .
git commit -m "%msg%"
git push origin main