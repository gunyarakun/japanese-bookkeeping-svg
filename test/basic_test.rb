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
<svg width="500" height="48" version="1.1" xmlns="http://www.w3.org/2000/svg">
<text x="0" y="16"><tspan x="0" dy="0em">(</tspan></text>
<text x="15" y="16" textLength="110" lengthAdjust="spacing"><tspan x="15" dy="0em">現金預金</tspan></text>
<text x="135" y="16"><tspan x="135" dy="0em">)</tspan></text>
<text x="240" y="16" text-anchor="end"><tspan x="240" dy="0em">4,000</tspan></text>
<text x="260" y="16"><tspan x="260" dy="0em">(</tspan></text>
<text x="275" y="16" textLength="110" lengthAdjust="spacing"><tspan x="275" dy="0em">売上</tspan></text>
<text x="395" y="16"><tspan x="395" dy="0em">)</tspan></text>
<text x="500" y="16" text-anchor="end"><tspan x="500" dy="0em">2,000</tspan></text>
<text x="260" y="32"><tspan x="260" dy="0em">(</tspan></text>
<text x="275" y="32" textLength="110" lengthAdjust="spacing"><tspan x="275" dy="0em">売掛金</tspan></text>
<text x="395" y="32"><tspan x="395" dy="0em">)</tspan></text>
<text x="500" y="32" text-anchor="end"><tspan x="500" dy="0em">2,000</tspan></text>
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
<svg width="500" height="120" version="1.1" xmlns="http://www.w3.org/2000/svg">
<text x="250" y="16" text-anchor="middle" textLength="110" lengthAdjust="spacing"><tspan x="250" dy="0em">現金預金</tspan></text>
<line x1="0" y1="24" x2="500" y2="24" stroke="black" stroke-width="1" />
<text x="15" y="45" textLength="110" lengthAdjust="spacing"><tspan x="15" dy="0em">資本金</tspan></text>
<text x="240" y="45" text-anchor="end"><tspan x="240" dy="0em">10,000</tspan></text>
<text x="265" y="45" textLength="110" lengthAdjust="spacing"><tspan x="265" dy="0em">仕入</tspan></text>
<text x="490" y="45" text-anchor="end"><tspan x="490" dy="0em">2,000</tspan></text>
<text x="265" y="61" textLength="110" lengthAdjust="spacing"><tspan x="265" dy="0em">通信費</tspan></text>
<text x="490" y="61" text-anchor="end"><tspan x="490" dy="0em">500</tspan></text>
<text x="265" y="77" textLength="110" lengthAdjust="spacing"><tspan x="265" dy="0em">次月繰越</tspan></text>
<text x="490" y="77" text-anchor="end"><tspan x="490" dy="0em">7,500</tspan></text>
<line x1="15" y1="85" x2="135" y2="53" stroke="black" stroke-width="1" />
<line x1="15" y1="85" x2="250" y2="85" stroke="black" stroke-width="1" />
<line x1="385" y1="85" x2="500" y2="85" stroke="black" stroke-width="1" />
<text x="240" y="104" text-anchor="end"><tspan x="240" dy="0em">10,000</tspan></text>
<text x="490" y="104" text-anchor="end"><tspan x="490" dy="0em">10,000</tspan></text>
<line x1="135" y1="112" x2="250" y2="112" stroke="black" stroke-width="1" />
<line x1="385" y1="112" x2="500" y2="112" stroke="black" stroke-width="1" />
<line x1="135" y1="115" x2="250" y2="115" stroke="black" stroke-width="1" />
<line x1="385" y1="115" x2="500" y2="115" stroke="black" stroke-width="1" />
<line x1="250" y1="24" x2="250" y2="115" stroke="black" stroke-width="1" />
</svg>
SVG
  end
end
