require 'spec_helper'
require 'rails_helper'
require_relative '../support/feature_test_helper'

RSpec.describe "i18n-spec Tests", type: :feature do

  describe "config/locales/en.yml" do
    it { is_expected.to be_parseable }
    it { is_expected.to have_valid_pluralization_keys }
    it { is_expected.to_not have_missing_pluralization_keys }
    it { is_expected.to be_named_like_top_level_namespace }
    it { is_expected.to_not have_legacy_interpolations }
    it { is_expected.to have_a_valid_locale }
    it { is_expected.to have_one_top_level_namespace }
    it_behaves_like 'a valid locale file', 'config/locales/en.yml'
  end
end
