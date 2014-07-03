# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name          = 'capistrano-scm-local-file'
  s.version       = '0.1.0'
  s.authors       = ['Peter Mitchell']
  s.email         = ['peterjmit@gmail.com']
  s.summary       = %q{Use a build artifact as a Capistrano 3.x SCM.}
  s.description   = %q{Capistrano 3.x plugin to deploy build artifacts.}
  s.homepage      = "https://github.com/peterjmit/#{s.name}"
  s.license       = 'MIT'

  s.rubyforge_project = 'capistrano-scm-local-file'

  s.files         = `git ls-files -z`.split("\x0")
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.add_dependency 'capistrano', '~> 3.0'

  s.add_development_dependency 'bundler', '~> 1.5'
end
