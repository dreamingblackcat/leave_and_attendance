class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :team
  mount_uploader :avatar, AvatarUploader
  has_many :leave_applications, dependent: :destroy
  has_many :leave_dates, through: :leave_application

  validates :name, presence: true
  validates :employee_no,presence: true 
  validates :date_of_birth,presence: true 
  validates :nrc_number,presence: true 
   
  validates :bank_card_number,presence: true 
  validates :nationality,presence: true 
     
  validates :gender,presence: true 
       
     
  validates :joined_date,presence: true 

  # TODO# to add full fledged role based access control list

  def admin?
  	name === "admin"
  end
end
