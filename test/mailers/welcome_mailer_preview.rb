class UserMailerPreview < ActionMailer::Preview
  def welcome_email_preview
    UserMailer.welcome_email(User.first, "fozzywig") #this should be getting the actual generated password, but...
  end
end