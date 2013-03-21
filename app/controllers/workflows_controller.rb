class WorkflowsController < ApplicationController
  def code
    @authorize_url = github_client.auth_code.authorize_url(:redirect_uri => github_workflow_url)
  end

  def github
    @github = github_info
  end

  def finish
    github = github_info

    user = User.find_or_create_by_username(github[:username])
    user.avatar = github[:avatar]
    user.displayname = github[:display]
    user.bio = params[:bio]
    user.save!

    redirect_to "/#{user.username}"
  end

  private

  def github_info
    session[:github] ||= begin
      token = github_client.auth_code.get_token(params[:code])
      user = JSON.parse(token.get('https://api.github.com/user').body)

      {
        username: user['login'],
        display: user['name'] || user['login'],
        avatar: user['avatar_url']
      }
    rescue OAuth2::Error => e
      puts e
      redirect_to code_workflow_path
      nil
    end
  end

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
