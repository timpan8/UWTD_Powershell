$FilePath = "C:\uwtd\"                                                   #Skriv sökvägen till uwtd-mappen
$viafree = "viafree.exe"                                                               #Behöver bara ändras om programet skulle få nytt namn i nyare versioner
                                  
$url = "https://www.viafree.se/program/reality/pappaliv/sasong-1/avsnitt-"             #Klistra in sökvägen till programet som ska laddas ned och ta bort avsnittsnummret
$name = "Pappaliv"                                                                      #Välj namnet filerna kommer döpas till
$subtitles = "a"                                                                       # a = video&subtitles, v = video, s = subtitles

$EpisodesFrom = "1"                                                                    #välj från vilket avsnitt det ska laddas ned 
$Episodes = "20"                                                                        #välj antal avsnitt som ska laddas ned






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
