DigitalServicesCore::EnrollmentsController.class_eval do

  before_filter :setup_form_object

  def create

    unless @form.validate(params[:enrollment])
      puts "FORM VALIDATIOn FAILED #{@form.model.inspect}"
    end

    respond_to do |format|
      if @form.save

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
    @form = "FloodRiskEngine::Steps::#{@enrollment.state.classify}Form".constantize.factory(@enrollment)

    unless @form.validate(params[:enrollment])
      puts "Failed Validation - #{@form.inspect}"
      redirect_to(digital_services_core.enrollment_state_path(@enrollment.state, @enrollment)) && return
    end if(params[:enrollment])

    respond_to do |format|

      logger.debug "Calling SAVE ON - #{@form.inspect}"
      form_saved = begin
        @form.save
      rescue => x
        logger.debug "PROTOTYTPE- SAVBE FAILED= MOVING ON"
        logger.debug x.inspect
        true
      end

      if(form_saved)
        puts "Form SAVED - Calling Next - #{@form.inspect}"
        @enrollment.next!

        format.html do
          redirect_to(digital_services_core.enrollment_state_path(@enrollment.state, @enrollment)) && return
        end
      else
        logger.error("Form Could NOT be SAVED - #{@form.inspect}")
        logger.error(@form.model.errors.inspect)

        puts "Just a PROTOTYOPE - CALLING NEXT ANYWAY"

        @enrollment.next!

        format.html {
          redirect_to(digital_services_core.enrollment_state_path(@enrollment.state, @enrollment)) && return
        }
      end
    end
  end

  private

  def setup_form_object
    @enrollment ||= DigitalServicesCore::Enrollment.new

    puts "IN setup_form_object - FloodRiskEngine::Steps::#{@enrollment.state.classify}"
    @form = "FloodRiskEngine::Steps::#{@enrollment.state.classify}Form".constantize.factory(@enrollment)
  end

  def enrollment_params
    params
  end


end

