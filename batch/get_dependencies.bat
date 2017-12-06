@echo off

if not exist %delphiooLib%\ooBatch\ (
  @echo "Clonning ooBatch..."
  git clone https://github.com/VencejoSoftware/ooBatch.git %delphiooLib%\ooBatch\
  call %delphiooLib%\ooBatch\code\get_dependencies.bat
)

if not exist %delphiooLib%\ooFilter\ (
  @echo "Clonning ooFilter..."
  git clone https://github.com/VencejoSoftware/ooFilter.git %delphiooLib%\ooFilter\
  call %delphiooLib%\ooFilter\batch\get_dependencies.bat
)

if not exist %delphiooLib%\ooSort\ (
  @echo "Clonning ooSort..."
  git clone https://github.com/VencejoSoftware/ooSort.git %delphiooLib%\ooSort\
  call %delphiooLib%\ooSort\batch\get_dependencies.bat
)