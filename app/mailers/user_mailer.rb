class UserMailer < ApplicationMailer
  def welcome_email(user, generated_password)
  	@user = user
  	@generated_password = generated_password
  	mail(to:@user.email, subject: 'Welcome to Henslowe\'s Cloud')

  end
end
