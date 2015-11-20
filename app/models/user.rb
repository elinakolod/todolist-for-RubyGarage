class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable, :omniauthable, omniauth_providers: [:facebook]
	has_many :projects, dependent: :destroy
	accepts_nested_attributes_for :projects,
		allow_destroy: true
	
	before_create :set_default_role
		
	def self.from_omniauth(auth)
	  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
		user.email = auth.info.email.blank? ? "#{auth.uid}@facebook.com" : auth.info.email
		user.password = Devise.friendly_token[0,20]
		user.name = auth.info.name
	  end
	end
	
    def self.new_with_session(params, session)
      super.tap do |user|
        if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        end
      end
    end
    
    private
    def set_default_role
      self.role = "registered"
    end
end
