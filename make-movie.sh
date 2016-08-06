:
if [ -z "$2" ]; then
  echo "Usage: make-movie.sh input-dir output-mp4" 1>&2
  exit 1
fi

input_dir="$1"
output_mp4="$2"

###

setopt shwordsplit 2>/dev/null
shopt -s nullglob 2>/dev/null

_ffmpeg=ffmpeg
avconv --help >/dev/null 2>&1 && ffmpeg=avconv

###

_ffmpeg_threads="-threads 8"
_ffmpeg_input="-f image2 -r 24 -i '$input_dir/%04d.jpg'"
_ffmpeg_quality="-i_qfactor 0.71 -qcomp 0.6 -qmin 10 -qmax 63 -qdiff 4 -trellis 0"
_ffmpeg_output="-vcodec libx264 -pix_fmt yuv420p -profile:v baseline -b:v 1000k"
_ffmpeg_twopass="-movflags faststart"

#ffmpeg -threads 4 -i input_video.mts -i_qfactor 0.71 -qcomp 0.6 -qmin 10 -qmax 63 -qdiff 4 -trellis 0 -vcodec libx264 -s 640x360 -b:v 1000k -b:a 56k -ar 22050 output_video.mp4

exec $_ffmpeg $_ffmpeg_threads $_ffmpeg_input $_ffmpeg_quality $_ffmpeg_output "$output_mp4" $ffmpeg_twopass </dev/null
