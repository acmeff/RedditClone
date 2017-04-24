class SubsController < ApplicationController
  before_action :ensure_moderator, only: [:edit, :update]

  def index
  end

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.user_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      redirect_to subs_url
    end
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def ensure_moderator
    unless current_user.subs.where(id: params[:id]).exists?
      redirect_to sub_url(Sub.find(params[:id]))
      flash[:errors] = ["Only a moderator can edit a sub"]
    end
  end

  def update
    sub = Sub.find(params[:id])
    if sub.update_attributes(sub_params)
      redirect_to sub_url(sub)
    else
      flash[:errors] = sub.errors.full_messages
      redirect_to sub_url(sub)
    end
  end

  def show
    @sub = Sub.find(params[:id])
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
