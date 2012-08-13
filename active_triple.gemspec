require 'rake/gempackagetask'

Gem::Specification.new do |s|
  s.name = 'active_triple'
  s.version = '0.1.0'
  s.authors = ['Rob Nichols']
  s.date = %q{2012-08-07}
  s.description = "Active Triple - Tool to query triple stores"
  s.summary = s.description
  s.email = 'rob@undervale.co.uk'
  s.homepage = 'https://github.com/reggieb/active_triple'
  s.files = ['README.md', 'LICENSE', FileList['lib/**/*.rb']].flatten
  s.add_runtime_dependency 'hashie', '~> 1.2.0'
  s.add_runtime_dependency 'json'
  s.add_runtime_dependency 'triple_parser'
  s.add_runtime_dependency 'typhoeus'
  s.require_path = "lib"
end