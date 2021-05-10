module SubjectsHelper
  def format_object(obj)
    return "\"#{obj}\"" if obj.kind_of?(String)
    return "&lt;#{link_to obj, obj}&gt;".html_safe if obj.kind_of?(Subject)
    obj.to_s
  end
end
