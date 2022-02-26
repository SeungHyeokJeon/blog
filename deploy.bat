@ECHO OFF

@REM Define commit message
SET param=%*

ECHO Deploying updates to GitHub...

cd blog

@REM @REM Build the project
@REM hugo -t hugo-hello-programmer-theme

@REM Define commit message
SET msg=rebuilding site %DATE% %TIME%
IF defined param (
    SET msg=%param%
)
echo %msg%

@REM @REM Submodule commit
cd public
@REM git add .
@REM git commit -m "%msg%"
@REM git push origin main

@REM Main blog commit
cd ../..
git add .
git commit -m "%msg%"
git push origin main