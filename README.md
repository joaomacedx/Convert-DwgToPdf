# 🖨️ Convert-DwgToPdf 

<div align="center">
  <img alt="GitHub top language" src="https://img.shields.io/github/languages/top/joaomacedx/Convert-DwgToPdf?style=flat" >
  <img alt="Made by João Macêdo" src="https://img.shields.io/badge/made%20by-João%20Macêdo-blue">
 </div>
 
## Overview

Convert-DwgToPdf is a PowerShell script designed to automate the conversion of `.dwg` files to `.pdf`. It utilizes a CSV file containing essential information such as file paths, output directories, and file names for the conversion process. This script is compatible with PowerShell version 7 and above.

## Author

- João Gabriel dos Reis Hermida Macêdo
- E-mail: joaomacedx@gmail.com

## References

- [Amyuni Forum](https://www.amyuni.com/forum/viewtopic.php?f=24&t=2633)
- [GitHub - dwg2pdf](https://github.com/liyanhang1989/dwg2pdf)

## Features

1. **CSV Configuration:** Utilizes a CSV file for input parameters.
2. **Plot Format Handling:** Converts DWG files based on specified plot formats (landscape, portrait).
3. **DWGTrueView Integration:** Utilizes DWGTrueView for conversion.
4. **File Renaming:** Renames converted files and moves them to the specified output path.
5. **Logging:** Generates log messages for each conversion process.

## Usage

1. **Clone or Download:**
   - Clone or download the Convert-DwgToPdf repository to your local machine.

2. **Configure Settings:**
   - Open the `config.json` file and update the following variables:
     - `"input-files-path"`: Path to the CSV file containing conversion information.
     - `"csv-delimiter"`: Delimiter used in the CSV file.
     - `"dwg-true-view-exe-path"`: Path to the DWGTrueView executable.

3. **Execute Script:**
   - Open a PowerShell terminal as an administrator.
   - Navigate to the project directory.
   - Run the script using the command: `.\Main.ps1`
        ``` powershell
        PS Disk:\Convert-DwgToPdf> .\Main.ps1
      ```

4. **Monitor Progress:**
   - The script will process each DWG file based on the specified plot format.
   - Log messages will provide information about the conversion process.

5. **Check Output:**
   - The converted PDF files will be renamed and moved to the specified output path.

## Error Handling

In case of errors during the conversion process, the script will display an error message.

## Notes

- Ensure PowerShell version 7 or above is installed.
- Verify the correctness of the input CSV file and paths before running the script.

---

### Example CSV Input

| Document      | Plot Format | Output Name | Input Path                  | Output Path                |
|---------------|-------------|-------------|-----------------------------|----------------------------|
| Example.dwg   | A4          | Example     | C:\dwgs\Example.dwg         | C:\pdfs\Example            |
