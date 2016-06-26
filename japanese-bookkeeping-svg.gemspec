# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'japanese_bookkeeping_svg/gem_version'

Gem::Specification.new do |spec|
  spec.name          = 'japanese-bookkeeping-svg'
  spec.version       = JapaneseBookkeepingSVG::VERSION
  spec.authors       = ['Tasuku SUENAGA a.k.a. gunyarakun']
  spec.email         = ['tasuku-s-github@titech.ac']

  spec.summary       = 'Generate SVG images for Japanese bookkeeping'
  spec.description = %(
    A pure Ruby library to generate SVG images for Japanese bookkeeping.
  ).strip.gsub(/\s+/, ' ')
  spec.homepage = 'https://github.com/gunyarakun/japanese-bookkeeping-svg'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^test/})
  end
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'simplecov', '~> 0.11'
  spec.add_development_dependency 'rubocop', '~> 0.40'
end
