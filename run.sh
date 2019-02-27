docker run --runtime=nvidia -ti -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix -v $(pwd):/workspace --workdir=/workspace bullet3
