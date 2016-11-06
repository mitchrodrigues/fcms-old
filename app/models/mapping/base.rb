module Mapping
  Field = Struct.new(:name, :permission, :options) do 
    def initialize(name:, permission:, **options)
      super(name, permission, options)
    end
  end

  class Base
    attr_accessor :person, :collection

    def initialize(person:, collection: [])
      @collection = collection
      @person       = person
    end

    def available_fields
      fields.collect do |field|
        if permission(field.permission).present?
          { field.name => true }
        end
      end.compact
    end

    def group_permissions
      @group_permissions ||= person.group_permissions.all.includes(:permission)
    end

    def permission(perm)
      group_permissions.find{|gp| gp.permission.name.eql?(perm.to_s) }
    end

    def fields
      self.class.fields
    end

    class << self
      attr_writer :fields
      def fields
        @fields ||= []
      end
    end
  end
end