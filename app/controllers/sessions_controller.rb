#
#    ====================================================================
#    This file is part of LibreCMS.
#
#    Foobar is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    any later version.
#
#    Foobar is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
#    ====================================================================
#

# This controller handles the login/logout function of the site.  

class SessionsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  #include AuthenticatedSystem
  before_filter :login_required, :only => :destroy
  before_filter :not_logged_in_required, :only => [:new, :create]

  # render new.rhtml
  def new
  end

  #def create
  #  self.current_user = User.authenticate(params[:login], params[:password])
  #  if logged_in?
  #    if params[:remember_me] == "1"
  #      current_user.remember_me unless current_user.remember_token?
  #      cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
  #    end
  #    redirect_back_or_default('/')
  #    flash[:notice] = "Logged in successfully"
  #  else
  #    render :action => 'new'
  #  end
  #end
  
  def create
    password_authentication(params[:login], params[:password])
  end

  def destroy
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    #redirect_back_or_default('/')
    redirect_to login_path
  end

  protected
  
  def password_authentication(login, password)
    user = User.authenticate(login, password)
    if user == nil
      failed_login("Your username or password is incorrect.")
    elsif user.enabled == false
      failed_login("Your account has been disabled.")
  #  elsif user.activated_at.blank?  
  #    failed_login("Your account is not active, please check your email for the activation code.")
    elsif
      self.current_user = user
      successful_login
    end
  end


  private
  
  def failed_login(message)
    @message = message
    render :action => 'new'
  end

  def successful_login
    if params[:remember_me] == "1"
      self.current_user.remember_me
      cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
    end
      flash[:notice] = "Logged in successfully"
      return_to = session[:return_to]
      if return_to.nil?
        redirect_to user_path(self.current_user)
      else
        redirect_to return_to
      end
  end
  
end
