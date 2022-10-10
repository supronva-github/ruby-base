module Accsessor
  def self.included(base)
    base.extend AttrAccessorWithHistory::ClassMethods
    base.extend StrongAttrAccessor::ClassMethods
    base.include AttrAccessorWithHistory::InstanceMethods
  end

  module AttrAccessorWithHistory
    module ClassMethods
      def attr_accessor_with_history(*arg)
        arg.each do |name|
          attr_accessor_with_history_gettor(name)
          create_history_method(name)
          attr_accessor_with_history_settor(name)
        end
      end

      private

      def attr_accessor_with_history_gettor(arg)
        define_method(arg) { instance_variable_get("@#{arg}".to_sym) }
      end

      def attr_accessor_with_history_settor(arg)
        define_method("#{arg}=".to_sym) do |value|
          instance_variable_set("@#{arg}".to_sym, value)
          add_history(arg, value)
        end
      end

      def create_history_method(arg)
        define_method("#{arg}_history".to_sym) do
          instance_variable_get("@#{arg}_history".to_sym) || instance_variable_set("@#{arg}_history".to_sym, [])
        end
      end
    end

    module InstanceMethods
      private

      def add_history(arg, value)
        history = send("#{arg}_history")
        history.push(value)
      end
    end
  end

  module StrongAttrAccessor
    module ClassMethods
      def strong_attr_accessor(hash)
        hash.each do |key, value|
          strong_attr_accessor_getter(key)
          strong_attr_accessor_setter(key, value)
        end
      end

      private

      def strong_attr_accessor_getter(name)
        define_method(name) { instance_variable_get("@#{name}".to_sym) }
      end

      def strong_attr_accessor_setter(name, type)
        define_method("#{name}=".to_sym) do |value|
          raise TypeError, "There must be a type #{type}" unless value.is_a?(type)

          instance_variable_set("@#{name}".to_sym, value)
        end
      end
    end
  end
end
