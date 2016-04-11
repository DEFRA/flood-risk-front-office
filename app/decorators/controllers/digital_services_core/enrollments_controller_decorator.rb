DigitalServicesCore::EnrollmentsController.class_eval do

  before_filter :setup_form_object

  def create
    @form = "States::#{@enrollment.state.classify}State::Form".constantize.new(@enrollment.state.classify.constantize.new)

    unless @form.validate(params[:enrollment])
      redirect_to(digital_services_core.enrollment_state_path(@enrollment.state, @enrollment)) && return
    end

    respond_to do |format|
      if @form.save_enrollemt(@enrollment)

        @enrollment.next!

        format.html do
          redirect_to(digital_services_core.enrollment_state_path(@enrollment.state, @enrollment)) && return
        end
      else
        format.html { render :new }
      end
    end
  end

  def update
    @form = "States::#{@enrollment.state.classify}State::Form".constantize.new(@enrollment)

    unless @form.validate(params[:enrollment])
      redirect_to(digital_services_core.enrollment_state_path(@enrollment.state, @enrollment)) && return
    end

    respond_to do |format|
      if @form.save_enrollemt(@enrollment)

        @enrollment.next!

        format.html do
          redirect_to(digital_services_core.enrollment_state_path(@enrollment.state, @enrollment)) && return
        end
      else
        format.html { render :new }
      end
    end
  end

  private

  def setup_form_object
    @enrollment ||= DigitalServicesCore::Enrollment.new

    @form = "States::#{@enrollment.state.classify}State::FormBuilder".constantize.call(@enrollment)
  end

  def enrollment_params
    params
  end


end

