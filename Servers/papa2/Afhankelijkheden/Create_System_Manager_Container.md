## Creating System Management Container

- **Server Manager - Dashboard**, bij tools klik op **ADSI Edit**
- Recht klikken op **ADSI Edit** en **connect**, bij de connection settings zet je de Name als **Default naming context** verander niks anders. Klik **OK**
-  Voor de volgende stap volg je deze afbeelding:
	 ![](https://prajwaldesai.com/wp-content/uploads/2013/11/Installing-Prerequisites-for-Configuration-Manager-2012-R2-Snap3.jpg)
- Bij het Create Object venster kies je voor **container**, klik **NEXT**
- Geef als value **System Management**, klik **NEXT** & **FINSIH**
- Nu de container is gemaakt, gaan we de computer account permissie geven om info te publishen naar de container.
	Navigeer via het **Server Manager Dashboard** en **Tools** naar **Active Directory Users And Computers**
	Klik op **View** en click **Advanced Features**, Vouw de **System folder** uit onder **red.local**, klik rechts op **System Management** en klik op **Delegate Control**

- Nu gaan we Full Control permission toewijzen aan de site server computer account.
	 Klik op **Next**, klik op **Add**, in het **select users, computers or groups** venster klik op **Object Types** en check **Computers** as Object types. Klik op OK. **Typ** bij de **object names** de **primary site server computer account name** --> **PAPA2**
	 Klik **OK**

- Je moet de primary site server computer account in de lijst zien van users & groups, klik **NEXT**
- Bij de **Tasks To Delegate**  klik op **Create a custom task to delegate**, klik **NEXT**
- Bij het **Active Directory Object Type** venster, selecteer de optie **This folder, existing objects in this folder and creation of new objects in this folder**, klik op **NEXT**
- Selecteer de permissions to delegate, kies **General, Property Specific en Creation/deletion of specific child objects** onder de permissies: klik op **Full Control**, klik **Next** & **Finish**
### We hebben nu full permission toegewezen aan de primary site server computer account op de **System Management** container .

## Extending Active Directory Schema

- Hiervoor moet de Disk ingevoerd worden van SCCM, de .iso file die op de USB staat. Genaamd: **mu_system_center_configuration_manager_endpoint_protection_version_1606_x86_x64_dvd_9384954**
- Lokaliseer de **extadsch.exe** die kan gevonden worden in **D:\SMSSETUP\BIN\X64** van de configuratie manager setup DVD. Houd Shift ingedrukt en rechter klik op **extadsch.exe**, klik op **Copy as Path**

- Launch de **command prompt** bij voorkeur als Administrator, paste hier het pad en druk op **ENTER**
- Je dit moeten zien:
	![](https://prajwaldesai.com/wp-content/uploads/2013/11/Installing-Prerequisites-for-Configuration-Manager-2012-R2-Snap13.jpg)

- To verify whether schema extension was successful, open the log file **extadsch.log** located in the root of the system drive. You should see the line “**Successfully extended the Active Directory Schema**”.
