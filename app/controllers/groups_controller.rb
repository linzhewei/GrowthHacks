class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.user = current_user

    if @group.save
      current_user.join!(@group)
      redirect_to groups_path, notice: "成功新建讨论版"
    else
      render :new
    end
  end

  def show
    @group = Group.find(params[:id])
    @posts = @group.posts.recent.paginate(:page => params[:page], :per_page => 15)
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    @group.update(group_params)
    redirect_to groups_path, notice: "更新成功"
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to groups_path, alert: "成功删除讨论版"
  end

  def join
     @group = Group.find(params[:id])
      if !current_user.is_member_of?(@group)
        current_user.join!(@group)
        flash[:notice] = "加入本討論版成功！"
      else
        flash[:warning] = "你已經是本討論版成員了！"
      end
        redirect_to group_path(@group)
    end

    def quit
      @group = Group.find(params[:id])

      if current_user.is_member_of?(@group)
        current_user.quit!(@group)
        flash[:alert] = "已退出本討論版！"
      else
        flash[:warning] = "你不是本討論版成員，怎麼退出 XD"
      end

      redirect_to group_path(@group)
    end


  private

  def group_params
    params.require(:group).permit(:title, :description)
  end
end