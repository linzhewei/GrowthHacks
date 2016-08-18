# == Schema Information
#
# Table name: jobs
#
#  id                  :integer          not null, primary key
#  title               :string
#  description         :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :integer
#  wage_upper_bound    :integer
#  wage_lower_bound    :integer
#  contact_email       :string
#  work_address        :string
#  work_experience     :string
#  company             :string
#  company_description :text
#

require 'test_helper'

class JobsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
end
