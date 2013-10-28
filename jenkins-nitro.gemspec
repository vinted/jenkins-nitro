# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jenkins_nitro/version'

Gem::Specification.new do |spec|
  spec.name          = "jenkins-nitro"
  spec.version       = JenkinsNitro::VERSION
  spec.authors       = ["Tomas Varaneckas", "Lech Jankovski", "Tomas Brazys"]
  spec.email         = ["tomas.varaneckas@gmail.com", "lech.jankovski@gmail.com", "tomas.brazys@gmail.com"]
  spec.description   = %q{Command line tool for analyzing Jenkins test duration changes between \
fast and slow builds and pinpointing the cause of slowdown.}
  spec.summary       = %q{Jenkins test suite slowdown analyzer}
  spec.homepage      = "https://github.com/vinted/jenkins-nitro"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
