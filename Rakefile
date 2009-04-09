require 'rubygems'
require 'rake/gempackagetask'
require 'rubygems/specification'
require 'date'
require 'spec/rake/spectask'

GEM = "lifeline"
GEM_VERSION = "0.0.3"
AUTHOR = "Corey Donohoe"
EMAIL = "atmos@atmos.org"
HOMEPAGE = "http://twifeline.atmos.org"
SUMMARY = "A gem that provides a sinatra app for your friends timeline"

spec = Gem::Specification.new do |s|
  s.name = GEM
  s.version = GEM_VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.summary = SUMMARY
  s.description = s.summary
  s.author = AUTHOR
  s.email = EMAIL
  s.homepage = HOMEPAGE

  # Uncomment this to add a dependency
  s.add_dependency "oauth", '~>0.3.2'
  s.add_dependency "sinatra", '~>0.9.1.1'
  s.add_dependency "curb", "~>0.3.2"

  s.require_path = 'lib'
  s.autorequire = GEM
  s.files = %w(LICENSE README.md Rakefile TODO) + Dir.glob("{lib,spec}/**/*")
end

task :default => :spec

desc "Run specs"
Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts = %w(-fs --color)
  t.spec_opts << '--loadby' << 'random'

  t.rcov_opts << '--exclude' << 'spec'
  t.rcov = ENV.has_key?('NO_RCOV') ? ENV['NO_RCOV'] != 'true' : true
  t.rcov_opts << '--text-summary'
  t.rcov_opts << '--sort' << 'coverage' << '--sort-reverse'
end


Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "install the gem locally"
task :install => [:package] do
  sh %{sudo gem install pkg/#{GEM}-#{GEM_VERSION}}
end

desc "create a gemspec file"
task :make_spec do
  File.open("#{GEM}.gemspec", "w") do |file|
    file.puts spec.to_ruby
  end
end
