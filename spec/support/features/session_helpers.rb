module Features
  module SessionHelpers
    def sign_up_with_facebook
      visit root_path
      click_link 'Facebook'
    end

    def sign_up_with_google
      visit root_path
      click_link 'Google'
    end
  end
end
