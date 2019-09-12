# UWTD_Powershell
Ladda ner programet här https://www.uwtd.me/filer/



<h3>Viafree auto download</h3>

I Scriptet kan du välja vilka epesoder som ska ladddas ned från viafree. 
Följande variablar måste fyllas i:

$FilePath = "C:\uwtd\"    #Skriv sökvägen till uwtd-mappen
$viafree = "viafree.exe"    #Behöver bara ändras om programet skulle få nytt namn i nyare versioner
$url = "https://avsnitt-"     #Klistra in sökvägen till programet som ska laddas ned och ta bort avsnittsnummret
$name = "Pappaliv"   #Välj namnet filerna kommer döpas till
$subtitles = "a"     # a = video&subtitles, v = video, s = subtitles
$EpisodesFrom = "1"    #välj från vilket avsnitt det ska laddas ned 
$Episodes = "20"      #välj antal avsnitt som ska laddas ned



