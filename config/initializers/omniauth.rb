OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer if Rails.env.development?

  provider :google_oauth2, ENV["MK_GOOGLE_APP_ID"], ENV["MK_GOOGLE_APP_SECRET"],
    {
      :name => "google",
      :scope => "email, profile, plus.me, http://gdata.youtube.com",
      :prompt => "select_account",
      :image_aspect_ratio => "square",
      :image_size => 50
   }

  provider :facebook, ENV['MK_FACEBOOK_APP_ID'], ENV['MK_FACEBOOK_APP_SECRET'],
    scope: 'email,public_profile,',
    display: 'popup',
    client_options: {
  }

  provider :linkedin, ENV['MK_LINKEDIN_APP_ID'], ENV['MK_LINKEDIN_APP_SECRET'],
    scope: 'r_basicprofile r_emailaddress',
    fields: [
      'id',
      'email-address',
      'first-name',
      'last-name',
      'picture-url',
      'public-profile-url', 'num-connections'
  ]

  on_failure { |env| AuthenticationsController.action(:failure).call(env) }
end
