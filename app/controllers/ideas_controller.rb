class IdeasController < ApplicationController

  def index
    @ideas = Idea.all
  end

  def new
    @idea = Idea.new
  end

  def create
    @idea = Idea.new(idea_params)
    @user = User.find(params[:user_id])
    if @idea.save
      @idea.update(user_id: @user.id)
      flash[:notice] = "Idea Created!!"
      redirect_to user_ideas_path(current_user)
    else
      flash.now[:error] = @idea.errors.full_messages.join(", ")
      render :new
    end
  end

  def show
    @idea = Idea.find(params[:id])
    if @idea.user != current_user
      redirect_to login_path
    end
  end

  def edit
    @idea = Idea.find(params[:id])
    if @idea.user != current_user
      redirect_to login_path
    end
  end

  def update
    @idea = Idea.find(params[:id])
    if @idea.update_attributes(idea_params)
      redirect_to user_idea_path(current_user, @idea.id)
    else
      render :edit
    end
  end

  def destroy
    @idea = Idea.find(params[:id])
    @idea.destroy
    redirect_to user_ideas_path(current_user)
  end

  private

  def idea_params
    params.require(:idea).permit(:name, :description)
  end

end
