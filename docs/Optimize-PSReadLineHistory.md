---
external help file: psreadlinehelper-help.xml
Module Name: psreadlinehelper
online version:
schema: 2.0.0
---

# Optimize-PSReadLineHistory

## SYNOPSIS

Optimize the PSReadline history file

## SYNTAX

```yaml
Optimize-PSReadLineHistory [[-MaximumLineCount] <Int32>] [-Passthru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The PSReadline module can maintain a persistent command-line history. However, there are no provisions for managing the file. When the file gets very large, performance starting PowerShell can be affected. This command will trim the history file to a specified length as well as removing any duplicate entries.

## EXAMPLES

### EXAMPLE 1

```powershell
PS C:\> Optimize-PSReadelineHistory
```

Trim the PSReadlineHistory file to default maximum number of lines.

### EXAMPLE 2

```powershell
PS C:\> Optimize-PSReadelineHistory -maximumlinecount 500 -passthru


Directory: C:\Users\Jeff\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadline


    Mode                LastWriteTime         Length Name
    ----                -------------         ------ ----
    -a----        11/2/2017   8:21 AM           1171 ConsoleHost_history.txt
```

Trim the PSReadlineHistory file to 500 lines and display the file listing.

## PARAMETERS

### -MaximumLineCount

Set the maximum number of lines to store in the history file.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: $MaximumHistoryCount
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Passthru

By default this command does not write anything to the pipeline. Use -Passthru to get the updated history file.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### None

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Get-PSReadlineOption]()

[Set-PSReadlineOption]()

