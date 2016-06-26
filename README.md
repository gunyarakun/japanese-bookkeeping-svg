# japanese-bookkeeping-svg

[![Build Status](https://travis-ci.org/gunyarakun/japanese-bookkeeping-svg.svg?branch=master)](https://travis-ci.org/gunyarakun/japanese-bookkeeping-svg)
[![Gem Version](https://badge.fury.io/rb/japanese-bookkeeping-svg.svg)](https://badge.fury.io/rb/japanese-bookkeeping-svg)
![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)

Generate SVG files for Japanese style bookkeeping diagrams.

:warning: This SVG uses `textLength` attritube which is not be supported by some SVG viewer. Use [Firefox](https://www.mozilla.org/en-US/firefox/products/), [Batik](https://xmlgraphics.apache.org/batik/), etc.

## Usage

```bash
gem install japanese-bookkeeping-svg
```

仕訳

```ruby
require 'japanese-bookkeeping-svg'

File.open('journal.svg', 'w') do |file|
  file.write JapaneseBookkeepingSVG.journalization(
    debits={
      現金預金: 4000
    },
    credits={
      売上: 2000,
      売掛金: 2000
    }
  ).to_s
end
```

T字勘定

```ruby
require 'japanese-bookkeeping-svg'

File.open('t-accounts.svg', 'w') do |file|
  file.write JapaneseBookkeepingSVG.t_accounts(
    '現金預金',
    debits={
      資本金: 10000
    }
    credits={
      仕入: 2000,
      普通預金: 1234,
      諸口: 3456,
      次月繰越: 3310
    },
  ).to_s
end
```

## Conversion to PNG with Batik

Make `user.css`.

```css
text {
  font-size: 16px;
  font-family: "ヒラギノ明朝 ProN W6", "HiraMinProN-W6";
}
```

Execute. Set `-w 2000` for changing image size to make resolutions up.

```bash
java -jar batik-1.8/batik-rasterizer-1.8.jar -w 2000 -cssUser user.css out.svg
```

## License

``japanese-bookkeeping-svg`` is distributed under the terms of the MIT license (see LICENSE.txt).
