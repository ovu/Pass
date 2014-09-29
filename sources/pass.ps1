function PassList(){
    param (
        [string] $JsonFile
    )
    $result = [ordered]@{}

    $json = $JsonFile |  ConvertFrom-Json

    foreach($entry in $json.Pass){
        $result += [ordered] @{ $entry.Id = $entry.Value }
    }

    return $result
}

function PassWriteToClipboard(){
  param ([string] $TextToWrite)
  add-type -an system.windows.forms
  [System.Windows.Forms.Clipboard]::SetText($TextToWrite)
}

function PassSearchId() {
  param ([string] $Id,
         [string] $JsonFile
  )

    $json = $JsonFile |  ConvertFrom-Json

    foreach($entry in $json.Pass){
      if ($entry.Id -eq $Id){
        PassWriteToClipboard $entry.Key
        return $True
      }
    }

    return $False
}
