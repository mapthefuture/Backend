json.user do
  json.id @user.id
  json.first_name @user.first_name
  json.last_name @user.last_name
  json.email @user.email
  json.access_token @user.access_token
  json.avatar_file_name @user.avatar_file_name
  json.avatar_url @user.avatar.url
end