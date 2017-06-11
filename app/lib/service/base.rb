module Service
  class Base
    def self.call(**)
      raise NotImplementedError
    end

    def self.success(value = nil)
      Dry::Monads.Right(value)
    end

    def self.failure(value = nil)
      Dry::Monads.Left(value)
    end
  end
end
