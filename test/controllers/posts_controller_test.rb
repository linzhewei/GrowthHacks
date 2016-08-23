# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  content     :text
#  issue_id    :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  title       :string
#  author      :string
#  issue       :string
#  tag         :string
#  origin_link :string
#  PV          :string
#  favorite    :string
#  introduce   :string
#

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
end
