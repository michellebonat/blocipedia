class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable #:confirmable
  has_many :wikis
  has_many :collaborations
  #has_many :wikis_i_am_collaborating_on, through: :collaborations, class_name: 'Wiki'
  has_many :wikis_i_am_collaborating_on, :through => :collaborations, :source => :wiki

  def role?(base_role)
    role == base_role.to_s
  end

  def self.all_except(user)
    where.not(id: user)
  end
  #protected
  #def confirmation_required?
  #  false
  #end

end

