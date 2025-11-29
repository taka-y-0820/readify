class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  
  def index
    # 1回のクエリで全ての本を取得し、メモリ上でフィルタリング
    all_books = current_user.books.order(updated_at: :desc).to_a
    @books = all_books
    @reading_books = all_books.select { |b| b.status == "reading" }
    @finished_books = all_books.select { |b| b.status == "finished" }
    @want_to_read_books = all_books.select { |b| b.status == "want_to_read" }
  end
  
  def show
    @readings = @book.readings.recent
    @new_reading = @book.readings.build
  end
  
  def new
    @book = current_user.books.build
  end
  
  def create
    @book = current_user.books.build(book_params)
    
    if @book.save
      redirect_to @book, notice: "本を追加しました"
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
  end
  
  def update
    if @book.update(book_params)
      redirect_to @book, notice: "本の情報を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @book.destroy
    redirect_to library_path, notice: "本を削除しました"
  end
  
  def search
    if params[:query].present?
      @results = GoogleBooksService.search(params[:query])
    else
      @results = []
    end
  rescue => e
    Rails.logger.error "Google Books API Error: #{e.message}"
    @results = []
    flash.now[:alert] = "検索中にエラーが発生しました"
  end
  
  def add_from_google
    book_data = GoogleBooksService.get_book(params[:google_books_id])
    
    if book_data.nil?
      redirect_to search_books_path, alert: "本の情報を取得できませんでした"
      return
    end
    
    @book = current_user.books.build(
      title: book_data[:title],
      author: book_data[:author],
      description: book_data[:description],
      isbn: book_data[:isbn],
      publisher: book_data[:publisher],
      published_date: book_data[:published_date],
      page_count: book_data[:page_count],
      cover_url: book_data[:cover_url],
      google_books_id: params[:google_books_id],
      status: :want_to_read
    )
    
    if @book.save
      redirect_to library_path, notice: "「#{@book.title}」を本棚に追加しました"
    else
      redirect_to search_books_path(query: book_data[:title]), alert: "本の追加に失敗しました"
    end
  rescue => e
    Rails.logger.error "Add from Google Books Error: #{e.message}"
    redirect_to search_books_path, alert: "本の追加中にエラーが発生しました"
  end
  
  private
  
  def set_book
    @book = current_user.books.find(params[:id])
  end
  
  def book_params
    params.require(:book).permit(:title, :author, :description, :isbn, :publisher, :published_date, :page_count, :cover_url, :status, :progress)
  end
end
  