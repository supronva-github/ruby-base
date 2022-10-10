module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def validations
      @validations ||= []
    end

    def validate(var, validation, condition = '')
      validations << { validation => { var: var, condition: condition } }
    end
  end

  module InstanceMethods
    def valid?
      validate!
    rescue ArgumentError, TypeError
      false
    end

    def validate!
      self.class.validations&.each do |validation|
        validation.each do |name, args|
          send(name, instance_variable_get("@#{args[:var]}".to_sym), args[:condition])
        end
      end
      true
    end

    private

    def presence(var, _arg)
      raise ArgumentError, 'String can not be empty' if var.nil? || var.empty?
    end

    def format(var, format)
      raise ArgumentError, 'Value is not valid' unless var.match?(format)
    end

    def type(var, type)
      raise TypeError, 'Type error' unless var.is_a?(type)
    end
  end
end
