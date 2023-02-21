class DinosaursController < ApplicationController
  before_action :set_dinosaur, only: [:show, :update, :destroy]
  before_action :authenticate_user!, only: [:create, :update, :destroy]

  def index
    if params[:cage_id]
      @dinosaurs = Cage.find(params[:cage_id]).dinosaurs
    else
      @dinosaurs = Dinosaur.all
    end

    render json: DinosaurSerializer.new(@dinosaurs)
  end

  def show
    render json: DinosaurSerializer.new(@dinosaur)
  end

  def create
    @dinosaur = Dinosaur.new(dinosaur_params)
    authorize @dinosaur

    if @dinosaur.save
      render json: DinosaurSerializer.new(@dinosaur), status: :created
    else
      render json: { errors: @dinosaur.errors }, status: :unprocessable_entity
    end
  end

  def update
    authorize @dinosaur
    if @dinosaur.update(dinosaur_params)
      render json: DinosaurSerializer.new(@dinosaur)
    else
      render json: { errors: @dinosaur.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @dinosaur.destroy

    render json: 'Dinosaur destroyed successfully', status: :ok
  end

  private

  def set_dinosaur
    @dinosaur = Dinosaur.find(params[:id])
  end

  def dinosaur_params
    params.permit(:name, :species, :diet, :cage_id)
  end
end
