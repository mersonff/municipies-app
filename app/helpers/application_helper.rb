# frozen_string_literal: true

module ApplicationHelper
  def decorate(model, decorate_class = nil)
   (decorate_class || "#{model.class}Decorator".constantize).new(model)
  end
end
