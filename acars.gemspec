require_relative 'lib/acars/version'

Gem::Specification.new do |spec|
  spec.name          = "acars"
  spec.version       = Acars::VERSION
  spec.authors       = ["Jeff Cohen"]
  spec.email         = ["cohen.jeff@gmail.com"]

  spec.summary       = %q{Transmits application metrics to Radar.}
  spec.homepage      = "https://github.com/purpleworkshops/acars"
  
  spec.required_ruby_version = Gem::Requirement.new(">= 2.7.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/purpleworkshops/acars"
  spec.metadata["changelog_uri"] = "https://github.com/purpleworkshops/acars/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
