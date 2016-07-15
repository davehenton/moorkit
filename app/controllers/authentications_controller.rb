require 'moorkit/user_authentication'

class AuthenticationsController < ApplicationController
  def create

    auth_payload = entitize_auth_hash(auth_hash)
    user = find_user(auth_payload)
    user = create_user(auth_payload) if user.nil?
    set_current_user(user)
    redirect_to root_path
  end

  def failure
    render json: auth_hash.to_json
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

  def entitize_auth_hash(hsh)
    Moorkit::UserAuthentication.entitize_auth_hash_context.call(auth_hash: hsh)
  end

  def find_user(payload)
    Moorkit::UserAuthentication.find_user_context.call(auth_payload: payload)
  end

  def create_user(payload)
    Moorkit::UserAuthentication.create_user_context.call(auth_payload: payload)
  end

  def set_current_user(user)
    session[:user_id] = user.id
  end
end
