class WikisController < ApplicationController

  before_action :authenticate_user!

  def index
    @wikis = current_user.wikis
    @wikis_i_am_collaborating_on = current_user.wikis_i_am_collaborating_on
  end

  def new
    @wiki = Wiki.new
    @users = User.all_except(current_user)
  end

  def create
    @wiki = current_user.wikis.build(wiki_params)

    if @wiki.save
      flash[:success] = "Your Wiki has been created!"
      redirect_to @wiki
    else
      flash[:error] = "Your Wiki creation failed. Please try again."
      redirect_to new_wiki_path
    end
  end

  def show
    @wiki = current_user.wikis.find(params[:id])

  end

  def update
    @wiki = current_user.wikis.find(params[:id])
    @users = User.all
    if @wiki.update_attributes(wiki_params)
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
    @wiki = current_user.wikis.find(params[:id])
    @wikis_i_am_collaborating_on = current_user.collaborations
    @users = User.all_except(current_user)
  end

  def owned_wikis
    @wikis = current_user.owned_wikis
  end

  def collaborated_wikis
    @wikis = current_user.collaborated_wikis
  end

  def premium?
    user.role?(:admin) or user.role?(:premium)
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private, :collaborator_ids => [])
  end

  def load_wiki
    @wiki = Wiki.friendly.find(params[:id])
  end

  def self.all_except(user)
    where.not(id: user)
  end
end
