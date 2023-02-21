class CagesController < ApplicationController
  before_action :set_cage, only: [:show, :update, :destroy]
  before_action :authenticate_user!, only: [:create, :update, :destroy]

  def index
    @cages = Cage.all

    render json: CageSerializer.new(@cages)
  end

  def show
    render json: CageSerializer.new(@cage)
  end

  def create
    @cage = Cage.new(cage_params)

    authorize @cage

    if @cage.save
      render json: CageSerializer.new(@cage), status: :created
    else
      render json: { errors: @cage.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @cage.update(cage_params)
      authorize @cage
      render json: CageSerializer.new(@cage)
    else
      render json: { errors: @cage.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @cage.destroy

    render json: 'Cage destroyed successfully', status: :ok
  end

  private

  def set_cage
    @cage = Cage.find(params[:id])
  end

  def cage_params
    params.permit(:name, :max_capacity, :power_status, :dinosaurs_count)
  end
end
