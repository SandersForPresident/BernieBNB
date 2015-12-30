module Features
  module SessionHelpers
    def sign_up_with_facebook
      visit root_path
      click_link 'Facebook'
    end
  end
end
