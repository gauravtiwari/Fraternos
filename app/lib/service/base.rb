require 'dry-struct'
require 'dry-types'
require 'dry-matcher'
require 'dry-monads'
require 'dry/matcher/either_matcher'

module Types
  include Dry::Types.module
end

module Service
  class Base < Dry::Struct
    include Dry::Monads::Either::Mixin

    def self.inherited(subclass)
      subclass.include Dry::Matcher.for(:call, with: Dry::Matcher::EitherMatcher)
      super
    end

    constructor_type :schema

    def self.call(*args, &block)
      new(*args).call(&block)
    end

    def success(value = nil)
      Right.new(value)
    end

    def failure(value = nil)
      Left.new(value)
    end
  end
end
