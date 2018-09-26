---
external help file: psreadlinehelper-help.xml
Module Name: psreadlinehelper
online version:
schema: 2.0.0
---

# Show-PSReadlineColor

## SYNOPSIS

Display a colorized version of PSReadline color settings.

## SYNTAX

```yaml
Show-PSReadlineColor [<CommonParameters>]
```

## DESCRIPTION

This command will display the current color settings for PSReadline using the corresponding foreground and background colors. Use Set-PSReadlineOption to change anything that is difficult to read.

## EXAMPLES

### EXAMPLE 1

```powershell
PS C:\> show-psreadlinecolor


Comment              [ DarkGreen on Blue ]
Operator             [ White on Blue ]
Number               [ White on Blue ]
Command              [ Yellow on Blue ]
Type                 [ Gray on Blue ]
Keyword              [ Green on Blue ]
None                 [ DarkYellow on Blue ]
Parameter            [ White on Blue ]
Emphasis             [ Cyan on Blue ]
Variable             [ Green on Blue ]
Error                [ Red on Blue ]
String               [ DarkCyan on Blue ]
Member               [ White on Blue ]
ContinuationPrompt   [ DarkYellow on Blue ]
```

The actual output would be colorized based on the foreground and background color settings.

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Get-PSReadlineOption]()

[Set-PSReadLineOption]()

