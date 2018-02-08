# frozen_string_literal: true
# == Schema Information
#
# Table name: prospects
#
#  id                     :integer          not null, primary key
#  first_name             :string
#  address                :jsonb
#  phone_number           :string
#  email                  :string
#  role                   :integer
#  is_responsible         :boolean          default(FALSE), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#

# Model the prospects who will use the website to generate a report
class Prospect < ApplicationRecord
  enum role: %i[admin_board directory operation_director surveillance_board other]

  devise :database_authenticatable, :rememberable, :trackable, :validatable

  has_one :company, dependent: :nullify

  validates :role, presence: true, inclusion: { in: Prospect.roles.keys }
  validates :first_name, presence: true
  validates_plausible_phone :phone_number, presence: true
  validates :email, presence: true, email: true
end
