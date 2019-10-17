# ArchiveMetaToKodiNfo
Quick and dirty script to convert archive.org metadata to Kodi nfo format. It has been nearly 10 years since I have done perl so most of this was copy paste from SO.

usage ./arcToKodi.pl <path>

The path should contain subdirectories witht he media and metadata in them. In the below example you would run 
```
./arcToKodi.pl /home/george/foo
```
  
* /home/george/foo
  * bar
    * video.divx
    * video_meta.xml
  * peanut
    * video.divx
    * video_meta.xml


This should clean up all of the extra files as well

find . -name \*.jpg -type f -delete

find . -name \*_reviews.xml -type f -delete

find . -name \*_files.xml -type f -delete

find . -name \*.mp4 -type f -delete

find . -name \*.ogv -type f -delete

find . -name \*.gif -type f -delete

find . -name \*.idx -type f -delete

find . -name \*.torrent -type f -delete

find . -name \*.thumbs -type d -delete
