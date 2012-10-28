Gem::Specification.new do |spec|
  spec.name          = "switzerland"
  spec.license       = 'MIT'
  spec.version       = '0.0.1'
  spec.date          = '2012-10-28'
  spec.authors       = ["Eric Lanehart"]
  spec.email         = ["pushred@gmail.com"]
  spec.homepage      = "https://github.com/pushred/switzerland"
  spec.summary       = "A static content generator."
  spec.description   = "Write in Markdown, publish as JSON and HTML, present with any platform that can GET."
  spec.executables   = ["switz"]

  spec.required_ruby_version = '>= 1.8.1'

  spec.add_dependency 'activesupport', '>= 3.2.6'
  spec.add_dependency 'kramdown', '>= 0.14.0'
  spec.add_dependency 'nokogiri', '>= 1.5.5'

  spec.add_development_dependency 'cucumber', '>= 1.2.1'
  spec.add_development_dependency 'json', '>= 1.7.3'

  # = MANIFEST =
  spec.files = %w[
    LICENSE.txt
    README.md
    bin/switz
    features/1-publish-content.feature
    features/2-manage-content.feature
    features/3-format-content.feature
    features/step_definitions/steps.rb
    switzerland.gemspec
  ]
  # = MANIFEST =
end