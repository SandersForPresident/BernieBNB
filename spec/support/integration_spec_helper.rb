module IntegrationSpecHelper
  def login_with_oauth(service = :facebook)
    visit "/auth/#{service}"
  end
end