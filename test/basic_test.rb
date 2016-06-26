require 'test_helper'

class BasicTest < Minitest::Test
  def test_journalization
    svg = JapaneseBookkeepingSVG.journalization(
      debit={
        '現金預金': 4000
      },
      credit={
        '売上': 2000,
        '売掛金': 2000
      }
    )

    assert_equal <<SVG.chomp, svg.to_s
<?xml version="1.0" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg width="680" height="48" version="1.1" xmlns="http://www.w3.org/2000/svg">
<text x="0" y="16" textLength="180" style="">
<tspan x="0" dy="0em">(現金預金)</tspan>
</text>
<text x="200" y="16" style="">
<tspan x="200" dy="0em">4,000</tspan>
</text>
<text x="400" y="16" textLength="180" style="">
<tspan x="400" dy="0em">(売上)</tspan>
</text>
<text x="600" y="16" style="">
<tspan x="600" dy="0em">2,000</tspan>
</text>
<text x="400" y="32" textLength="180" style="">
<tspan x="400" dy="0em">(売掛金)</tspan>
</text>
<text x="600" y="32" style="">
<tspan x="600" dy="0em">2,000</tspan>
</text>
</svg>
SVG
  end
end
