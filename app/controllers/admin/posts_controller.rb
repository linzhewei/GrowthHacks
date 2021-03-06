class Admin::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_is_admin
  layout 'admin'

  def index
    @posts = Post.all.paginate(page: params[:page], per_page: 10)
  end

  def show
    if params[:issue_id]
      @issue = Issue.find(params[:issue_id])
      @post = Post.find(params[:id])
      drop_breadcrumb(@issue.title, admin_issue_path(@issue))
      drop_breadcrumb('正文')
    else
      @post = Post.find(params[:id])
      drop_breadcrumb('正文')
    end
  end

  def edit
    @post = Post.find(params[:id])
    drop_breadcrumb(@post.title, admin_post_path(@post))
  end

  def new
    @issue = Issue.find(params[:issue_id])
    @post = Post.new
  end

  def create
    @issue = Issue.find(params[:issue_id])
    @post = Post.new(post_params)
    @post.issue = @issue
    @post.user = current_user
    if @post.save
      redirect_to admin_issue_path(@issue), notice: 'Create Sueecss'
    else
      render :new, notice: 'Failed to create'
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to admin_post_path, notice: 'Update Success'
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])

    if @post.destroy
      redirect_to :back, notice: 'Delete Success'
    else
      render :back, notice: 'Failed to delete'
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, :title, :author, :tag, :origin_link, :pv, :image, :brief_introduction)
  end
end
