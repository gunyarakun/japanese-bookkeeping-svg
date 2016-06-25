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
<svg width="100" height="100" version="1.1" xmlns="http://www.w3.org/2000/svg">
<line x1="0" y1="0" x2="100" y2="100" style="" />
</svg>
SVG
  end
end
