module JapaneseBookkeepingSVG
  class SVGGenerator
    def initialize(&block)
      @output = []
      @max_width = 0
      @max_height = 0
      if block
        self.instance_exec(&block)
        self.close
      end
    end

    def close(width=@max_width, height=@max_height)
      unshift_header(width, height)
      push_footer
    end

    def to_s
      @output.join("\n")
    end

    def line(x1, y1, x2, y2, style={})
      s = style.clone
      attrs = ['stroke', 'stroke-width'].map do |attr|
        if s.has_key?(attr)
          %Q[ #{attr}="#{s.delete attr}"]
        else
          ''
        end
      end.join('')
      @output << %Q[<line x1="#{x1}" y1="#{y1}" x2="#{x2}" y2="#{y2}"#{attrs}#{style_attr(s)} />]
      update_max_width_and_height(x2, y2)
    end

    def text(x, y, text, style={})
      s = style.clone
      max_width = self.class.convert_unit(s['textLength'])
      attrs = ['font-family', 'font-size', 'text-anchor', 'textLength', 'xml:space'].map do |attr|
        if s.has_key?(attr)
          %Q[ #{attr}="#{s.delete attr}"]
        else
          ''
        end
      end.join('')

      text_lines = []
      text_lines << %Q[<text x="#{x}" y="#{y}"#{attrs}#{style_attr(s)}>]
      max_width_em = 0
      height_em = 0
      dy = 0
      text.each_line do |line|
        line.chomp!
        text_lines << %Q[<tspan x="#{x}" dy="#{dy}em">#{line}</tspan>]
        dy = 1
        max_width_em = line.size if line.size > max_width_em
        height_em += 1
      end
      text_lines << '</text>'
      @output << text_lines.join('')

      max_width ||= self.class.convert_unit("#{max_width_em}em")
      max_x = x + max_width
      max_y = y + self.class.convert_unit("#{height_em}em")
      update_max_width_and_height(max_x, max_y)
    end

    def self.convert_unit(length)
      return nil if length.nil?
      m = /\A(\d+)(em|ex|px|in|cm|mm|pt|pc)?\z/.match(length.to_s)
      raise ArgumentError, "Unknown length #{length}" unless m
      v = m[1].to_i
      return v if m[2].nil?
      case m[2].intern
      when :em, :ex
        v * 16
      when :px
        v
      when :in
        v * 96
      when :cm
        (v * 96) / 2.54
      when :mm
        (v * 96) / 25.4
      when :pt
        (v * 4).fdiv(3)
      when :pc
        v * 16
      end
    end

    private

    def update_max_width_and_height(width, height)
      @max_width = [width, @max_width].max
      @max_height = [height, @max_height].max
    end

    def style_attr(style)
      return '' if style.empty?
      ' style="' + style.map do |key, value|
        "#{key}:#{value}"
      end.join(' ') + '"'
    end

    def unshift_header(width, height)
      @output.unshift(<<EOT.chomp)
<?xml version="1.0" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg width="#{width}" height="#{height}" version="1.1" xmlns="http://www.w3.org/2000/svg">
EOT
    end

    def push_footer
      @output << '</svg>'
    end
  end
end
