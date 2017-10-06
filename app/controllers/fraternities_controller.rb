class FraternitiesController < ApplicationController
  def index
    authorize Fraternity
    load_fraternities
  end

  def show
    authorize @fraternity
  end

  def new
    @fraternity = fraternity_scope.build
    authorize @fraternity
  end

  def edit
    authorize @fraternity
    build_fraternity
  end

  def create
    authorize Fraternity
    CreateFraternity.call(name: fraternity_params[:name], user: current_user) do |result|
      result.success { redirect_to fraternities_path }
      result.failure do |fraternity|
        @fraternity = fraternity
        render :new
      end
    end
  end

  def update
    authorize @fraternity
    build_fraternity

    if @fraternity.save
      redirect_to root_url
    else
      render :edit
    end
  end

  def destroy
    authorize @fraternity

    @fraternity.destroy

    redirect_to fraternities_path
  end

  private

  def load_fraternities
    @fraternities ||= fraternity_scope
  end

  def build_fraternity
    @fraternity ||= fraternity_scope.build
    @fraternity.attributes = fraternity_params
  end

  def fraternity_params
    params.fetch(:fraternity, {}).permit(:name)
  end
end
