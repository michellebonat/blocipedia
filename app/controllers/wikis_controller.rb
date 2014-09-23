class WikisController < ApplicationController

  before_action :set_wiki, only: [:update, :destroy, :show]
  #before_action :set_user

  def index
    #@public_wikis = Wiki.public_wikis
    #@private_wikis = Wiki.private_wikis
    @wikis = current_user.wikis
    @collaborations = current_user.collaborations
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = current_user.owned_wikis.new(wiki_params)

    if @wiki.save
      flash[:success] = "Your Wiki has been created!"
      redirect_to @wiki
    else
      flash[:error] = "Your Wiki creation failed. Please try again."
      redirect_to new_wiki_path
    end

  def show
  end

  def update
  end

  def destroy
  end

  def owned_wikis
    @wikis = current_user.owned_wikis
  end

  def collaborated_wikis
    @wikis = current_user.collaborated_wikis
  end
end

private_methods

def load_wiki
  @wiki = Wiki.friendly.find(params[:id])
end
  end
