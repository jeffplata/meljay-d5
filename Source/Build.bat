@echo off
if "%1" == "" goto paramrequired

erase %1.cfg.bak
ren %1.cfg %1.cfg.bak
copy %1Release.cfg %1.cfg
dcc32speed -b %1
if not errorlevel 1 goto end





:error
Echo Error!
goto end

:paramrequired
Echo.
Echo Parameter required.
Echo Usage: Build {projectname}  (note: without extension)
Echo .

:end


