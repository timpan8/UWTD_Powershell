<# This form was created using POSHGUI.com  a free online gui designer for PowerShell
.NAME
    Untitled
#>

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = '324,266'
$Form.text                       = "Viaplay"
$Form.TopMost                    = $false

$TextBox_URL                     = New-Object system.Windows.Forms.TextBox
$TextBox_URL.multiline           = $false
$TextBox_URL.width               = 293
$TextBox_URL.height              = 20
$TextBox_URL.location            = New-Object System.Drawing.Point(9,40)
$TextBox_URL.Font                = 'Microsoft Sans Serif,10'
$TextBox_URL.AutoSize            = $false

$Button1                         = New-Object system.Windows.Forms.Button
$Button1.text                    = "Starta"
$Button1.width                   = 60
$Button1.height                  = 30
$Button1.location                = New-Object System.Drawing.Point(124,210)
$Button1.Font                    = 'Microsoft Sans Serif,10'

$CheckBox1                       = New-Object system.Windows.Forms.CheckBox
$CheckBox1.text                  = "Subtitel"
$CheckBox1.Checked               = $true
$CheckBox1.AutoSize              = $false
$CheckBox1.width                 = 95
$CheckBox1.height                = 20
$CheckBox1.location              = New-Object System.Drawing.Point(12,74)
$CheckBox1.Font                  = 'Microsoft Sans Serif,10'

$TextBox_Name                    = New-Object system.Windows.Forms.TextBox
$TextBox_Name.multiline          = $false
$TextBox_Name.width              = 158
$TextBox_Name.height             = 20
$TextBox_Name.location           = New-Object System.Drawing.Point(72,172)
$TextBox_Name.Font               = 'Microsoft Sans Serif,10'
$TextBox_Name.AutoSize           = $false

$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = "Länk till avsnitt:"
$Label1.AutoSize                 = $true
$Label1.width                    = 25
$Label1.height                   = 10
$Label1.location                 = New-Object System.Drawing.Point(14,14)
$Label1.Font                     = 'Microsoft Sans Serif,10'

$Label2                          = New-Object system.Windows.Forms.Label
$Label2.text                     = "Namn på serie/film:"
$Label2.AutoSize                 = $true
$Label2.width                    = 25
$Label2.height                   = 10
$Label2.location                 = New-Object System.Drawing.Point(99,145)
$Label2.Font                     = 'Microsoft Sans Serif,10'

$TextBox_StartEpi                = New-Object system.Windows.Forms.TextBox
$TextBox_StartEpi.multiline      = $false
$TextBox_StartEpi.text           = "1"
$TextBox_StartEpi.width          = 20
$TextBox_StartEpi.height         = 20
$TextBox_StartEpi.location       = New-Object System.Drawing.Point(215,89)
$TextBox_StartEpi.Font           = 'Microsoft Sans Serif,10'
$TextBox_StartEpi.AutoSize       = $false

$TextBox_StopEpi                 = New-Object system.Windows.Forms.TextBox
$TextBox_StopEpi.multiline       = $false
$TextBox_StopEpi.text            = "1"
$TextBox_StopEpi.width           = 22
$TextBox_StopEpi.height          = 20
$TextBox_StopEpi.location        = New-Object System.Drawing.Point(264,89)
$TextBox_StopEpi.Font            = 'Microsoft Sans Serif,10'
$TextBox_StopEpi.AutoSize        = $false

$Label3                          = New-Object system.Windows.Forms.Label
$Label3.text                     = "Episod"
$Label3.AutoSize                 = $true
$Label3.width                    = 25
$Label3.height                   = 10
$Label3.location                 = New-Object System.Drawing.Point(167,92)
$Label3.Font                     = 'Microsoft Sans Serif,10'

$Label4                          = New-Object system.Windows.Forms.Label
$Label4.text                     = "Till"
$Label4.AutoSize                 = $true
$Label4.width                    = 25
$Label4.height                   = 10
$Label4.location                 = New-Object System.Drawing.Point(241,92)
$Label4.Font                     = 'Microsoft Sans Serif,10'

$Form.controls.AddRange(@($TextBox_URL,$Button1,$CheckBox1,$TextBox_Name,$Label1,$Label2,$TextBox_StartEpi,$TextBox_StopEpi,$Label3,$Label4))

$Button1.Add_Click({invoke-expression ViafreeCheck})





#Write your logic code here
function ViafreeCheck {

$problem = $false




If ($CheckBox1.Checked -eq $true){$subtitles = "a"} else{$subtitles = "v"}
If ($TextBox_URL.Text -match "\bvia\w*\.\w*[/]"){}else{$TextBox_URL.Text = "Fel URL"; $TextBox_URL.Refresh() ;$problem = $true}
if($TextBox_Name.Text -eq $null){$TextBox_Name.Text = $TextBox_URL.text; $TextBox_Name.Refresh()}
if(($TextBox_StartEpi.Text -match "^\d+$") -and ($TextBox_StopEpi.Text -match "^\d+$")){}else{[System.Windows.MessageBox]::Show('Fel på Episodval'); $problem = $true}
if($TextBox_StartEpi.Text -gt $TextBox_StopEpi.Text){[System.Windows.MessageBox]::Show('Fel på Episodval'); $problem = $true}
if($TextBox_Name.text -eq ""){$TextBox_Name.text = $TextBox_URL.Text -replace "[a-zA-Z0-9:./-]*\bprogram/[a-zA-Z]*[/]([a-zA-Z0-9-]*)[a-zA-Z0-9:./-]*", '$1'; $TextBox_Name.Refresh()}

if ($problem -eq $false){Invoke-Expression ViafreeDownload}
}

















function ViafreeDownload {






$FilePath = "C:\uwtd\UWTD_20190519"                                                   #Skriv sökvägen till uwtd-mappen
$viafree = "viafree.exe"                                                               #Behöver bara ändras om programet skulle få nytt namn i nyare versioner
                                  
$url = $TextBox_URL.Text            #Klistra in sökvägen till programet som ska laddas ned och ta bort avsnittsnummret
$name = $TextBox_Name.Text                                                                     #Välj namnet filerna kommer döpas till
                                                                       # a = video&subtitles, v = video, s = subtitles

$EpisodesFrom = $TextBox_StartEpi.Text                                                                    #välj från vilket avsnitt det ska laddas ned 
$Episodes = $TextBox_StopEpi.Text                                                                       #välj antal avsnitt som ska laddas ned






ForEach ($number in $EpisodesFrom..$Episodes ) { 
try {
  $MyProcess = New-Object System.Diagnostics.Process
  
  $MyProcess.StartInfo.FileName = "cmd.exe"
  $MyProcess.StartInfo.Arguments = "arguments for process"
  $MyProcess.StartInfo.UseShellExecute = $false
  $MyProcess.StartInfo.RedirectStandardInput = $true
  $MyProcess.Start()
  $StdIn = $MyProcess.StandardInput
  
  $StdIn.WriteLine("cd $FilePath")
   $StdIn.WriteLine("$viafree")
   $StdIn.WriteLine("$url"+"$number")
   $StdIn.WriteLine("$name"+" $number")
   $StdIn.WriteLine("$subtitles")
   


} finally {
  if($StdIn) {
    $StdIn.Close()
  }
}
}
}











[void]$Form.ShowDialog()
