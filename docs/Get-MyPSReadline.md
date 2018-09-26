---
external help file: psreadlinehelper-help.xml
Module Name: psreadlinehelper
online version:
schema: 2.0.0
---

# Get-MyPSReadline

## SYNOPSIS

Get my PSReadline customizations

## SYNTAX

```yaml
Get-MyPSReadline [<CommonParameters>]
```

## DESCRIPTION

Use this command to display your customizations to PSReadline

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-MyPSReadline

Name                           Value
----                           -----
ForegroundColor                Cyan
TokenKind                      String
ContinuationPromptBackgroun... Magenta
HistoryNoDuplicates            True
ErrorForegroundColor           Green
DingTone                       440
MaximumHistoryCount            1000
DingDuration                   300
ContinuationPromptForegroun... White
HistorySaveStyle               SaveIncrementally
```

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

[Get-PSReadlineOption]()

[Get-PSReadlineColorOptions]()