# -*- encoding: utf-8 -*-
# stub: minimal-jekyll-theme 0.1.3 ruby lib

Gem::Specification.new do |s|
  s.name = "minimal-jekyll-theme".freeze
  s.version = "0.1.3".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "plugin_type" => "theme" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Desired Persona".freeze]
  s.date = "2017-07-09"
  s.homepage = "https://desiredpersona.com/themes/".freeze
  s.licenses = ["CC-BY-4.0".freeze]
  s.rubygems_version = "2.6.8".freeze
  s.summary = "A minimal Jekyll theme that converts.".freeze

  s.installed_by_version = "3.6.7".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<jekyll>.freeze, ["~> 3.5".freeze])
  s.add_runtime_dependency(%q<jekyll-feed>.freeze, ["~> 0.9".freeze])
  s.add_runtime_dependency(%q<jekyll-sitemap>.freeze, ["~> 1.1".freeze])
  s.add_runtime_dependency(%q<jekyll-seo-tag>.freeze, ["~> 2.2".freeze])
  s.add_development_dependency(%q<bundler>.freeze, ["~> 1.14".freeze])
end
