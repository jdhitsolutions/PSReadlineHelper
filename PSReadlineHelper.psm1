#not all commands and features of this module will not work with PSReadline version 2.0.

$ver = (get-module psreadline).version

. $psscriptroot\PSReadlinehelpers.ps1

#region my PSReadlineOptions


$options = @{
    HistoryNoDuplicates = $True
    HistorySaveStyle = "SaveIncrementally"
    DingDuration = 300
    DingTone = 440
    MaximumHistoryCount = 1000
}

Set-PSReadlineOption @options

#endregion

#region my PSReadlineKey handlers

Set-PSReadlineKeyHandler -key F12 -Function CaptureScreen

#Add [$($env:username)] to the end of every description so that I can search for my handlers
Set-PSReadlineKeyHandler -key Ctrl+h -BriefDescription "Open PSReadlineHistory" -Description "View PSReadline history file with the associated application. [$($env:username)]" -ScriptBlock {

    #open the history file with the associated application for .txt files, probably Notepad.
    Invoke-Item -Path $(Get-PSReadlineOption).HistorySavePath
}

if ($PSedition -eq 'Desktop' -OR $IsWindows) {

    Set-PSReadlineKeyHandler -key Ctrl+Alt+F -BriefDescription "Function Menu" -Description "Display all functions as menu using Out-GridView. [$($env:username)]" -ScriptBlock {

        $line = $null
        $cursor = $null
        [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

        #filter out the built-in functions for changing drives and a few others
        Get-Childitem -path function: | Where-Object {$_.name -notmatch "([A-Za-z]:)|(Get-Verb)|(prompt)|(cd)|(clear-host)|(more)|(pause)"} |
        select-object Name, Version, Source, @{Name = "Syntax"; Expression = {(Get-Command $_.name -Syntax|Out-String).Trim()}} |
        Out-GridView -title "Function Menu: Select one to run" -OutputMode Single |
        Foreach-Object {
            Show-Command -Name $_.name
        }
    }

    Set-PSReadlineKeyHandler -Key F7 -BriefDescription HistoryList -Description "Show command history with Out-Gridview. [$($env:username)]" -ScriptBlock {
        $pattern = $null
        [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$pattern, [ref]$null)
        if ($pattern) {
            $pattern = [regex]::Escape($pattern)
        }

        $history = [System.Collections.ArrayList]@(
            $last = ''
            $lines = ''
            foreach ($line in [System.IO.File]::ReadLines((Get-PSReadlineOption).HistorySavePath)) {
                if ($line.EndsWith('`')) {
                    $line = $line.Substring(0, $line.Length - 1)
                    $lines = if ($lines) {
                        "$lines`n$line"
                    }
                    else {
                        $line
                    }
                    continue
                }

                if ($lines) {
                    $line = "$lines`n$line"
                    $lines = ''
                }

                if (($line -cne $last) -and (!$pattern -or ($line -match $pattern))) {
                    $last = $line
                    $line
                }
            }
            )
            $history.Reverse()

            $command = $history | Select-Object -unique | Out-GridView -Title "PSReadline History - Select a command to insert at the prompt" -OutputMode Single
            if ($command) {
                [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
                [Microsoft.PowerShell.PSConsoleReadLine]::Insert(($command -join "`n"))
            }
        }

        Set-PSReadlineKeyHandler -key Alt+F5 -BriefDescription "ListMyHandlers" -Description "List my PSReadlineHandlers [$env:username]" -ScriptBlock {

            (Get-PSReadlineKeyHandler -bound ).Where( {$_.description -match "\[$env:username\]"}) |
            Select-Object -Property Key,Description | Out-GridView -title "My handlers"
        }
} #if desktop

    Set-PSReadlineKeyHandler -Key Shift+F1 -BriefDescription OnlineCommandHelp -LongDescription "Open online help for the current command. [$($env:username)]" -ScriptBlock {

        $ast = $null
        $tokens = $null
        $errors = $null
        $cursor = $null
        [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$ast, [ref]$tokens, [ref]$errors, [ref]$cursor)

        $commandAst = $ast.FindAll( {
            $node = $args[0]
            $node -is [System.Management.Automation.Language.CommandAst] -and
            $node.Extent.StartOffset -le $cursor -and
            $node.Extent.EndOffset -ge $cursor
        }, $true) | Select-Object -Last 1

    if ($commandAst -ne $null) {
        $commandName = $commandAst.GetCommandName()
        if ($commandName -ne $null) {
            $command = $ExecutionContext.InvokeCommand.GetCommand($commandName, 'All')
            if ($command -is [System.Management.Automation.AliasInfo]) {
                $commandName = $command.ResolvedCommandName
            }

            if ($commandName -ne $null) {
                Get-Help $commandName -online
            }
        }
    }
}

Set-PSReadlineKeyHandler -Key Alt+w -BriefDescription SaveInHistory -LongDescription "Save current line in history but do not execute. [$($env:username)]" -ScriptBlock {

    $line = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
    [Microsoft.PowerShell.PSConsoleReadLine]::AddToHistory($line)
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
}

# Ctrl+Alt+j then type a key to mark the current directory.
# Alt+J to show the current shortcuts in a popup
# Ctrj+j then the same key will change back to that directory without
# needing to type cd and won't change the command line.

#pre-populate a global variable
$PSReadlineMarks = @{
    [char]"s" = "c:\scripts"
    [char]"d" = "~\documents"
}

Set-PSReadlineKeyHandler -Key Ctrl+Alt+j -BriefDescription MarkDirectory -LongDescription "Mark the current directory. [$($env:username)]" -ScriptBlock {

    #press a single character to mark the current directory
    $key = [Console]::ReadKey($true)
    if ($key.keychar -match "\w") {
        $global:PSReadlineMarks[$key.KeyChar] = $pwd
    }
    else {
        [Microsoft.PowerShell.PSConsoleReadLine]::Ding()
        Write-Warning "You entered an invalid character."
        [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
    }
}

Set-PSReadlineKeyHandler -Key Ctrl+j -BriefDescription JumpDirectory -LongDescription "Goto the marked directory.[$($env:username)]" -ScriptBlock {

    $key = [Console]::ReadKey()
    $dir = $global:PSReadlineMarks[$key.KeyChar]
    if ($dir) {
        set-location $dir
        [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
    }
}

Set-PSReadlineKeyHandler -Key Alt+j -BriefDescription ShowDirectoryMarks -LongDescription "Show the currently marked directories. [$($env:username)]" -ScriptBlock {

    $data = $global:PSReadlineMarks.GetEnumerator() | Where-object {$_.key} | Sort-object key
    $data | foreach-object -begin {
        $text = @"
Key`tDirectory
---`t---------

"@
    } -process {

        $text += "{0}`t{1}`n" -f $_.key, $_.value
    }

    if ($PSedition -eq 'Desktop' -or $IsWindows) {
        $ws = New-Object -ComObject Wscript.Shell
        $ws.popup($text, 10, "Use Ctrl+J to jump") | Out-Null
        [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
    }  else {
        write-host "`n$text`n" -ForegroundColor Yellow
    }

}

#endregion

Export-ModuleMember -Variable PSReadlineMarks -Function 'Optimize-PSReadlineHistory','Get-MyPSReadline','Get-MyPSReadlineKey'
