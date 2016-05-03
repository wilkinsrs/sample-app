class User < ActiveRecord::Base
    #another way to write these: validates(:name, presence: true)
    before_save { self.email = self.email.downcase } #self is optional on the right side of equation
    
    validates :name,    presence: true,
                        length: { maximum: 50 }
                        
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    
    validates :email,   presence: true,
                        length: { maximum: 255 }, 
                        format: { with: VALID_EMAIL_REGEX }, 
                        uniqueness: { case_sensitive: false } #rails infers that uniquness is true
end
