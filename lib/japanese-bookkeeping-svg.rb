require_relative 'japanese-bookkeeping-svg/svg_generator'
require_relative 'japanese-bookkeeping-svg/gem_version'

module JapaneseBookkeepingSVG
  def self.line_height
    @@line_height ||= SVGGenerator.convert_unit('1em')
  end

  def self.value_style
    {
      'text-anchor' => 'end'
    }
  end

  def self.account_value(svg, x, y, journals, with_brackets)
    key_style = {
      'textLength' => 125,
#      'xml:space' => 'preserve'
    }
    sum_value = 0
    journals.map do |key, value|
      y += line_height
      svg.text(x, y, '(') if with_brackets
      svg.text(x + 15, y, "#{key}", key_style)
      svg.text(x + 150, y, ')') if with_brackets
      svg.text(x + 290, y, "#{self.delimited_number(value)}", value_style)
      sum_value += value
    end

    [y, sum_value]
  end

  def self.journalization(debits, credits)
    # TODO: check amount
    SVGGenerator.new do
      JapaneseBookkeepingSVG.account_value(self, 0, 0, debits, true)
      JapaneseBookkeepingSVG.account_value(self, 300, 0, credits, true)
    end
  end

  def self.t_accounts(account, debits, credits)
    # TODO: calc amount
    line_height = SVGGenerator.convert_unit('1em')
    SVGGenerator.new do
      account_style = {
        'textLength' => 145,
        'text-anchor' => 'middle'
      }
      line_style = {
        'stroke' => 'black',
        'stroke-width' => 1
      }

      text(300, line_height, account, account_style)
      t_start_y = line_height + 8
      line(0, t_start_y, 600, t_start_y, line_style)

      y = t_start_y + 5
      debits_y, sum_debits = JapaneseBookkeepingSVG.account_value(self, 0, y, debits, false)
      credits_y, sum_credits = JapaneseBookkeepingSVG.account_value(self, 300, y, credits, false)

      if debits_y < credits_y
        y = credits_y + 8
        line(15, y, 140, debits_y + 8, line_style)
        line(15, y, 300, y, line_style)
        line(460, y, 600, y, line_style)
      elsif debits_y > credits_y
        y = debits_y + 8
        line(160, y, 300, y, line_style)
        line(315, y, 440, credits_y + 8, line_style)
        line(315, y, 600, y, line_style)
      else # eq
        y = debits_y + 8
        line(160, y, 300, y, line_style)
        line(460, y, 600, y, line_style)
      end

      y += line_height + 3
      text(290, y, "#{JapaneseBookkeepingSVG.delimited_number(sum_debits)}", JapaneseBookkeepingSVG.value_style)
      text(590, y, "#{JapaneseBookkeepingSVG.delimited_number(sum_credits)}", JapaneseBookkeepingSVG.value_style)

      y += 8
      line(160, y, 300, y, line_style)
      line(460, y, 600, y, line_style)
      y += 3
      line(160, y, 300, y, line_style)
      line(460, y, 600, y, line_style)

      line(300, t_start_y, 300, y, line_style)
    end
  end

  def self.delimited_number(number)
    number.to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1,")
  end
end
