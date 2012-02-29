require 'httparty'

class Githubris::API
  include HTTParty
  base_uri 'https://api.github.com'
  format :json

  GISTS_PER_PAGE = 30
  PUBLIC_GISTS_PATH = '/gists/public'

  def initialize
    @builder = Githubris::Builder.new
  end

  def authenticate!(options={})
    Githubris::API.basic_auth options[:login], options[:password]
  end

  def get_public_gists(options={})
    quantity = options.delete(:quantity) || 30
    number_of_overflow_gists = quantity % GISTS_PER_PAGE
    if quantity > GISTS_PER_PAGE
      max_page_number = (quantity / GISTS_PER_PAGE) +
        (number_of_overflow_gists > 0 ? 1 : 0)

      data = Githubris::API.get public_gists_path_for_page(max_page_number)
      gists = @builder.build(data).
        concat(get_public_gists(quantity: quantity - GISTS_PER_PAGE))
    else
      url = PUBLIC_GISTS_PATH
      data = Githubris::API.get(url)
      gists = @builder.build(data)
    end
    gists.shift(quantity)
  end

  def get_user(options={})
    Githubris::User.new
  end

  def public_gists_path_for_page page_number
    "#{PUBLIC_GISTS_PATH}?page=#{page_number}"
  end
end
