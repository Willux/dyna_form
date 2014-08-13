class TestFormAgain < DynaForm::Base
  submit :middle_name, :nickname, :to => AdminUser
  submit :permissions, :awesomness, :to => AdminUser
end
