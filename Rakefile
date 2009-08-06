require File.dirname(__FILE__)+'/vendor/gems/environments/default.rb'
require 'rubygems'
require 'rake/gempackagetask'
require 'rubygems/specification'
require 'date'
require 'spec/rake/spectask'
require 'bundler'

GEM = "lifeline"
GEM_VERSION = "0.0.4"
AUTHORS = ["Corey Donohoe", "Gustin"]
EMAIL = "atmos@atmos.org"
HOMEPAGE = "http://lifeline.atmos.org"
SUMMARY = "A gem that provides a sinatra app for your friends timeline"

spec = Gem::Specification.new do |s|
  s.name = GEM
  s.version = GEM_VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.summary = SUMMARY
  s.description = s.summary
  s.authors = AUTHORS
  s.email = EMAIL
  s.homepage = HOMEPAGE

  manifest = Bundler::ManifestFile.load(File.dirname(__FILE__) + '/Gemfile')
  manifest.dependencies.each do |d|
    next unless d.in?(:release)
    s.add_dependency(d.name, d.version)
  end

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
