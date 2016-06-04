module RubyDebianDev

  RUBY_INTERPRETERS = {}

  def self.has_support_for(ruby)
    RUBY_INTERPRETERS[ruby] = yield
  end

  has_support_for 'ruby2.1' do
    {
      version:             '2.1',
      binary:              '/usr/bin/ruby2.1',
      api_version:         '2.1.0',
      shared_library:      'libruby2.1',
      min_ruby_dependency: 'ruby (>= 1:2.1)',
    }
  end

  has_support_for 'ruby2.2' do
    {
      version:             '2.2',
      binary:              '/usr/bin/ruby2.2',
      api_version:         '2.2.0',
      shared_library:      'libruby2.2',
      min_ruby_dependency: 'ruby (>= 1:2.2)',
    }
  end

  def self.min_ruby_dependency_for(shared_library)
    RUBY_INTERPRETERS.each do |int,data|
      if data[:shared_library] == shared_library
        return data[:min_ruby_dependency]
      end
    end
    return nil
  end

  #################################################################
  # These constants below are kept here for backwards compatibility
  #################################################################
  SUPPORTED_RUBY_VERSIONS = RUBY_INTERPRETERS.keys.inject({}) do |supported,interpreter|
    supported[interpreter] = RUBY_INTERPRETERS[interpreter][:binary]
    supported
  end

  RUBY_CONFIG_VERSION = RUBY_INTERPRETERS.keys.inject({}) do |supported,interpreter|
    supported[interpreter] = RUBY_INTERPRETERS[interpreter][:version]
    supported
  end

  RUBY_API_VERSION = RUBY_INTERPRETERS.keys.inject({}) do |supported,interpreter|
    supported[interpreter] = RUBY_INTERPRETERS[interpreter][:api_version]
    supported
  end

  SUPPORTED_RUBY_SHARED_LIBRARIES = RUBY_INTERPRETERS.map { |k,v| v[:shared_library] }

end
