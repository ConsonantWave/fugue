class PiecesController < ApplicationController
  def index
    @pieces = Piece.all
  end

  def show
    @piece = Piece.find(params[:id])
  end

  def edit
    @piece = Piece.find(params[:id])
  end

  def update
    @piece = Piece.find(params[:id])
    if @piece.update_attributes(params[:piece])
      flash[:notice] = "Update successful."
      redirect_to @piece
    else
      flash[:notice] = "Update failed."
      render :action => :edit
    end
  end
  
  def destroy
    @piece = Piece.find(params[:id])
    @piece.destroy
    redirect_to pieces_path
  end
end
