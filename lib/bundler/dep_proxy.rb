module Bundler
  class DepProxy
    attr_reader :__platform, :dep

    def initialize(dep, platform)
      @dep, @__platform = dep, platform
    end

    def hash
      @hash ||= dep.hash
    end

    def ==(o)
      dep == o.dep && __platform == o.__platform
    end

    alias_method :eql?, :==

    def type
      @dep.type
    end

    def name
      @dep.name
    end

    def requirement
      @dep.requirement
    end

    def to_s
      s = name.dup
      s << " (#{requirement})" unless requirement == Gem::Requirement.default
      s << " #{__platform}" unless __platform == Gem::Platform::RUBY
      s
    end

  private

    def method_missing(*args, &blk)
      @dep.send(*args, &blk)
    end
  end
end
