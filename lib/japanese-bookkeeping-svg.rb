# rubocop:disable Style/FileName
require_relative 'japanese_bookkeeping_svg/svg_generator'
require_relative 'japanese_bookkeeping_svg/gem_version'

module JapaneseBookkeepingSVG
  WIDTH = 500
  CENTER_X = WIDTH / 2
  LEFT_MARGIN = 15
  RIGHT_MARGIN = 10
  ACCOUNT_WIDTH = 110
  AMOUNT_X = LEFT_MARGIN + ACCOUNT_WIDTH + RIGHT_MARGIN
  AMOUNT_WIDTH = 105

  @@line_height = SVGGenerator.convert_unit('1em') # rubocop:disable Style/ClassVars

  def self.line_height
    @@line_height
  end

  def self.value_style
    {
      'text-anchor' => 'end'
    }
  end

  def self.account_value(svg, x, y, journals, with_brackets) # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
    key_style = {
      'textLength' => ACCOUNT_WIDTH
    }
    sum_value = 0
    journals.map do |key, value|
      c_x = x
      y += line_height
      key_style['lengthAdjust'] = key.size > 8 ? 'spacingAndGlyphs' : 'spacing'
      svg.text(c_x, y, '(') if with_brackets
      c_x += LEFT_MARGIN
      svg.text(c_x, y, key.to_s, key_style)
      c_x += ACCOUNT_WIDTH + RIGHT_MARGIN
      svg.text(c_x, y, ')') if with_brackets
      c_x += AMOUNT_WIDTH
      svg.text(c_x, y, delimited_number(value).to_s, value_style)
      sum_value += value
    end

    [y, sum_value]
  end

  def self.journalization(debits, credits)
    # TODO: check amount
    SVGGenerator.new do
      JapaneseBookkeepingSVG.account_value(self, 0, 0, debits, true)
      JapaneseBookkeepingSVG.account_value(self, CENTER_X + RIGHT_MARGIN, 0, credits, true)
    end
  end

  def self.t_accounts(account, debits, credits) # rubocop:disable Metrics/LineLength,Metrics/MethodLength,Metrics/AbcSize
    # TODO: calc amount
    line_height = SVGGenerator.convert_unit('1em')
    that = self
    SVGGenerator.new do
      account_style = {
        'textLength' => ACCOUNT_WIDTH,
        'text-anchor' => 'middle'
      }
      line_style = {
        'stroke' => 'black',
        'stroke-width' => 1
      }

      account_style['lengthAdjust'] = account.size > 8 ? 'spacingAndGlyphs' : 'spacing'
      text(CENTER_X, line_height, account, account_style)
      t_start_y = line_height + 8
      line(0, t_start_y, WIDTH, t_start_y, line_style)

      y = t_start_y + 5
      debits_y, sum_debits = that.account_value(self, 0, y, debits, false)
      credits_y, sum_credits = that.account_value(self, CENTER_X, y, credits, false)

      if debits_y < credits_y
        y = credits_y + 8
        line(LEFT_MARGIN, y, AMOUNT_X, debits_y + 8, line_style)
        line(LEFT_MARGIN, y, CENTER_X, y, line_style)
        line(CENTER_X + AMOUNT_X, y, WIDTH, y, line_style)
      elsif debits_y > credits_y
        y = debits_y + 8
        line(AMOUNT_X, y, CENTER_X, y, line_style)
        line(CENTER_X + LEFT_MARGIN, y, CENTER_X + AMOUNT_X, credits_y + 8, line_style)
        line(CENTER_X + LEFT_MARGIN, y, WIDTH, y, line_style)
      else # eq
        y = debits_y + 8
        line(AMOUNT_X, y, CENTER_X, y, line_style)
        line(CENTER_X + AMOUNT_X, y, WIDTH, y, line_style)
      end

      y += line_height + 3
      text(CENTER_X - RIGHT_MARGIN, y, that.delimited_number(sum_debits).to_s, that.value_style)
      text(WIDTH - RIGHT_MARGIN, y, that.delimited_number(sum_credits).to_s, that.value_style)

      y += 8
      line(AMOUNT_X, y, CENTER_X, y, line_style)
      line(CENTER_X + AMOUNT_X, y, WIDTH, y, line_style)
      y += 3
      line(AMOUNT_X, y, CENTER_X, y, line_style)
      line(CENTER_X + AMOUNT_X, y, WIDTH, y, line_style)

      line(CENTER_X, t_start_y, CENTER_X, y, line_style)
    end
  end

  def self.delimited_number(number)
    number.to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, '\\1,')
  end
end
