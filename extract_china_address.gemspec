$:.push File.expand_path('../lib', __FILE__)
require 'extract_china_address/version'

Gem::Specification.new do |s|
  s.name        = 'extract_china_address'
  s.version     = ExtractChinaAddress::VERSION
  s.authors     = ['fwshun']
  s.email       = 'fwshun8023@gmail.com'
  s.homepage    = 'https://github.com/fwshun8023/extract_china_address'
  s.summary     = 'extract china address'
  s.description = 'extract china address'
  s.files         = `git ls-files`.split($RS)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']
  s.add_dependency 'bundler', '~> 1.3'
  s.add_dependency 'GB2260', '~> 0.2.1'
  s.add_dependency 'rake', '~> 11.3'
  s.license = 'MIT'
end
