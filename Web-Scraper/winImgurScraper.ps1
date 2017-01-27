###PUT CODE IN A SINGLE LOOP if possibru
param(
    [string]$URL
)

###create dir based on post name###
$dirName = "post-"
$indexSlash = $URL.LastIndexOf('/')
$postNameLength = $URL.Length - $indexSlash
$urlDir = $URL.Substring($indexSlash + 1, $postNameLength - 1)
$dirName = $dirName + $urlDir
#New-Item -Name $dirName -ItemType directory -Path $PWD

#find full path to dir for dl and go to it
[string]$outputDir = $PWD
$fullPath = $outputDir + "\" + $dirName + "\" + $urlDir
#Set-Location -Path $dirName

#go to the album version of the supplied URL
#http://imgur.com/gallery/btHMP
#becomes http://imgur.com/a/btHMP?grid
$albumURL = $URL + "?grid"
$albumURL = $albumURL.Replace("gallery", "a")
#Invoke-WebRequest -Uri $albumURL -Outfile $fullPath

#parse for {"hash":" and get file name IGSiv8v, and file ext
$webFile = $urlDir
$metaData = @()
$fileMetadata = @()
$imgurFiles = @()
$imgurExt = @()
$i = 0
foreach($line in Get-Content $webFile)
{
    #1 big line starts with _item:, no other line does, even if there are 2 with similar metadata
    if($line -match "_item:")
    {
        #split each line, closer to parsing for what we need
        $metadata += $line.Split("}") 
    }
}

#search for relevant lines with files & its metadata
foreach($meta in $metadata)
{
    if($meta -match "{`"hash`":`"")
    {
        $fileMetadata += $meta
    }
}
#verify the lines
foreach($meta in $fileMetadata)
{
    if($i -eq 0) #first one requires more parsing
    {
        $meta = $meta.Split('[')[1]
    }
    $imgurFiles += $meta.Split('`"')[3]
    $imgurExt += $meta.Split('`"')[19]

    $i++
}
Write-Host $i

#then create http://i.imgur.com/IGSiv8v.jpg
$imgurLinks = @()
$j = 0
while($j -lt $i)
{
    $imgurLinks += "http://i.imgur.com/" + $imgurFiles[$j] + $imgurExt[$j]
    $j++
}
$k = 0
foreach($bla in $imgurLinks)
{ Write-Host $imgurFiles }
#absolute path - outfile requires file name too
#Invoke-WebRequest -Uri $URL -Outfile $fullPath


#links you need
#http://imgur.com/gallery/4W6ER
#http://imgur.com/a/4W6ER?grid
#view-source:http://imgur.com/a/btHMP?grid

#maybe use this later "num_images":"22"
