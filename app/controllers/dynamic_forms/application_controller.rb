module DynamicForms
  class ApplicationController < ::ApplicationController
    include ApplicationHelper
    if DynamicForms.layout
      layout DynamicForms.layout
    end
  end
end
