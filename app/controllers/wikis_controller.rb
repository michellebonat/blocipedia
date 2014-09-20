class WikisController < ApplicationController

  before_action :authenticate_user!

  def index
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = current_user.owned_wikis.new(wiki_params)

    if @wiki.save
      flash[:success] = "Wiki created!"
      redirect_to @wiki
    else
      flash[:error] = "Wiki creation failed."
      redirect_to new_wiki_path
    end
  end

  def show
  end

  def update
  end

  def destroy
  end
end

private_methods

def load_wiki
  @wiki = Wiki.friendly.find(params[:id])
end
