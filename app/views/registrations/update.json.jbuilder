json.user do
  json.extract! @user, :first_name, :last_name, :email, :access_token
end