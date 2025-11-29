class ReadingsController < ApplicationController
  before_action :set_book
  before_action :set_reading, only: [:edit, :update, :destroy]

  def create
    @reading = @book.readings.build(reading_params)
    @reading.user = current_user
    
    if @reading.save
      redirect_to book_path(@book), notice: "読書記録を追加しました"
    else
      @readings = @book.readings.order(created_at: :desc)
      @new_reading = @reading
      render "books/show", status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @reading.update(reading_params)
      redirect_to book_path(@book), notice: "読書記録を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @reading.destroy
    redirect_to book_path(@book), notice: "読書記録を削除しました"
  end

  private

  def set_book
    @book = current_user.books.find(params[:book_id])
  end

  def set_reading
    @reading = @book.readings.find(params[:id])
  end

  def reading_params
    params.require(:reading).permit(:note, :review, :rating, :started_at, :finished_at)
  end
end
