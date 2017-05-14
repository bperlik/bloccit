class User < ActiveRecord::Base
  # 2 register an inline callback directly after before_save callback
  # self_email = email.downase is the code that will run when the callback executes
  # callback are hooks that trigger logic before/after an alteration of an object’s state
   has_many :posts, dependent: :destroy
   has_many :comments, dependent: :destroy
   has_many :votes, dependent: :destroy
   has_many :favorites, dependent: :destroy

   before_save { self.role ||= :member }
   # the code in {...||...} is shorthand for
   # self.role = :member if self.role.nil?

  # 3 use Ruby’s validates function to ensure name is present & min/max length
   validates :name, length: { minimum: 1, maximum: 100 }, presence: true

 # 4 validate with that password is valid,
  # ensure that updated password is 6 char long,
  # allow_blank: true skips validation if no password is given
  # allowing changing other attributes on user without updating password
  validates :password, presence: true, length: { minimum: 6 }, if: "password_digest.nil?"
  validates :password, length: { minimum: 6 }, allow_blank: true

 # 5 validate email present, unique, case insensitive, min/max length, formatted for email
   validates :email,
             presence: true,
             uniqueness: { case_sensitive: false },
             length: { minimum: 3, maximum: 254 }

  # 6 use Ruby’s has_secure_password, has_secure_password
   #  to add methods to set and authenticate against a BCrypt password
   # requires a password_digest attribute
   has_secure_password

   enum role: [:member, :admin]

   def favorite_for(post)
     favorites.where(post_id: post.id).first
   end

   def avatar_url(size)
     gravatar_id = Digest::MD5::hexdigest(self.email).downcase
     "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
   end

   def has_posts?
     posts.count > 0
   end

   def has_comments?
     comments.count > 0
   end

   def has_favorites?
     favorites.count > 0
   end
 end

