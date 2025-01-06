class BooksController < ApplicationController
    def index
      @books = GoogleBooksService.search_books(params[:query])
    end
  
    def create
      @book = Book.find_or_initialize_by(api_id: params[:api_id])
      if @book.new_record?
        @book.update(book_params)
      end
      current_user.readings.create(book: @book)
      redirect_to readings_path, notice: '本を追加しました！'
    end
  
    private
  
    def book_params
      params.require(:book).permit(:title, :author, :genre, :api_id, :image_url)
    end
  end
  