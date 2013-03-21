class WorkflowsController < ApplicationController
  def code
    @authorize_url = github_client.auth_code.authorize_url(:redirect_uri => github_url)
  end

  def github
    begin
      token = github_client.auth_code.get_token(params[:code])
      user = JSON.parse(token.get('https://api.github.com/user').body)
      @github_username = user['login']
      @github_display_name = user['name'] || @github_username
      @github_avatar = user['avatar_url']
    rescue OAuth2::Error => e
      puts e
      redirect_to code_path
    end
  end

  private

  def github_client(endpoint = 'https://github.com')
    OAuth2::Client.new(
      ENV['GITHUB_CLIENT'],
      ENV['GITHUB_SECRET'],
      :site => 'https://github.com',
      :authorize_url => '/login/oauth/authorize',
      :token_url => '/login/oauth/access_token'
    )
  end
end
