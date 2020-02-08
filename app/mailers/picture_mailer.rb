class PictureMailer < ApplicationMailer
  def picture_mail(picture)
    @picture = picture
    mail to: "yy_yuko_121@yahoo.co.jp", subject: "投稿完了"
  end
end
