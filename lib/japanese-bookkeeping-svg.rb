require_relative 'japanese-bookkeeping-svg/svg_generator'
require_relative 'japanese-bookkeeping-svg/gem_version'

module JapaneseBookkeepingSVG
  def self.journalization(debit, credit, date=nil)
    # check amount
    # draw svg
    SVGGenerator.new do
      line(0, 0, 100, 100)
    end
  end
end
