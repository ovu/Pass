$global:PassJsonFilePath = "";

function PassRunner() {
   param ([string] $PassFile)
   $global:PassJsonFilePath = $PassFile
}

. "$PSScriptRoot\pass.ps1"

function Pass() {
        $jsonFile = (Get-Content $global:PassJsonFilePath | Out-String)
        PassList $jsonFile | out-string
} 

function PassId() {
  param ([string] $Id)
        $jsonFile = (Get-Content $global:PassJsonFilePath | Out-String)
       PassSearchId $Id $jsonFile | out-string
}
