# this code is based on http://www.candland.net/2012/04/17/rails-routes-used-in-an-isolated-engine/
module DynamicForms
  module CustomFormsHelper
    def is_active?(value)
      value ? 'active' : 'inactive'
    end
  end
end
