Write-Host "Запущенное приложение или путь с .exe, 0 для выхода"
while ($true) {
    $output = Read-Host "Name or Path"
    if ($output -eq "0") {
        Write-Host "Пока!"
        break
    }
    if (($output -like "*.exe") -ne $true) { # если не находит .exe, выполняется
        try {$process = Get-Process $output -ea Stop}
        catch {
            Write-Host "Нет такого приложения!"
            continue
        }
        $arr_path = ($process.Path).Split("\")
    }
    else {
        $arr_path = ($output).Split("\")
    }
    $path = ""
    foreach ($elm in $arr) { 
        if ($elm -like "* *") { $elm = "'$elm'" }
        $path += ($elm + "\")
    }
    $shortcut = Read-Host "Shortcut"
    Add-Content -Path $profile -value("function " + $shortcut + " {Start-Process -FilePath " + $path.Remove($path.Length-1,1) + " }")
}
