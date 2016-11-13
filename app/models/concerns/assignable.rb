# This is very ugly but it makes our other things cleaner
# so for now we will leave it as is to refactor later
module Assignable
  extend ActiveSupport::Concern

  #################################################
  # Helper Methods for Assigable 
  #################################################

  def assignments_for(rec)
    all_assignments.where(self.class.assignment_type(rec.class) => rec)
  end

  def assignment_start(assignment_name, rec)
    assigns = assignment_relation(assignment_name)
    assigns.create(assignemnt_type_for(rec) => rec)
  end

  def assignment_end(assignment_name, rec)
    assigns = assignment_relation(assignment_name).where(assignemnt_type_for(rec) => rec).first
    return false unless assigns
    assigns.update_attribute(:ended_at, Time.now) 
  end

  private
  def assignment_relation(assignment_name)
    send(assignment_name.to_s.pluralize)
  end

  def assignemnt_type_for(rec)
    self.class.assignment_type(rec.class)
  end

  ######################################################
  # Class Methods
  ######################################################

  class_methods do
    attr_accessor :inverse_assignments

    def assignment_type(kls)
      ass_type = kls.to_s.underscore.pluralize
      return :resource if (assignments[:owner] || []).include?(ass_type) 
      :owner
    end

    def assignments
      @assignments ||= {}
      @assignments
    end

    def assignment_owners(assigns)
      memolize_assigns(:owner, assigns)
      assigns.each do |asmnt, asee|
        build_assigment_relations(asmnt, asee, :owner)
      end
    end

    def memolize_assigns(as_relation, assigns)
      assignments[as_relation] = [assigns.keys + assigns.values].collect(&:to_s)
    end

    def assignment_resources(assigns)
      memolize_assigns(:resource, assigns)
      assigns.each do |asmnt, asee|
        build_assigment_relations(asmnt, asee, :resource)
      end      
    end

    def build_assigment_relations(base, sub, as_relation)
      assignment(base, as_relation)
      assignee(sub, base, as_relation)
    end

    def assignment_class(relation_name)
      relation_type = relation_name.to_s.singularize.camelize
      "Assignments::#{relation_type}"
    end

    def assignment(relation, as_relation)
      relation_type = relation.to_s.singularize.camelize

      has_many relation, 
        class_name: "Assignments::#{relation_type}", as: as_relation

      has_many "active_#{relation}".to_sym, active_assignment_filter,
        class_name: "Assignments::#{relation_type}", as: as_relation

      has_many "inactive_#{relation}".to_sym, active_assignment_filter(true), 
        class_name: "Assignments::#{relation_type}", as: as_relation

      has_many :all_assignments, as: as_relation, class_name: "Assignment"
    end

    def assignee(assignee, through, as_relation)
      has_many assignee, { 
        through: through,
        source: inverse_relation_of(as_relation),
        as:     as_relation,
        source_type: assignee.to_s.singularize.camelize
      }
    end

    private
    def active_assignment_filter(inactive = nil)
      verb  = inactive ? "NOT" : ""
      ->() { where("ended_at IS #{verb} NULL") }
    end

    def inverse_relation_of(as_relation)
      as_relation.eql?(:owner) ? :resource : :owner
    end
  end
end


=begin
  
class Blah
  
  assignment_resources 
  assignment_owners
  
end


=end