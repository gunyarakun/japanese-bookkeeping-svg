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
<svg width="660" height="48" version="1.1" xmlns="http://www.w3.org/2000/svg">
<text x="0" y="16" style=""><tspan x="0" dy="0em">(</tspan></text>
<text x="15" y="16" textLength="145" style=""><tspan x="15" dy="0em">現金預金</tspan></text>
<text x="170" y="16" style=""><tspan x="170" dy="0em">)</tspan></text>
<text x="280" y="16" style="text-anchor:end"><tspan x="280" dy="0em">4,000</tspan></text>
<text x="300" y="16" style=""><tspan x="300" dy="0em">(</tspan></text>
<text x="315" y="16" textLength="145" style=""><tspan x="315" dy="0em">売上</tspan></text>
<text x="470" y="16" style=""><tspan x="470" dy="0em">)</tspan></text>
<text x="580" y="16" style="text-anchor:end"><tspan x="580" dy="0em">2,000</tspan></text>
<text x="300" y="32" style=""><tspan x="300" dy="0em">(</tspan></text>
<text x="315" y="32" textLength="145" style=""><tspan x="315" dy="0em">売掛金</tspan></text>
<text x="470" y="32" style=""><tspan x="470" dy="0em">)</tspan></text>
<text x="580" y="32" style="text-anchor:end"><tspan x="580" dy="0em">2,000</tspan></text>
</svg>
SVG
  end
end
