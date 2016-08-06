module TryApi
  class PagesController < ActionController::Base

    def index
      render text: 'HELLO from TRY-API !'
    end

  end
end