# coding: utf-8
require_relative 'lib/trenni/words/version'

Gem::Specification.new do |spec|
  spec.name          = "trenni-words"
  spec.version       = Trenni::Words::VERSION
  spec.authors       = ["Samuel Williams"]
  spec.email         = ["samuel.williams@oriontransfer.co.nz"]

  spec.summary       = %q{Provides a basic profanity/obscenity filter.}
  spec.homepage      = "https://github.com/ioquatix/trenni-words"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
