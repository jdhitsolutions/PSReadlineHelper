---
external help file: psreadlinehelper-help.xml
Module Name: psreadlinehelper
online version:
schema: 2.0.0
---

# Get-MyPSReadlineKey

## SYNOPSIS

Get your custom key handlers

## SYNTAX

```yaml
Get-MyPSReadlineKey [<CommonParameters>]
```

## DESCRIPTION

Use this command to display a list of your customized PSReadline key handlers.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-MyPSReadlineKey

Key        Function               Description
---        --------               -----------
Ctrl+h     Open PSReadlineHistory View PSReadline history file with the associated application. [Jeff]
Ctrl+Alt+f Function Menu          Display all functions as menu using Out-GridView. [Jeff]
F7         HistoryList            Show command history with Out-Gridview. [Jeff]
Shift+F1   OnlineCommandHelp      Open online help for the current command. [Jeff]
Alt+w      SaveInHistory          Save current line in history but do not execute. [Jeff]
Ctrl+Alt+j MarkDirectory          Mark the current directory. [Jeff]
Ctrl+j     JumpDirectory          Goto the marked directory.[Jeff]
Alt+j      ShowDirectoryMarks     Show the currently marked directories in a popup. [Jeff]
F11        ListMyHandlers         List my PSReadlineHandlers [Jeff]
```

These are key handlers added with this module.

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/


## RELATED LINKS

[Get-PSReadlineKeyHandler]()