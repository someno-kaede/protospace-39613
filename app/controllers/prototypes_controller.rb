class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :delete]
  before_action :move_to_index, except: [:index, :show, :new, :create]
  before_action :set_prototype, only: [:edit, :show]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    Prototype.create(prototype_params)
    redirect_to '/'
  end

  def update
    prototype = Prototype.find(params[:id])
    prototype.update(prototype_params)
    redirect_to root_path
  end

  def show
    @comment = Comment.new
    @comments = @prototype.comment.includes(:user)
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private

  def prototype_params
    params.require(:prototype).permit(:concept, :catch_copy, :title, :image).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def move_to_index
    ##binding.pry
    unless user_signed_in? && Prototype.find(params[:id]).user_id == current_user.id
      redirect_to action: :index 
    end
  end
end
