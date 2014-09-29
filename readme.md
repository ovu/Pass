Pass
====

Pass is a passphrase reminder written in Powershell.


Configuration
-------------
1. Create a json file containing the passphrase. It should have the following format:

        { "Pass":
        [
          {"Id": "1", "Value": "Description", "Key": "PassPhrase1"},
          {"Id": "2", "Value": "Description2", "Key": "PassPhrase2"}
        ]
        }

2. Save the json file in a directory. We will name the directory to the file \<PASS_FILE_PATH\>
3. Copy the powershell scripts in a directory <PASS_DIR>
4. Add the following lines to your Powershell profile

        . "<PASS_DIR>passRunner.ps1" 

        PassRunner "<PASS_FILE_PATH>"

Usage
-----

1. List your passphrases

Execute in the prompt: Pass

2. Get one passphrase in the clipboard

Execute in the prompt: PassId <Id>
