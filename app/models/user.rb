class User < ActiveRecord::Base
	has_many :posts, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_secure_password
	has_attached_file :image, styles: { small: "64x64", med: "100x100", large: "200x200" },
	:default_url => "default_:style_missing.png"
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
	validates :password, presence: true, confirmation: true, length: { in: 3..20 }
	validates :image, presence: true
end
