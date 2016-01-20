class PoliciesController < ApplicationController
  def facebook
    render text: File.readlines(
      File.expand_path("../../../doc/bernie-bnb-facebook-privacy-statement.txt", __FILE__)
    ).join("<br />")
  end
end
