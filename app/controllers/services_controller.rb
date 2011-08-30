class ServicesController < ApplicationController
  before_filter :authenticate_user!, :except => [:create, :signin, :signup, :newaccount, :failure]

  protect_from_forgery :except => [:destroy, :create]

  # User is disassociating this service from their account
  def destroy
    @service = Service.find_by_id_and_user_id(params[:id], current_user.id)
    @service.destroy

    flash[:success] = "Removed the #{@service.provider.capitalize} service from your account"
    redirect_to account_url
  end

  # This handles signing in and adding new auth services to existing accounts
  # Renders a separate view if there's a new User to create.
  def create
    params[:service] ? service_route = params[:service] : service_route = 'No service recognized (invalid callback)'

    omniauth = request.env['omniauth.auth']
    @authhash = Hash.new

    if omniauth and params[:service]
      omniauth['user_info']['email'] ? @authhash[:email] =  omniauth['user_info']['email'] : @authhash[:email] = ''
      omniauth['user_info']['name'] ? @authhash[:name] =  omniauth['user_info']['name'] : @authhash[:name] = ''
      omniauth['uid'] ? @authhash[:uid] = omniauth['uid'].to_s : @authhash[:uid] = ''
      omniauth['provider'] ? @authhash[:provider] = omniauth['provider'] : @authhash[:provider] = ''

      if @authhash[:uid] != '' and @authhash[:provider] != ''
        auth = Service.find_by_provider_and_uid @authhash[:provider], @authhash[:uid]

        # if the user is already signed in, they might want
        # to add another account
        if user_signed_in?
          if auth
            flash[:info] = "Your account at #{@authhash[:provider].capitalize} is already connected with this site."
          else
            current_user.services.create!(
              provider: @authhash[:provider],
              uid:      @authhash[:uid],
              uname:    @authhash[:uname],
              uemail:   @authhash[:uemail]
            )
            flash[:success] = "Your #{@authhash[:provider].capitalize} account has been added."
          end

          redirect_to account_url
        else
          if auth
            # signin existing user
            session[:user_id] = auth.user_id
            session[:service_id] = auth.id

            flash[:success] = "Logged in successfully!"
            redirect_to root_url
          else
            # new user
            @newuser = User.new
            @newuser.name = @authhash[:name]
            @newuser.email = @authhash[:email]
            @newuser.services.build(:provider => @authhash[:provider], :uid => @authhash[:uid], :uname => @authhash[:name], :uemail => @authhash[:email])

            if @newuser.save!
              # signin existing user
              # in the session his user id and the service id used for signing in is stored
              session[:user_id] = @newuser.id
              session[:service_id] = @newuser.services.first.id

              flash[:success] = 'Your account has been created and you have been signed in!'
              redirect_to root_url
            else
              flash[:error] = 'This is embarrassing! There was an error while creating your account from which we were not able to recover.'
              redirect_to root_url
            end  
          end
        end
      else
        flash[:error] = "Error while authenticating via #{service_route}/#{authhash[:provider].capitalize}. " +
                      "The service returned invalid data for the user ID."
                      redirect_to signin_path
      end
    else
      flash[:error] = "Error while authentication via #{service_route.capitalize}. The service did not return valid data."
      redirect_to signin_path
    end
  end

  def signin
  end

  def signout
    if current_user
      reset_session
      flash[:info] = 'You have been signed out.'
    end

    redirect_to root_url
  end

  def failure
    flash[:error] = 'There was an error at the remote authentication service. You have not been signed in.'
    redirect_to root_url
  end
end
