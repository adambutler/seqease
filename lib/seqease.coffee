class Seqease
  config:
    framesQty: 10
    padLength: 3
    inputPrefix: 'input_'
    outputPrefix: 'output_'
    deleteNewFrames: false
    deleteOldFrames: false
    width: 1920
    height: 1080

  easeInOutQuad: (t) ->
    (if t < .5 then 2 * t * t else -1 + (4 - 2 * t) * t)

  easeInOutCube: (t) ->
    if t < .5 then 4 * t * t * t else (t - 1) * (2 * t - 2) * (2 * t - 2) + 1

  getTime: (n) ->
    percent = n / @config.framesQty
    @easeInOutCube(percent)

  getTimeline: ->
    output = []
    for n in [1..@config.framesQty]
      output.push @getTime(n) * @config.framesQty
    return output

  pickFrames: ->
    output = []
    for n in @getTimeline()
      output.push Math.ceil(n)
    return output

  pad: (num) ->
    s = "#{num}"
    s = "0#{s}" while s.length < @config.padLength
    return s

  getRenameInstructionsList: ->
    output = []
    for frame, index in @pickFrames()
      "cp #{@config.inputPrefix}#{@pad(frame)}.png #{@config.outputPrefix}#{@pad(index + 1)}.png"

  getRenameCommands: ->
    @getRenameInstructionsList().join(" && ")

  getProcessCommand: ->
    "ffmpeg -framerate 60 -i #{@config.outputPrefix}%0#{@config.padLength}d.png -s:v #{@config.width}x#{@config.height} -c:v libx264 -profile:v high -crf 20 -pix_fmt yuv420p output.mp4"

  getCleanupCommands: ->
    output = []
    for index in [1..@config.framesQty]
      if @config.deleteNewFrames
        output.push "rm #{@config.outputPrefix}#{@pad(index)}.png"
      if @config.deleteOldFrames
        output.push "rm #{@config.inputPrefix}#{@pad(index)}.png"

    return output.join(" && ")

  getCommands: ->
    stack = [@getRenameCommands(), @getProcessCommand()]
    stack.push(@getCleanupCommands()) if @config.deleteNewFrames || @config.deleteOldFrames
    stack.join(" && ")


module.exports = new Seqease
