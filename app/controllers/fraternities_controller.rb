class FraternitiesController < ApplicationController
  def index
    authorize Fraternity
    load_fraternities
  end

  def show
    load_fraternity
    authorize @fraternity
  end

  def new
    build_fraternity
    authorize @fraternity
  end

  def edit
    load_fraternity
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
    load_fraternity
    authorize @fraternity
    build_fraternity

    if @fraternity.save
      redirect_to root_url
    else
      render :edit
    end
  end

  def destroy
    load_fraternity
    authorize @fraternity

    @fraternity.destroy

    redirect_to fraternities_path
  end

  private

  def load_fraternity
    @fraternity ||= fraternity_scope.find(params[:id])
  end

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

  def fraternity_scope
    current_user.fraternities
  end
end
