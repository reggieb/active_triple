 

require 'rubygems'
require 'rake'
require 'rake/clean'
require 'rake/gempackagetask'
require 'rake/rdoctask'
require 'rake/testtask'

spec = Gem::Specification.new do |s|
  s.name = 'active-triple'
  s.version = '0.0.1'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.md', 'LICENSE']
  s.summary = 'Your summary here'
  s.description = s.summary
  s.author = ['Rob Nichols']
  s.email = ''
  s.files = %w(LICENSE README.md Rakefile) + Dir.glob("{lib,test}/**/*")
  s.require_path = "lib"
end

Rake::GemPackageTask.new(spec) do |p|
  p.gem_spec = spec
  p.need_tar = true
  p.need_zip = true
end

Rake::RDocTask.new do |rdoc|
  files =['README', 'LICENSE', 'lib/**/*.rb']
  rdoc.rdoc_files.add(files)
  rdoc.main = "README" # page to start on
  rdoc.title = "active-triple Docs"
  rdoc.rdoc_dir = 'doc/rdoc' # rdoc output folder
  rdoc.options << '--line-numbers'
end

Rake::TestTask.new do |t|
  t.test_files = FileList['test/**/*.rb']
end
