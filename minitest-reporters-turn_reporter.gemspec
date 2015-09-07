# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "minitest-reporters-turn_reporter"
  spec.version       = "0.1.0"
  spec.authors       = ["Bob Lail"]
  spec.email         = ["bob.lail@cph.org"]

  spec.summary       = %q{A Minitest Reporter that formats test output like Turn}
  spec.homepage      = "https://github.com/concordia-publishing-house/minitest-reporters-turn_reporter"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "minitest-reporters"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
end
