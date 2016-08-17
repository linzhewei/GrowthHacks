class Admin::IssuesController < ApplicationController
  before_action :authenticate_user!
  before_filter :require_is_admin
  def index
    @issues = Issue.all
  end

  def new
    @issue = Issue.new
  end

  def create
    @issue = Issue.new(issue_params)
    @issue.user = current_user
    if @issue.save
    redirect_to issues_path, notice: "成功新建讨论版"
    else
      render :new
    end
  end

  def show
    @issue = Issue.find(params[:id])
    @posts = @issue.posts.recent.paginate(:page => params[:page], :per_page => 15)
  end

  def edit
    @issue = Issue.find(params[:id])
  end

  def update
    @issue = Issue.find(params[:id])
    @issue.update(issue_params)
    redirect_to issues_path, notice: "更新成功"
  end

  def destroy
    @issue = Issue.find(params[:id])
    @issue.destroy
    redirect_to issues_path, alert: "成功删除讨论版"
  end

  private

  def issue_params
    params.require(:issue).permit(:title, :description)
  end
end