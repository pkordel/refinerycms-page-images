Gem::Specification.new do |s|
  s.name              = %(refinerycms-page-images)
  s.version           = %(3.0.0)
  s.description       = %(Attach images to pages ins Refinery CMS)
  s.summary           = %(Page Images extension for Refinery CMS)
  s.email             = %(info@refinerycms.com)
  s.homepage          = %(http://github.com/refinery/refinerycms-page-images)
  s.authors           = ['Philip Arndt', 'David Jones']
  s.require_paths     = %w(lib)
  s.license            = %(MIT)

  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files -- spec/*`.split("\n")

  s.add_dependency 'refinerycms-pages', '~> 3.0.0'
  s.add_dependency 'decorators',        '~> 2.0.0'
  s.add_dependency 'globalize',         '~> 5.0'
end
