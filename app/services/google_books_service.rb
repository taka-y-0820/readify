class GoogleBooksService
    include HTTParty
    base_uri 'https://www.googleapis.com/books/v1'
  
    def self.search_books(query)
      response = get('/volumes', query: { q: query, key: ENV['GOOGLE_BOOKS_API_KEY'] })
      return [] unless response.success?
  
      response['items'].map do |item|
        {
          title: item.dig('volumeInfo', 'title'),
          author: item.dig('volumeInfo', 'authors')&.join(', '),
          genre: item.dig('volumeInfo', 'categories')&.join(', '),
          api_id: item['id'],
          image_url: volume_info.dig('imageLinks', 'thumbnail') || ''
        }
      end
    end
  end
  