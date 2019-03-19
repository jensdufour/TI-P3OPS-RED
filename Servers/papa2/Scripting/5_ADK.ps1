#Zet de Installers en adksetup onder Documents
#Ga eerst naar directory in CMD prompt(Admin) en voer dit uit


cd C:\Users\Administrator\Documents
adksetup.exe /installpath "C:\Program Files (x86)\Windows Kits\10" /features OptionId.DeploymentTools OptionId.UserStateMigrationTool OptionId.WindowsPreinstallationEnvironment /ceip off /norestart

