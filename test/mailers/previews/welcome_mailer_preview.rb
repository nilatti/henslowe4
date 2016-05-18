class UserMailerPreview < ActionMailer::Preview
  def welcome_email_preview
    UserMailer.welcome_email(User.first)
  end
end