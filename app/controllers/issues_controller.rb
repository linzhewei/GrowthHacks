class IssuesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new, :edit, :destroy, :update, :join, :quit]

  def index
    @issues = Issue.all.recent.paginate(page: params[:page], per_page: 10)
  end

  def show
    @issue = Issue.find(params[:id])

    @posts = @issue.posts.recent.paginate(page: params[:page], per_page: 15)
    drop_breadcrumb(@issue.title)
  end

  private
end
