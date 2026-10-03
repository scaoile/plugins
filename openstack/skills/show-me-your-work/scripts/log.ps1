# Append a well-formed row to a show-me-your-work decision log (TSV) in PowerShell.
# Usage: .\log.ps1 <logfile> <phase> <decision> <why> <evidence> <result>
param(
    [Parameter(Mandatory=$true)][string]$LogFile,
    [Parameter(Mandatory=$true)][string]$Phase,
    [Parameter(Mandatory=$true)][string]$Decision,
    [Parameter(Mandatory=$true)][string]$Why,
    [Parameter(Mandatory=$true)][string]$Evidence,
    [Parameter(Mandatory=$true)][string]$Result
)

$logDir = Split-Path -Parent $LogFile
if ($logDir -and -not (Test-Path $logDir)) {
    New-Item -ItemType Directory -Path $logDir -Force | Out-Null
}

if (-not (Test-Path $LogFile) -or (Get-Item $LogFile).Length -eq 0) {
    "ts`tphase`tdecision`twhy`tevidence`tresult" | Out-File -FilePath $LogFile -Encoding utf8 -Append
}

function Clean-Cell([string]$val) {
    if (-not $val) { return "" }
    $v = $val -replace "[\t\r\n]", " "
    if ($v -match '^[=+\-@]') {
        return "'$v"
    }
    return $v
}

$ts = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
$row = "$ts`t$(Clean-Cell $Phase)`t$(Clean-Cell $Decision)`t$(Clean-Cell $Why)`t$(Clean-Cell $Evidence)`t$(Clean-Cell $Result)"
$row | Out-File -FilePath $LogFile -Encoding utf8 -Append
