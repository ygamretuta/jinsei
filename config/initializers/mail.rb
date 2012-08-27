ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
    :address => 'smtp.webfaction.com',
    :port => 587,
    :domain => 'jinsei.ygamretuta.me',
    :user_name => 'ygamretuta',
    :password => 'mail_ygamretuta',
    :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "jinsei.ygamretuta.me"