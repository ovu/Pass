$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

Describe "Pass tests" {
  Context "When listing the file containing one entry"{
      $json = @"
      { "Pass":
        [
          {"Id": "1", "Value": "Hi", "Key": "MyKey"}
        ]
       }
"@
      $result = PassList($json) | out-string
      
      It "Should return just the Id and the Value" {
        $result | Should Be ((@{ "1" = "Hi"}) | out-string)
        }
    }

  Context "When listing the file containing two entries"{
      $json = @"
      { "Pass":
        [
          {"Id": "1", "Value": "Hi", "Key": "MyKey"},
          {"Id": "2", "Value": "Hi2", "Key": "MyKey2"}
        ]
       }
"@
      $result = PassList($json) | out-string

      It "Should return just the Id and the Value" {
        $result | Should Be (([ordered]@{"1" = "Hi"; "2" = "Hi2"}) | out-string)
        }
    }
  }

Describe "Pass with id tests" {
  Context "When searching for an id and it is found in the file" {
      Mock PassWriteToClipboard {}
      $json = @"
      { "Pass":
        [
          {"Id": "1", "Value": "Hi", "Key": "MyKey"}
        ]
       }
"@
      $result = PassSearchId "1" $json

      It "Should copy the Key to the Clipboard" {
        $result | Should Be $True
        Assert-MockCalled PassWriteToClipboard -ParameterFilter {$TextToWrite -eq "MyKey"}
      }
  }

  Context "When searching for an id and it is NOT found in the file" {
      Mock PassWriteToClipboard {}
      $json = @"
      { "Pass":
        [
          {"Id": "1", "Value": "Hi", "Key": "MyKey"}
        ]
       }
"@
      $result = PassSearchId "2" $json

      It "Should return False" {
        $result | Should Be $False
      }
  }
}
