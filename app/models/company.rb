# frozen_string_literal: true
# == Schema Information
#
# Table name: companies
#
#  id                    :integer          not null, primary key
#  localisation          :integer
#  firm_type             :integer
#  employees_count       :integer
#  turnover              :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  prospect_id           :integer
#  firm_name             :string
#  daughter_localisation :string
#
# Indexes
#
#  index_companies_on_prospect_id  (prospect_id)
#

# Model the company the prospects belongs to and
# its properties which will allow generate the report
class Company < ApplicationRecord
  enum localisation: %i[in_france abroad]
  enum daughter_localisation: %i[local broad]
  enum firm_type: %i[epic subsidiary company_group company]
  enum turnover: %i[small_turnover big_turnover]
  enum employees_count: %i[small medium large]

  belongs_to :prospect
  has_one :report, dependent: :nullify

  validates :localisation, presence: true, inclusion: { in: localisations.keys }
  validates :firm_type, presence: true, inclusion: { in: firm_types.keys }
  validates :turnover, presence: true, inclusion: { in: turnovers.keys }
  validates :employees_count, presence: true, inclusion: { in: employees_counts.keys }

  def calculate_score
    score = score_company_type + score_localisation + score_employees_count + score_turnover
    score.positive? ? score : 0
  end

  private

  def score_company_type
    subsidiary? ? 0.5 : 1
  end

  def score_localisation
    in_france? ? 5 : 0
  end

  def score_employees_count
    case employees_count
    when 'small'
      -5
    when 'medium'
      0.5
    when 'large'
      5
    end
  end

  def score_turnover
    small_turnover? ? 0.5 : 5
  end
end
