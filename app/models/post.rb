class Post < ActiveRecord::Base
	has_many :comments, dependent: :destroy
	belongs_to :user
	has_attached_file :image, styles: { small: "64x64", med: "100x100", large: "200x200" },
	:default_url => "default_:style_missing.png"
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

	def date_published
      created_at.localtime.strftime("%A, %B %-d, %Y at %l:%M %p")
    end
end
