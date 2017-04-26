# frozen_string_literal: true

class AboutController < ApplicationController
  before_action :set_body_classes
  before_action :set_instance_presenter, only: [:show, :more, :terms]

  def show
    serializable_resource = ActiveModelSerializers::SerializableResource.new(InitialStatePresenter.new(initial_state_params), serializer: InitialStateSerializer)
    @initial_state_json   = serializable_resource.to_json
    registration_secret = ENV.fetch('REGISTRATION_SECRET', 'pineapples')
    if @instance_presenter.open_registrations && registration_secret
      # if url has the correct secret passphrase set, show the registration form
      if params[:secret] == registration_secret
        @show_registration = true
      else
        @show_registration = false
      end
    else
      @show_registration = @instance_presenter.open_registrations
    end
  end

  def more; end

  def terms; end

  private

  def new_user
    User.new.tap(&:build_account)
  end

  helper_method :new_user

  def set_instance_presenter
    @instance_presenter = InstancePresenter.new
  end

  def set_body_classes
    @body_classes = 'about-body'
  end

  def initial_state_params
    {
      settings: {},
      token: current_session&.token,
    }
  end
end
