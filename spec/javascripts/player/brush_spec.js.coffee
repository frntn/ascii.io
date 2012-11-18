describe 'AsciiIo.Brush', ->

  describe '.clearCache', ->

    it 'resets cache hash', ->
      AsciiIo.Brush.create()
      expect(_(AsciiIo.Brush.cache).keys().length > 0).toBeTruthy()
      AsciiIo.Brush.clearCache()
      expect(_(AsciiIo.Brush.cache).keys().length).toEqual(0)

  describe '.hash', ->

    it 'returns string with all brush properties', ->
      attrs =
        fg       : 1
        bg       : 2
        blink    : false
        bright   : true
        italic   : false
        underline: true

      hash = AsciiIo.Brush.hash attrs
      expect(hash).toEqual '1_2_false_true_false_true'

  describe '.create', ->

    beforeEach ->
      AsciiIo.Brush.clearCache()

    it 'returns new brush instance if not cached', ->
      brush = AsciiIo.Brush.create({ fg: 1 })
      expect(brush instanceof AsciiIo.Brush).toBeTruthy()

    it 'returns existing brush instance if cached', ->
      brush = AsciiIo.Brush.create({ fg: 1 })
      otherBrush = AsciiIo.Brush.create({ fg: 1, bg: 100 })
      anotherBrush = AsciiIo.Brush.create({ fg: 1 })

      expect(_(AsciiIo.Brush.cache).keys().length).toEqual(2)
      expect(brush is anotherBrush).toBeTruthy()

  describe '#fgColor', ->

    it 'returns 7 if fg is undefined', ->
      brush = new AsciiIo.Brush fg: undefined
      expect(brush.fgColor()).toEqual 7

    it 'returns fg+8 if bright is on', ->
      brush = new AsciiIo.Brush fg: 3, bright: true
      expect(brush.fgColor()).toEqual 11

  describe '#bgColor', ->

    it 'returns 0 if bg is undefined', ->
      brush = new AsciiIo.Brush bg: undefined
      expect(brush.bgColor()).toEqual 0

    it 'returns bg+8 if blink is on', ->
      brush = new AsciiIo.Brush bg: 4, blink: true
      expect(brush.bgColor()).toEqual 12

  describe '#attributes', ->

    it 'includes fg, bg, blink, bright, italic, underline', ->
      brush = new AsciiIo.Brush
      attrs = brush.attributes()
      expectedAttrs = ['fg', 'bg', 'blink', 'bright', 'italic', 'underline']

      expect(_(attrs).keys().length).toEqual _(expectedAttrs).keys().length

      for attr in expectedAttrs
        expect(_(attrs).has(attr)).toBeTruthy()
