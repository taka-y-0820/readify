class HomeController < ApplicationController
  skip_before_action :require_login
  
  def index
    # ホームページは未ログイン/ログイン済み両方で表示可能
    # ビューで logged_in? を使って表示を切り替える
  end
end
