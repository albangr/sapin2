# frozen_string_literal: true

module Reports
  # Handles the actions linked to the second step of the report creation (minor obligations' tasks)
  class ThirdStepsController < ApplicationController
    def new
      @report = Report.find(params[:report_id])
      @report_obligations = @report.report_obligations.minor.includes(obligation: :tasks)
    end

    def create
      @form = ReportTasksCreationForm.new(report_third_step_params)
      if @form.save
        redirect_to report_dashboard_path(params[:report_id])
      else
        render :new
      end
    end

    private

    def report_third_step_params
      params.permit(report_tasks: %i[status task_id report_obligation_id])
    end
  end
end
