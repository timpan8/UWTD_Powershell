$list = "c:\temp\lista.txt"


$serier = get-content $list
$date = get-date



foreach($avsnitt in $serier)
    {

[int]$Episode = [regex]::Matches($avsnitt, '{([^/)]+)}')  | ForEach-Object { $_.Groups[1].Value }
[int]$TotalEpisodes = [regex]::Matches($avsnitt, '\[([^]+\.]+)]') | ForEach-Object { $_.Groups[1].Value }


$NextEpisode = $Episode+1
$countdown = $TotalEpisodes-1


    if($avsnitt.StartsWith(1)){$day = "Monday"}
    if($avsnitt.StartsWith(2)){$day = "Tuesday"}
    if($avsnitt.StartsWith(3)){$day = "Wednesday"}
    if($avsnitt.StartsWith(4)){$day = "Thursday"}
    if($avsnitt.StartsWith(5)){$day = "Friday"}
    if($avsnitt.StartsWith(6)){$day = "Saturday"}
    if($avsnitt.StartsWith(7)){$day = "Sunday"}
    if($avsnitt.StartsWith(8)){$day = $date.DayOfWeek;}

    if(($date.DayOfWeek -eq $day) -and ($TotalEpisodes -gt "0")){

    echo $day

    if($avsnitt -match '\**') {$serier.Replace('**', $Episode)}
    if($avsnitt -like "*viaplay*"){ Invoke-Expression "viaplay"}
    if($avsnitt -like "*dplay*"){ Invoke-Expression "dplay"}
    
    }
                                }


    function viaplay{echo "viaplay"}


    function dplay{echo "dplay"; Invoke-Expression loop}




    
    

     

                  




function loop {
                $CountDownLoop =  $avsnitt -replace  ('\[([^]+\.]+)]'), "[$countdown]";
                $UpdatedAvsnitt = $CountDownLoop -replace ('{([^/)]+)}'), "{$Nextepisode}"; 
                $serier.Replace($avsnitt, $UpdatedAvsnitt) | Out-File $list;}




    Function download {
                        

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
