# rubocop:disable Metrics/MethodLength
require 'test_helper'

class BasicTest < Minitest::Test
  def test_journalization
    svg = JapaneseBookkeepingSVG.journalization(
      {
        現金預金: 4000
      },
      {
        売上: 2000,
        売掛金: 2000
      }
    )

    assert_equal <<SVG.chomp, svg.to_s
<?xml version="1.0" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg width="590" height="48" version="1.1" xmlns="http://www.w3.org/2000/svg">
<text x="0" y="16"><tspan x="0" dy="0em">(</tspan></text>
<text x="15" y="16" textLength="125" lengthAdjust="spacing"><tspan x="15" dy="0em">現金預金</tspan></text>
<text x="150" y="16"><tspan x="150" dy="0em">)</tspan></text>
<text x="290" y="16" text-anchor="end"><tspan x="290" dy="0em">4,000</tspan></text>
<text x="300" y="16"><tspan x="300" dy="0em">(</tspan></text>
<text x="315" y="16" textLength="125" lengthAdjust="spacing"><tspan x="315" dy="0em">売上</tspan></text>
<text x="450" y="16"><tspan x="450" dy="0em">)</tspan></text>
<text x="590" y="16" text-anchor="end"><tspan x="590" dy="0em">2,000</tspan></text>
<text x="300" y="32"><tspan x="300" dy="0em">(</tspan></text>
<text x="315" y="32" textLength="125" lengthAdjust="spacing"><tspan x="315" dy="0em">売掛金</tspan></text>
<text x="450" y="32"><tspan x="450" dy="0em">)</tspan></text>
<text x="590" y="32" text-anchor="end"><tspan x="590" dy="0em">2,000</tspan></text>
</svg>
SVG
  end

  def test_t_accounts
    svg = JapaneseBookkeepingSVG.t_accounts(
      '現金預金',
      {
        資本金: 10_000
      },
      {
        仕入: 2000,
        通信費: 500,
        次月繰越: 7500
      }
    )

    assert_equal <<SVG.chomp, svg.to_s
<?xml version="1.0" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg width="600" height="120" version="1.1" xmlns="http://www.w3.org/2000/svg">
<text x="300" y="16" text-anchor="middle" textLength="145"><tspan x="300" dy="0em">現金預金</tspan></text>
<line x1="0" y1="24" x2="600" y2="24" stroke="black" stroke-width="1" />
<text x="15" y="45" textLength="125" lengthAdjust="spacing"><tspan x="15" dy="0em">資本金</tspan></text>
<text x="290" y="45" text-anchor="end"><tspan x="290" dy="0em">10,000</tspan></text>
<text x="315" y="45" textLength="125" lengthAdjust="spacing"><tspan x="315" dy="0em">仕入</tspan></text>
<text x="590" y="45" text-anchor="end"><tspan x="590" dy="0em">2,000</tspan></text>
<text x="315" y="61" textLength="125" lengthAdjust="spacing"><tspan x="315" dy="0em">通信費</tspan></text>
<text x="590" y="61" text-anchor="end"><tspan x="590" dy="0em">500</tspan></text>
<text x="315" y="77" textLength="125" lengthAdjust="spacing"><tspan x="315" dy="0em">次月繰越</tspan></text>
<text x="590" y="77" text-anchor="end"><tspan x="590" dy="0em">7,500</tspan></text>
<line x1="15" y1="85" x2="140" y2="53" stroke="black" stroke-width="1" />
<line x1="15" y1="85" x2="300" y2="85" stroke="black" stroke-width="1" />
<line x1="460" y1="85" x2="600" y2="85" stroke="black" stroke-width="1" />
<text x="290" y="104" text-anchor="end"><tspan x="290" dy="0em">10,000</tspan></text>
<text x="590" y="104" text-anchor="end"><tspan x="590" dy="0em">10,000</tspan></text>
<line x1="160" y1="112" x2="300" y2="112" stroke="black" stroke-width="1" />
<line x1="460" y1="112" x2="600" y2="112" stroke="black" stroke-width="1" />
<line x1="160" y1="115" x2="300" y2="115" stroke="black" stroke-width="1" />
<line x1="460" y1="115" x2="600" y2="115" stroke="black" stroke-width="1" />
<line x1="300" y1="24" x2="300" y2="115" stroke="black" stroke-width="1" />
</svg>
SVG
  end
end
