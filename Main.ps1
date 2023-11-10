#########################################################################################
#########################################################################################
#########################################################################################
# NOTES:
# Made by: João Gabriel dos Reis Hermida Macêdo (joaomacedx@gmail.com)
# - Helping reference: https://www.amyuni.com/forum/viewtopic.php?f=24&t=2633
#                      https://github.com/liyanhang1989/dwg2pdf
# - This PowerShell script is designed to automate the process of converting files in DWG format to PDF. 
# It uses a list in CSV format that contains essential information such as the path of the files to be converted,
# the output directory for the converted PDFs, and the final names of the files.
# This is a PowerShell Script for version 7 or above.
#########################################################################################
#########################################################################################
#########################################################################################
Import-Module -DisableNameChecking  '.\Modules\Helpers\Read-DataFromCSV.psm1'
Import-Module -DisableNameChecking  '.\Modules\Helpers\Get-CurrentLocation.psm1'
Import-Module -DisableNameChecking  '.\Modules\Helpers\Write-LogMessage.psm1'


$configParams = (Get-Content '.\config.json' | Out-String | ConvertFrom-Json)
try {
    $inputFile = $configParams."input-files-path"
    if (!(Test-Path $configParams."input-files-path" -PathType Leaf)) {
        Write-Error "The input file path is not valid"
        return
    }
    $csvDelimiter = $configParams."csv-delimiter"
    $dwgTrueViewPath = $configParams."dwg-true-view-exe-path"

    $currentLocation = Get-CurrentLocation

    $DWGdocuments = Read-DataFromCSV -filePath $inputFile -csvDelimiter $csvDelimiter
    foreach($dwg in $DWGdocuments) {
        if ($dwg."Plot Format" -eq 'A4') {
            Write-LogMessage "|  ----------------------- STARTING ---------------------   |"
            Write-LogMessage "|  Starting $($dwg.Document) conversion in portrait plot format  |"
            & $dwgTrueViewPath $dwg."Input Path" /b "$($currentLocation)/Modules/DWGTrueViewScripts/plot-portrait.scr"
            Start-Sleep -Seconds 40
            Stop-ProcessByName -processName 'dwgviewr'
            Write-LogMessage "| -------------- Stop Process dwgviewr -------------- |"
            $pathRegex = "^(.*\\)(.+)\.DWG$"
            $matches = $dwg."Input Path"| Select-String -Pattern $pathRegex -AllMatches

            if ($matches.Matches.Count -gt 0) {
                $pathBase = $matches.Matches[0].Groups[1].Value
                $fileBaseName = $matches.Matches[0].Groups[2].Value

                $foundFiles = Get-ChildItem -Path $pathBase -Filter "$($fileBaseName)*.pdf"
                if ($foundFiles.Count -gt 0) {
                    foreach ($file in $foundFiles) {
                        Write-LogMessage "| --------------  Renaming file to $($dwg."Output Name").pdf --------------   |"
                        Rename-Item -Path $file.FullName -NewName "$($dwg."Output Name").pdf"
                        Write-LogMessage "|  Moving the converted file to the destination path - $($dwg."Output Path")  |"
                        Move-Item -Path  "$($pathBase + $dwg."Output Name").pdf" -Destination $dwg."Output Path"
                    }
                } else {
                    Write-LogMessage "| No matching files found to $($fileBaseName) in $($pathBase) |"
                }
            } else {
                Write-LogMessage "| File naming pattern not found in path |"
            }
            Write-LogMessage "|  ----------------------- FINISH -----------------------   |"
        } else {
            Write-LogMessage "|  ----------------------- STARTING ---------------------   |"
            Write-LogMessage "|  Starting $($dwg.Document) conversion in landscape plot format  |"
            & $dwgTrueViewPath $dwg."Input Path" /b "$($currentLocation)/Modules/DWGTrueViewScripts/plot-landscape.scr"
            Start-Sleep -Seconds 40
            Stop-ProcessByName -processName 'dwgviewr'
            Write-LogMessage "| -------------- Stop Process dwgviewr -------------- |"
            $pathRegex = "^(.*\\)(.+)\.DWG$"
            $matches = $dwg."Input Path"| Select-String -Pattern $pathRegex -AllMatches

            if ($matches.Matches.Count -gt 0) {
                $pathBase = $matches.Matches[0].Groups[1].Value
                $fileBaseName = $matches.Matches[0].Groups[2].Value

                $foundFiles = Get-ChildItem -Path $pathBase -Filter "$($fileBaseName)*.pdf"
                if ($foundFiles.Count -gt 0) {
                    foreach ($file in $foundFiles) {
                        Write-LogMessage "| --------------  Renaming file to $($dwg."Output Name").pdf --------------   |"
                        Rename-Item -Path $file.FullName -NewName "$($dwg."Output Name").pdf"
                        Write-LogMessage "|  Moving the converted file to the destination path - $($dwg."Output Path")  |"
                        Move-Item -Path  "$($pathBase + $dwg."Output Name").pdf" -Destination $dwg."Output Path"
                    }
                } else {
                    Write-LogMessage "| No matching files found to $($fileBaseName).pdf in $($pathBase) |"
                }
            } else {
                Write-LogMessage "| File naming pattern not found in path |"
            }
            Write-LogMessage "|  ----------------------- FINISH -----------------------   |"
        }
    }
} catch {
    Write-Error "An error has occurred: $_"
}
