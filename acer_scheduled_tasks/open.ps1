
# args list
param([string]$content_dir="TV")


# open first episode in TV/Movie shows
# update episode.list first
#$episodes=(Get-ChildItem "D:\$content_dir" | Where-Object {$_.name -match '(mp4|avi)'} | Select -ExpandProperty 'Name')

# save mp4|avi in extension from gc
$episodes=Get-Content "D:\$content_dir\episode.list"

IF ($episodes.count -gt 1)
{
    Set-Content "D:\$content_dir\episode.list" $episodes[1 .. ($episodes.length-1)]
} ELSE {
    Set-Content "D:\$content_dir\episode.list" ""
}

# open episode with shebulan
Stop-Process -ProcessName shebulan -ErrorAction SilentlyContinue

$video="D:\TV\" +$episodes[0]
& "C:\Program Files (x86)\ShebulanGroup\舌不烂复读软件V1.6.1\shebulan.exe" $video