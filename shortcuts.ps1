Write-Host "Запущенное приложение или путь с .exe, 0 для выхода, ЛОМАЕТСЯ ОТ ПРОБЕЛА В НАЗВАНИЯХ ПАПКОК И ФАЙЛОВ "
while ($true) {
    $output = Read-Host "Name or Path"
    if ($output -eq "0") {
        Write-Host "Пока!"
        break
    }
    $path = $output -replace 'Program Files', "'Program Files'"
    if (($path -like "*.exe") -ne $true) { # если не находит .exe, выполняется
        try {$process = Get-Process $output -ea Stop}
        catch {
            Write-Host "Нет такого приложения!"
            continue
        }
        $path = $process.Path -replace 'Program Files', "'Program Files'"
    }
    $shortcut = Read-Host "Shortcut"
    Add-Content -Path $profile -value("function " + $shortcut + " {Start-Process -FilePath " + $path + " }")
}
