class User < ActiveRecord::Base
  # 2 register an inline callback directly after before_save callback
  # self_email = email.downase is the code that will run when the callback executes
  # callback are hooks that trigger logic before/after an alteration of an object’s state
   before_save { self.email = email.downcase if email.present? }
   before_save :capitalize_username
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

   # split name on space delimiter, capitalize each part, then join with space
   def capitalize_username
     if name != nil
       name_array = []
       name.split.each do |split_name|
          name_array << split_name.capitalize
       end
       self.name = name_array.join(" ")
    end
  end
end
