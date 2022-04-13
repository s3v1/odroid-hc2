# Video

## Remux MKV to MP4

    sudo apt-get install -y ffmpeg


    ffmpeg -hwaccel auto -find_stream_info -fflags +genpts -i %1 -map 0 -codec copy "%~dpn1.mp4
