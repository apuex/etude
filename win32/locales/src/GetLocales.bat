https://ss64.com/locale.html#:~:text=PS%20C%3A%3E%20Get-WinSystemLocale%20or%20to%20list%20all%20the,%3D%20Get-CIMInstance%20-computerName%20computer64-ClassName%20Win32_OperatingSystem%20PS%20C%3A%3E%20%5BCultureInfo%5B%5D%5D%24os.MUILanguages

For /f "tokens=3" %%G in ('Reg query "HKCU\Control Panel\International" /v LocaleName') Do Set _locale=%%G Echo %_Locale%