# SeqEase

![seqease demo](https://cloud.githubusercontent.com/assets/1238468/9562217/f3a1a7bc-4e5d-11e5-9c9a-d37cf9a98337.gif)

SeqEase takes a linear animation in the form of a PNG sequence and allows you to create a new PNG sequence with easing applied.

### Usage

If you need to add a easing to a video first covert it to an image seqence -

```
ffmpeg -i input.avi -vcodec png input_%05d.png
```

Create an script with the following

```javascript
require('seqease')

var totalFrames = 120;
var indexNumberLength = 5;
var inputPrefix = "input_";
var outputPrefix = "output_";

var seqease = new Seqease(totalFrames, indexNumberLength, inputPrefix, outputPrefix);
console.log(seqease.getRenameCommand());
```

When you execute this script it will give you the command to paste into your terminal in the directory that the images are kept.
Doing so will result in a new set of images that represent a PNG sequence with easing applied.

You can then convert the new image sequence to a video using `ffmpeg`.

```
ffmpeg -framerate 60 -i output_%05d.png -s:v 1920x1080 -c:v libx264 -profile:v high -crf 20 -pix_fmt yuv420p ouput.mp4
```

## Contributing

Contributions are welcome, please follow [GitHub Flow](https://guides.github.com/introduction/flow/index.html)
