Gem::Specification.new do |s|
  s.name              = %(refinerycms-page-images)
  s.version           = %(2.1.1)
  s.description       = %(Attach images to pages in Refinery CMS)
  s.summary           = %(Page Images extension for Refinery CMS)
  s.email             = %(info@refinerycms.com)
  s.homepage          = %(https://github.com/refinery/refinerycms-page-images)
  s.authors           = ['Philip Arndt', 'David Jones']
  s.require_paths     = %w(lib)
  s.license            = %(MIT)

  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files -- spec/*`.split("\n")

  s.add_dependency 'refinerycms-pages', '~> 2.1.0'
end
