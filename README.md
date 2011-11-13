This program takes a single FLAC file and a corresponding CUE file and splits the file out into individual tracks, then tags the file with the details from the CUE file.

# External dependencies

   * [FLAC](http://flac.sourceforge.net/)
   * [shntool](http://etree.org/shnutils/shntool/)
   * [cuetools](http://developer.berlios.de/projects/cuetools/)

# Example

<pre>
$ ./split-and-tag.rb --help
Usage: split-and-tag [options]
        --cue FILE                   CUE file
        --src FILE                   Source file
$ ./split-and-tag.rb --cue Miles\ Davis\ -\ Ascenseur\ Pour\ L\'Echafaud.cue --src Miles\ Davis\ -\ Ascenseur\ Pour\ L\'Echafaud.flac 
shntool [split]: warning: discarding initial zero-valued split point
Splitting [Miles Davis - Ascenseur Pour L'Echafaud.flac] (74:18.00) --> [split-track01.flac] (2:51.00) : 100% OK
Splitting [Miles Davis - Ascenseur Pour L'Echafaud.flac] (74:18.00) --> [split-track02.flac] (2:12.00) : 100% OK
Splitting [Miles Davis - Ascenseur Pour L'Echafaud.flac] (74:18.00) --> [split-track03.flac] (2:20.00) : 100% OK
Splitting [Miles Davis - Ascenseur Pour L'Echafaud.flac] (74:18.00) --> [split-track04.flac] (2:13.00) : 100% OK
Splitting [Miles Davis - Ascenseur Pour L'Echafaud.flac] (74:18.00) --> [split-track05.flac] (2:52.50) : 100% OK
Splitting [Miles Davis - Ascenseur Pour L'Echafaud.flac] (74:18.00) --> [split-track06.flac] (3:58.25) : 100% OK
Splitting [Miles Davis - Ascenseur Pour L'Echafaud.flac] (74:18.00) --> [split-track07.flac] (0:55.25) : 100% OK
Splitting [Miles Davis - Ascenseur Pour L'Echafaud.flac] (74:18.00) --> [split-track08.flac] (2:04.50) : 100% OK
Splitting [Miles Davis - Ascenseur Pour L'Echafaud.flac] (74:18.00) --> [split-track09.flac] (2:54.25) : 100% OK
Splitting [Miles Davis - Ascenseur Pour L'Echafaud.flac] (74:18.00) --> [split-track10.flac] (3:56.50) : 100% OK
Splitting [Miles Davis - Ascenseur Pour L'Echafaud.flac] (74:18.00) --> [split-track11.flac] (2:27.37) : 100% OK
Splitting [Miles Davis - Ascenseur Pour L'Echafaud.flac] (74:18.00) --> [split-track12.flac] (5:25.63) : 100% OK
Splitting [Miles Davis - Ascenseur Pour L'Echafaud.flac] (74:18.00) --> [split-track13.flac] (2:55.50) : 100% OK
Splitting [Miles Davis - Ascenseur Pour L'Echafaud.flac] (74:18.00) --> [split-track14.flac] (3:02.00) : 100% OK
Splitting [Miles Davis - Ascenseur Pour L'Echafaud.flac] (74:18.00) --> [split-track15.flac] (2:08.00) : 100% OK
Splitting [Miles Davis - Ascenseur Pour L'Echafaud.flac] (74:18.00) --> [split-track16.flac] (2:16.00) : 100% OK
Splitting [Miles Davis - Ascenseur Pour L'Echafaud.flac] (74:18.00) --> [split-track17.flac] (2:14.25) : 100% OK
Splitting [Miles Davis - Ascenseur Pour L'Echafaud.flac] (74:18.00) --> [split-track18.flac] (4:00.00) : 100% OK
Splitting [Miles Davis - Ascenseur Pour L'Echafaud.flac] (74:18.00) --> [split-track19.flac] (3:11.00) : 100% OK
Splitting [Miles Davis - Ascenseur Pour L'Echafaud.flac] (74:18.00) --> [split-track20.flac] (3:05.00) : 100% OK
Splitting [Miles Davis - Ascenseur Pour L'Echafaud.flac] (74:18.00) --> [split-track21.flac] (4:09.00) : 100% OK
Splitting [Miles Davis - Ascenseur Pour L'Echafaud.flac] (74:18.00) --> [split-track22.flac] (2:04.25) : 100% OK
Splitting [Miles Davis - Ascenseur Pour L'Echafaud.flac] (74:18.00) --> [split-track23.flac] (2:42.62) : 100% OK
Splitting [Miles Davis - Ascenseur Pour L'Echafaud.flac] (74:18.00) --> [split-track24.flac] (2:58.00) : 100% OK
Splitting [Miles Davis - Ascenseur Pour L'Echafaud.flac] (74:18.00) --> [split-track25.flac] (3:00.00) : 100% OK
Splitting [Miles Davis - Ascenseur Pour L'Echafaud.flac] (74:18.00) --> [split-track26.flac] (2:20.38) : 100% OK
$ ls \*.flac
Miles Davis - Ascenseur Pour L'Echafaud.flac	split-track09.flac				split-track18.flac
split-track01.flac				split-track10.flac				split-track19.flac
split-track02.flac				split-track11.flac				split-track20.flac
split-track03.flac				split-track12.flac				split-track21.flac
split-track04.flac				split-track13.flac				split-track22.flac
split-track05.flac				split-track14.flac				split-track23.flac
split-track06.flac				split-track15.flac				split-track24.flac
split-track07.flac				split-track16.flac				split-track25.flac
split-track08.flac				split-track17.flac				split-track26.flac
</pre>
