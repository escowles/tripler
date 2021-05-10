class Statement < ApplicationRecord
  belongs_to :subject
  belongs_to :predicate
  belongs_to :obj, optional: true
  belongs_to :resource_object, class_name: "Subject", optional: true
  validates_associated :subject, :predicate
  validate :only_one_object

  def statement_object
    return literal if literal
    return resource_object if resource_object
    return obj
  end

  def statement_object=(literal_or_resource)
    if literal_or_resource.kind_of?(Subject)
      self.obj = nil
      self.literal = nil
      self.resource_object = literal_or_resource
    elsif literal_or_resource.kind_of?(Obj)
      self.literal = nil
      self.resource_object = nil
      self.obj = literal_or_resource
    else
      self.obj = nil
      self.resource_object = nil
      self.literal = literal_or_resource
    end
  end

  def only_one_object
    n = [literal.present?, obj.present?, resource_object.present?].count(true)
    unless n == 1
      errors.add :statement_object, "Exactly one of :literal, :obj, or :resource_object must be provided"
    end
  end
end
