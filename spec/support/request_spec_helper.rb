module RequestSpecHelper
  def json
    JSON.parse(response.body)
  end

  def authenticated_header(user)
    token = Knock::AuthToken.new(payload: { sub: user.id }).token
    { 'Authorization': "Bearer #{token}" }
  end

  def unauthenticated_header
    token = 'jjud888eekmmcid8e8oed9c'
    {'Authorization': "Bearer #{token}" }
  end
end
