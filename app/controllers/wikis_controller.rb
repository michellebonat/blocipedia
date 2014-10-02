class WikisController < ApplicationController

  before_action :authenticate_user!
  #before_action :set_wiki, only: [:update, :destroy, :show]
  #before_action :set_user

  def index
    @wikis = current_user.wikis
    @wikis_i_am_collaborating_on = current_user.wikis_i_am_collaborating_on
    #@users = Users.all
    #authorize @wikis
    #@collaborations = current_user.collaborations
  end

  def new
    @wiki = Wiki.new
    #authorize @wiki
  end

  def create
    #@user = user
    #@users = users.find(params[:id])
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
    #authorize @wiki

  end

  def update

    @wiki = current_user.wikis.find(params[:id])
    #@users = user.find(params[:id])
    @users = User.all
    #@user = user
    #@wikis_i_am_collaborating_on = current_user.collaborations
    if @wiki.update_attributes(wiki_params)
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  #def edit_live
  #  @wiki = current_user.wikis.find(params[:id])
  #  @wiki.edit_live
  #  @wiki.save!
  #end

  def edit
    @wiki = current_user.wikis.find(params[:id])
    @users = User.all
    @wikis_i_am_collaborating_on = current_user.collaborations
  end

  def destroy
  end

  def owned_wikis
    @wikis = current_user.owned_wikis
  end

  def collaborated_wikis
    @wikis = current_user.collaborated_wikis
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private, :collaborator_ids => [])
  end

  def load_wiki
    @wiki = Wiki.friendly.find(params[:id])
  end
end
