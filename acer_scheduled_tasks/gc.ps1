# GC

# args list
param([string]$content_dir="TV")

# fetch file names from TV and Movie in episode.list
# append glob to each item
# $tv_list format: "D:\TV\..."
# $movie_list format: "D:\Movie\..."
if(-not (Test-Path D:\TV\episode.list -pathType leaf)){
    New-Item -type file -force D:\TV\episode.list
} else {
    $tv_list=Get-Content D:\TV\episode.list | % { [io.path]::GetFileNameWithoutExtension($_)+'*'}
}
if(-not (Test-Path D:\Movie\episode.list -pathType leaf)){
    New-Item -type file -force D:\Movie\episode.list
} else {
    $movie_list=Get-Content D:\Movie\episode.list | % { [io.path]::GetFileNameWithoutExtension($_)+'*'}
}

# append episode.list to array
$tv_list+="episode.list"
$movie_list+="episode.list"

# delete files not in episode.list
Get-ChildItem D:\TV -exclude $tv_list | Remove-Item -force
#Get-ChildItem -exclude $movie_list | Remove-Item -force -whatif

# update episode.list with new episode (do this first in case moving failed, so list is still available)
Get-ChildItem D:\TvNew | Where-Object {$_.name -match '(mp4|avi)'} | Select -ExpandProperty 'Name' | Add-Content D:\TV\episode.list
#Get-ChildItem D:\MovieNew | Where-Object {$_.name -match '(mp4|avi)'} | Select -ExpandProperty 'Name' | Add-Content D:\TV\episode.list

# move new episodes to TV/Movie dir
Get-ChildItem D:\TvNew | Move-Item -Destination D:\TV -force
#Get-ChildItem D:\MovieNew | Move-Item -Destination D:\Movie -force