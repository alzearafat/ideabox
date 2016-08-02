class IdeasController < ApplicationController
  before_action :find_idea,          only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :destroy, :update]
  # before_action :correct_user,       only: [:edit, :update, :destroy]

  
  def index
  	@idea = Idea.all.order("created_at DESC")
  end

  def new
  	@idea = Idea.new
  end

  def create
  	@idea = current_user.ideas.build(permit_idea)
  	if @idea.save 
  		flash[:notice] = "Sukses bro!"
  		redirect_to @idea
  	else
  		flash[:error] = "Gagal bro!"
  		render "new"
  	end
  end

  def show
  end

  def edit
    if @idea.user_id != current_user.id
      flash[:notice] = 'Access denied as you are not owner of this Idea'
      redirect_to root_path
    end
  end

  def update
    if @idea.user_id != current_user.id
      flash[:notice] = 'Access denied as you are not owner of this Idea'
      redirect_to root_path
    elsif @idea.user_id == current_user.id
      @idea.update(permit_idea)
      flash[:success] = 'Idea update success!'
      redirect_to @idea 
  	else
  		render 'edit'
  	end
  end

  def destroy
    @idea.destroy
    redirect_to root_path
  end

  private 
  	def find_idea
  		@idea = Idea.find(params[:id])
  	end
  	
  	def permit_idea
  		params.require(:idea).permit(:image, :title, :description)
  	end

    # def correct_user
    #   @idea = Idea.find(params[:id])
    #   redirect_to(root_url) unless @idea == current_user
    # end
end
