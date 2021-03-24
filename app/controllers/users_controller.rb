class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    @name = user.name
    @prototype = user.prototypes
    @profile = user.profile
    @occupation = user.occupation
    @position = user.position
  end

end
