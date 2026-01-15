# Preview all emails at http://localhost:3000/rails/mailers/show_reminder_mailer
class ShowReminderMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/show_reminder_mailer/reminder_email
  def reminder_email
    ShowReminderMailer.reminder_email
  end
end
