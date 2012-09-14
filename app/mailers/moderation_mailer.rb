class ModerationMailer < ActionMailer::Base
  default from: "admin@jinseiapp.com"

  def approve_business(business, user)
    @business = business
    @user = user
    mail(:to => "admin@jinseiapp.com", :subject => t("app.moderate_business", :user=>user,
                                                     :business=>business))
  end
end
