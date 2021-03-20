class PrototypesController < ApplicationController
  def index
    
  end

  def new
    @prototype = Prototype.new(params[:id])
  end


  def create
    if
    Prototype.create(prototype_params)
      redirect_to root_path
    else
      render :new
    end

  end


  private
  def prototype_params
    params.require(:prototype).permit(:image,:title,:catch_copy,:concept).merge(user_id: current_user.id)
  end

end
