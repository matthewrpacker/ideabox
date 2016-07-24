class IdeasController < ApplicationController

  def new
    @idea = Idea.new
  end

  def create
    @idea = Idea.new(idea_params)
    @user = User.find(params[:user_id])
    if @idea.save
      @idea.update(user_id: @user.id)
      flash[:notice] = "Idea Created!"
      redirect_to user_idea_path(@user, @idea.id)
    else
      flash.now[:error] = @idea.errors.full_messages.join(", ")
      render :new
    end
  end

  def show
    @idea = Idea.find(params[:id])
  end

  private

  def idea_params
    params.require(:idea).permit(:name, :description)
  end

end
