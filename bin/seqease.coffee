program = require('commander')
exec = require('child_process').exec

program
  .version('1.0.0')
  .option('-f, --framesQty [qty]', 'The amount of frames in your animation', 10)
  .option('-p, --padLength [value]', 'The length of the digits in your file names', 3)
  .option('-i, --inputPrefix [value]', 'A prefix in the file name of your input files', 'input_')
  .option('-o, --outputPrefix [value]', 'A prefix in the file name of any output files', 'output_')
  .option('-d, --deleteOldFrames', 'Delete the original frames?')
  .option('-r, --deleteNewFrames', 'Delete the newly generated frames?')
  .option('-x, --width [value]', 'The width of the movie', 1920)
  .option('-y, --height [value]', 'The height of the movie', 1080)
  .parse process.argv

seqease = require '../lib/seqease'

seqease.config.framesQty       = parseInt(program.framesQty, 10) if program.framesQty?
seqease.config.padLength       = parseInt(program.padLength, 10) if program.padLength?
seqease.config.inputPrefix     = program.inputPrefix             if program.inputPrefix?
seqease.config.outputPrefix    = program.outputPrefix            if program.outputPrefix?
seqease.config.deleteNewFrames = true                            if program.deleteNewFrames
seqease.config.deleteOldFrames = true                            if program.deleteOldFrames
seqease.config.width           = parseInt(program.width, 10)     if program.width?
seqease.config.height          = parseInt(program.height, 10)    if program.height?

exec(seqease.getCommands());
