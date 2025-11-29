class GoogleBooksService
  include HTTParty
  base_uri 'https://www.googleapis.com/books/v1'

  # 本を検索
  def self.search(query)
    return [] if query.blank?

    response = get('/volumes', query: { 
      q: query, 
      maxResults: 20,
      langRestrict: 'ja',
      key: ENV['GOOGLE_BOOKS_API_KEY'] 
    })
    
    return [] unless response.success?

    response['items']&.map do |item|
      volume_info = item['volumeInfo']
      next unless volume_info

      {
        google_books_id: item['id'],
        title: volume_info['title'],
        author: volume_info['authors']&.join(', ') || '著者不明',
        description: volume_info['description'],
        isbn: extract_isbn(volume_info['industryIdentifiers']),
        publisher: volume_info['publisher'],
        published_date: volume_info['publishedDate'],
        page_count: volume_info['pageCount'],
        cover_url: volume_info.dig('imageLinks', 'thumbnail')&.gsub('http:', 'https:')
      }
    end.compact
  end

  # 特定の本の詳細を取得
  def self.get_book(google_books_id)
    return nil if google_books_id.blank?

    response = get("/volumes/#{google_books_id}", query: { 
      key: ENV['GOOGLE_BOOKS_API_KEY'] 
    })
    
    return nil unless response.success?

    volume_info = response['volumeInfo']
    return nil unless volume_info

    {
      google_books_id: response['id'],
      title: volume_info['title'],
      author: volume_info['authors']&.join(', ') || '著者不明',
      description: volume_info['description'],
      isbn: extract_isbn(volume_info['industryIdentifiers']),
      publisher: volume_info['publisher'],
      published_date: volume_info['publishedDate'],
      page_count: volume_info['pageCount'],
      cover_url: volume_info.dig('imageLinks', 'thumbnail')&.gsub('http:', 'https:')
    }
  end

  private

  # ISBNを抽出（ISBN_13を優先）
  def self.extract_isbn(identifiers)
    return nil unless identifiers

    isbn_13 = identifiers.find { |id| id['type'] == 'ISBN_13' }
    return isbn_13['identifier'] if isbn_13

    isbn_10 = identifiers.find { |id| id['type'] == 'ISBN_10' }
    isbn_10&.dig('identifier')
  end
end
  