# SeqEase

[![npm version](https://badge.fury.io/js/seqease.svg)](http://badge.fury.io/js/seqease)

![seqease demo](https://cloud.githubusercontent.com/assets/1238468/9562217/f3a1a7bc-4e5d-11e5-9c9a-d37cf9a98337.gif)

SeqEase takes a linear animation in the form of a PNG sequence and allows you to create a new animation with easing applied.

### Usage

If you need to add a easing to a video first covert it to an image sequence -

```
ffmpeg -i input.avi -vcodec png input_%05d.png
```

Install seqease -

```
npm install -g seqease
```

Run using the `seqease` command -

```
> seqease -h

  Usage: seqease [options]

  Options:

    -h, --help                  output usage information
    -V, --version               output the version number
    -n, --framesQty [qty]       The amount of frames in your animation
    -p, --padLength [value]     The length of the digits in your file names
    -i, --inputPrefix [value]   A prefix in the file name of your input files
    -o, --outputPrefix [value]  A prefix in the file name of any output files
    -r, --reverse               Reverse the animation
    --deleteOldFrames           Delete the original frames
    --deleteNewFrames           Delete the newly generated frames
    --width [value]             The width of the movie
    --height [value]            The height of the movie
```

Given valid options an inputs this will produce a new animation `output.mp4` in your current directory.

## Contributing

Contributions are welcome, please follow [GitHub Flow](https://guides.github.com/introduction/flow/index.html)
