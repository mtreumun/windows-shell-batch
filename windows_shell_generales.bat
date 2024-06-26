::COMANDOS EN WINDOWS SHELL BATCH

::placa madre
wmic baseboard get product,Manufacturer,Version,Serialnumber

::memoria RAM
wmic MEMORYCHIP get BankLabel,DeviceLocator,Capacity,Speed

::formatear disco
diskpart
...
list disk
select disk x
clean
convert gpt
create partition primary
format quick fs=ntfs
assign

::saber children de una carpeta
Get-ChildItem * | Foreach {
$Files = Get-ChildItem $_.FullName -Recurse -File
$Size = '{0:N2}' -f (( $Files | Measure-Object -Property Length -Sum).Sum /1GB)
[PSCustomObject]@{Profile = $_.FullName ; TotalObjects = "$($Files.Count)" ; SizeGB = $Size}
}

::children sin limite de espacio
$FormatEnumerationLimit = -1

Get-ChildItem * | Foreach {
    $Files = Get-ChildItem $_.FullName -Recurse -File
    $Size = '{0:N2}' -f (($Files | Measure-Object -Property Length -Sum).Sum /1GB)
    [PSCustomObject]@{
        Profile = $_.FullName;
        TotalObjects = "$($Files.Count)";
        SizeGB = $Size
    }
} | Format-Table -AutoSize

::saber modelo de disco duro
wmic /namespace:\\root\microsoft\windows\storage path msft_disk get Model,BusType

::olvidar credenciales de red (usar en windows + r)
net use * /del
