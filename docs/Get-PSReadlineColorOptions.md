---
external help file: psreadlinehelper-help.xml
Module Name: psreadlinehelper
online version:
schema: 2.0.0
---

# Get-PSReadlineColorOptions

## SYNOPSIS

Get current PSReadline color settings.

## SYNTAX

```yaml
Get-PSReadlineColorOptions [[-Name] <String>] [<CommonParameters>]
```

## DESCRIPTION

Use this command to view your current color options for PSReadline. You might want to export this to a CSV file, edit colors and then use Import-PSReadlineColorOptions to configure your console.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-PSReadLineColorOptions


Option                            TokenKind          Setting              Value
------                            ---------          -------              -----
ContinuationPromptForegroundColor ContinuationPrompt ForegroundColor      White
ContinuationPromptBackgroundColor ContinuationPrompt BackgroundColor    Magenta
DefaultTokenForegroundColor       None               ForegroundColor DarkYellow
CommentForegroundColor            Comment            ForegroundColor      Green
KeywordForegroundColor            Keyword            ForegroundColor      Green
StringForegroundColor             String             ForegroundColor       Cyan
OperatorForegroundColor           Operator           ForegroundColor       Blue
VariableForegroundColor           Variable           ForegroundColor      Green
CommandForegroundColor            Command            ForegroundColor     Yellow
ParameterForegroundColor          Parameter          ForegroundColor       Blue
TypeForegroundColor               Type               ForegroundColor       Gray
NumberForegroundColor             Number             ForegroundColor      White
MemberForegroundColor             Member             ForegroundColor      White
DefaultTokenBackgroundColor       None               BackgroundColor   DarkCyan
CommentBackgroundColor            Comment            BackgroundColor   DarkCyan
KeywordBackgroundColor            Keyword            BackgroundColor   DarkCyan
StringBackgroundColor             String             BackgroundColor   DarkCyan
OperatorBackgroundColor           Operator           BackgroundColor   DarkCyan
VariableBackgroundColor           Variable           BackgroundColor   DarkCyan
CommandBackgroundColor            Command            BackgroundColor   DarkCyan
ParameterBackgroundColor          Parameter          BackgroundColor   DarkCyan
TypeBackgroundColor               Type               BackgroundColor   DarkCyan
NumberBackgroundColor             Number             BackgroundColor   DarkCyan
MemberBackgroundColor             Member             BackgroundColor   DarkCyan
EmphasisForegroundColor           Emphasis           ForegroundColor       Cyan
EmphasisBackgroundColor           Emphasis           BackgroundColor   DarkCyan
ErrorForegroundColor              Error              ForegroundColor        Red
ErrorBackgroundColor              Error              BackgroundColor   DarkCyan
```

### Example 2

```powershell
PS C:\> Get-PSReadlineColorOptions -Name comment*

Option                 TokenKind Setting            Value
------                 --------- -------            -----
CommentForegroundColor Comment   ForegroundColor    Green
CommentBackgroundColor Comment   BackgroundColor DarkCyan
```

Get color options for comments.

## PARAMETERS

### -Name

The name of a color option.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

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

[Show-PSReadlineColor]()

[Import-PSReadlineColorOptions]()
