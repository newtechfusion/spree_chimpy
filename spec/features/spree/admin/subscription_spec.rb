require 'spec_helper'

feature "Chimpy Admin", js: true do
  stub_authorization!

  let(:user) { create(:user) }

  # test so it has been add "Yes" or "No"

  scenario "" do
    # check so it has been add "Yes"
  end

  # test form

  scenario "" do
    # create user
    # access form
    # fill in checkbox
    # submit
    # check flash
    # check so user has "yes"
  end
end
