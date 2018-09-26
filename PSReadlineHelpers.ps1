#helper functions for PSReadline v1.2

Function Get-PSReadlineColorOptions {
    [cmdletbinding()]
    Param(
        [ValidateNotNullOrEmpty()]
        [string]$Name = "*color"
    )

    $colorOptions = Get-PSReadlineOption | Select-Object $Name

    #regular expression to parse property name
    [regex]$rx = "(Back|Fore).*"

    $colorOptions.psobject.properties |
        foreach-object {

        $token = $rx.split($_.name)[0]
        if ($token -eq 'DefaultToken') {
            $token = 'None'
        }

        [pscustomobject]@{
            Option    = $_.name
            TokenKind = $Token
            Setting   = $rx.match($_.name)
            Value     = $_.value
        }
    }
}

Function Show-PSReadlineColor {

    [cmdletbinding()]
    Param()

    $h = Get-PSReadlineColorOptions | sort-object TokenKind, Setting |
    Group-object -Property TokenKind -AsHashTable -AsString
    $h.GetEnumerator() | Sort-object Key | foreach-object {
        write-host $($_.key).padright(20) -nonewline
        $bg = $_.value.value[0]
        $fg = $_.value.value[1]
        write-Host (" [ {0} on {1} ]" -f $fg, $bg) -ForegroundColor $fg -BackgroundColor $bg
    }
}

Function Import-PSReadlineColorOptions {

    [cmdletbinding(SupportsShouldProcess)]
    param(
        [Parameter(position = 0 , Mandatory)]
        [ValidateScript( {Test-Path $_})]
        [string]$Path
    )

    $data = Import-CSV -Path $path | Group-object -Property TokenKind

    $data | where-object {$_.name -notmatch 'error|continuation|emphasis'} |
        foreach-object {
        $Token = $_.name
        $Foreground = $_.group.where( {$_.setting -match "fore"}).value
        $Background = $_.group.where( {$_.setting -match "back"}).value

        if ($PSCmdlet.ShouldProcess($Token, "Set foreground to $Foreground and background to $background")) {
            Set-PSReadlineOption -TokenKind $token -ForegroundColor $Foreground -BackgroundColor $Background
        }
    }

    $data | where-object {$_.name -match 'continuation'} |
        foreach-object {
        $Foreground = $_.group.where( {$_.setting -match "fore"}).value
        $Background = $_.group.where( {$_.setting -match "back"}).value

        if ($PSCmdlet.ShouldProcess("ContinuationPrompt", "Set foreground to $Foreground and background to $background")) {
            set-psreadlineoption -continuationPromptBackgroundColor $background -ContinuationPromptForegroundColor $Foreground
        }
    }

    $data | where-object {$_.Name -match 'emphasis'} |
        foreach-object {
        $Foreground = $_.group.where( {$_.setting -match "fore"}).value
        $Background = $_.group.where( {$_.setting -match "back"}).value

        if ($PSCmdlet.ShouldProcess("Emphasis", "Set foreground to $Foreground and background to $background")) {
            set-psreadlineoption -EmphasisBackgroundColor $background -EmphasisForegroundColor $Foreground
        }
    }

    $data | where-object {$_.Name -match 'error'} |
        foreach-object {
        $Foreground = $_.group.where( {$_.setting -match "fore"}).value
        $Background = $_.group.where( {$_.setting -match "back"}).value

        if ($PSCmdlet.ShouldProcess("Error", "Set foreground to $Foreground and background to $background")) {
            set-psreadlineoption -ErrorBackgroundColor $background -ErrorForegroundColor $Foreground
        }
    }
}

Function Optimize-PSReadLineHistory {

    [cmdletbinding(SupportsShouldProcess)]
    Param(
        [Parameter(ValueFromPipeline)]
        [int32]$MaximumLineCount = $MaximumHistoryCount,
        [switch]$Passthru
    )
    Begin {
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Starting $($myinvocation.mycommand)"
        $History = (Get-PSReadlineOption).HistorySavePath
    } #begin

    Process {
        if (Test-Path -path $History) {
            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Measuring $history"
            $myHistory = Get-Content -Path $History

            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Found $($myHistory.count) lines of history"
            $count = $myHistory.count - $MaximumLineCount

            if ($count -gt 0) {
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Trimming $count lines to meet max of $MaximumLineCount lines"
                $myHistory | Select-Object -skip $count -Unique  | Set-Content -Path $History
            }
        }
        else {
            Write-Warning "Failed to find $history"
        }

    } #process

    End {
        If ($Passthru) {
            Get-Item -Path $History
        }
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending $($myinvocation.mycommand)"
    } #end

} #close Name

Function Get-MyPSReadline {
    [cmdletbinding()]
    Param()

    $token.GetEnumerator() | where-object {-not $options.containskey($_.key)} |
        foreach-object {
        $options.add($_.key, $_.value)
    }

    $options

}

Function Get-MyPSReadlineKey {
    [cmdletbinding()]
    Param()

    (Get-PSReadlineKeyHandler).where( {$_.description -match "$($env:username)"})

}
