# frozen_string_literal: true

module Reports
  # Handles the actions linked to the management of the final report
  class DashboardsController < ApplicationController
    def show
      @dashboard = ReportDashboardFacade.new(params[:report_id])
      unless current_prospect.company.report.id == params[:report_id] || current_admin_user.nil?
        redirect_to root_path
      end
      # @prospect_pdf = issue_id << ".pdf"
      respond_to  do |format|
        format.html
        format.pdf do
          # chart_hash = @issue.chart.split('"')
          # @mainChart = chart_hash[1]
          # @linkedinChart = chart_hash[3]
          # mailchimp_hash = @issue.mailchimp.split('"')
          # @camembert = mailchimp_hash[1]
          # @historique = mailchimp_hash[3]
          pdf = render :pdf => "Dashboard-sapin",
                       :viewport_size => '1280x1024',
                       :layout => "pdf_layout.html.erb",
                       :disable_javascript => false
        end
      end
    end
  end
end
