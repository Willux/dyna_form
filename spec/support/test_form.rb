class TestForm < DynaForm::Base
  submit :first_name, :last_name, :to => AdminUser
  submit :who_cares, :to => "nobody"
end
