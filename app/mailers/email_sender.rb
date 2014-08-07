class EmailSender < ActionMailer::Base
  default from: "noreply@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.email_sender.notify.subject
  #
  def notify(data)
    @body = data[:body]
    mail to: data[:email], subject: data[:subject]
  end
end
