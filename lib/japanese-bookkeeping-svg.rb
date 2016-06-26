require_relative 'japanese-bookkeeping-svg/svg_generator'
require_relative 'japanese-bookkeeping-svg/gem_version'

module JapaneseBookkeepingSVG
  def self.journalization(debits, credits, date=nil)
    # check amount
    # draw svg
    SVGGenerator.new do
      style = {
        'textLength' => 180
      }
      y = 0
      debits.map do |key, value|
        y += 16
        text(0, y, "(#{key})", style)
        text(200, y, "#{JapaneseBookkeepingSVG.delimited_number(value)}")
      end
      y = 0
      credits.map do |key, value|
        y += 16
        text(400, y, "(#{key})", style)
        text(600, y, "#{JapaneseBookkeepingSVG.delimited_number(value)}")
      end
    end
  end

  def self.delimited_number(number)
    number.to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1,")
  end
end
