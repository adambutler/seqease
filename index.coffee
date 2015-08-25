class Seqease
  easeInOutQuad: (t) ->
    (if t < .5 then 2 * t * t else -1 + (4 - 2 * t) * t)

  easeInOutCube: (t) ->
    if t < .5 then 4 * t * t * t else (t - 1) * (2 * t - 2) * (2 * t - 2) + 1

  getTime: (n) ->
    percent = n / @max
    @easeInOutCube(percent)

  getTimeline: ->
    output = []
    for n in [1..@max]
      output.push @getTime(n) * @max
    return output

  pickFrames: ->
    output = []
    for n in @getTimeline()
      output.push Math.ceil(n)
    return output

  pad: (num) ->
    s = "#{num}"
    s = "0#{s}" while s.length < @padLength
    return s

  getRenameInstructionsList: ->
    output = []
    for frame, index in @pickFrames()
      "cp #{@inputPrefix}#{@pad(frame)}.png #{@outputPrefix}#{@pad(index)}.png"

  getRenameCommand: ->
    @getRenameInstructionsList().join(" && ")

  constructor: (@max = 1, @padLength = 3, @inputPrefix = 'input_', @outputPrefix = 'output_') ->
    # Do nothing

seqease = new Seqease(100, 5, "input_", "output_")
console.log(seqease.getRenameCommand())
