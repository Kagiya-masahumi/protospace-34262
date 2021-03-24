class PrototypesController < ApplicationController
  def index
    @prototypes = Prototype.all 
    
  end

  def new
    @prototype = Prototype.new(params[:id])
  end


  def create
    if Prototype.create(prototype_params)
      redirect_to root_path
    else
      render "prototypes/new"
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)

  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path, method: :get
    else
      render :edit
    end

  end


  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end



  private
  def prototype_params
    params.require(:prototype).permit(:image,:title,:catch_copy,:concept).merge(user_id: current_user.id)
  end

end
