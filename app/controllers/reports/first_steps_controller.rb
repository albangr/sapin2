# frozen_string_literal: true

module Reports
  # Handles the actions linked to the first step of the report creation (prospect and company infos)
  class FirstStepsController < ApplicationController
    def new
      @form = ReportInitializationForm.new
    end

    def create
      @form = ReportInitializationForm.new(report_initialization_form_params)
      if @form.save
        report = ReportInitializor.new(@form.company.id).call
        prospect = report.company.prospect
        if report.report_obligations.includes(:obligation).where(status: "not_needed").count == 8
          redirect_to "/pages/not_needed"
        else
          sign_out(current_prospect)
          sign_in(:prospect, prospect)
          redirect_to report_path(report)
        end
      else
        render :new
      end
    end

    def show
        @report = Report.find(params[:id])
        if !current_prospect.nil?
          unless current_prospect.company.report == @report || current_admin_user.nil?
            redirect_to root_path
          end
        else
          redirect_to root_path
        end
    end

    private

    def report_initialization_form_params
      params.require(:report_initialization_form).permit(:first_name, :phone_number, :email,
                                                         :role, :localisation, :firm_name, :firm_type,
                                                         :employees_count, :turnover, :password)
    end
  end
end
