class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborations
  has_many :collaborators, through: :collaborations, class_name: 'User'


  scope :visible_to, -> (user) { user ? all : where(premium: true) }
  scope :visible_to, -> (wiki) { user ? all : where(private: true) }

  #scope :private_wikis, -> { where private: true }
  #scope :public_wikis, -> { where private: false }

  def markdown_body
    renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    renderer.render body
  end
end
