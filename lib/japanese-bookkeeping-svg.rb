require_relative 'japanese-bookkeeping-svg/svg_generator'
require_relative 'japanese-bookkeeping-svg/gem_version'

module JapaneseBookkeepingSVG
  def self.journalization(debits, credits, date=nil)
    # check amount
    # draw svg
    SVGGenerator.new do
      key_style = {
        'textLength' => 145,
#        'xml:space' => 'preserve'
      }
      value_style = {
        'text-anchor' => 'end'
      }
      y = 0
      debits.map do |key, value|
        y += 16
        text(0, y, '(')
        text(15, y, "#{key}", key_style)
        text(170, y, ')')
        text(280, y, "#{JapaneseBookkeepingSVG.delimited_number(value)}", value_style)
      end
      y = 0
      credits.map do |key, value|
        y += 16
        text(300, y, '(')
        text(315, y, "#{key}", key_style)
        text(470, y, ')')
        text(580, y, "#{JapaneseBookkeepingSVG.delimited_number(value)}", value_style)
      end
    end
  end

  def self.delimited_number(number)
    number.to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1,")
  end
end
