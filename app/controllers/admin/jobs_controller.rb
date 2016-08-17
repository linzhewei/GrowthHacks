class Admin::JobsController < ApplicationController
  def index
    @jobs = Job.all
  end

  def new
    @job = Job.new
  end

  def edit
    @job = Job.find(params[:id])
  end

  def show
    @job = Job.find(params[:id])
  end

  def create
    @job = Job.new(job_params)

    if @job.save
      redirect_to jobs_path
    else
      render :new
    end
  end

  def update
    @job = Job.find(params[:id])

    if @job.update(job_params)
      redirect_to jobs_path,notice:"Update Success"
    else
      render :edit
    end
  end

  def destroy
    @job = Job.find(params[:id])

    @job.destroy
    redirect_to jobs_path,alert:"Job deleted"
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :wage_upper_bound, :wage_lower_bound, :contact_email, :work_address, :work_experience, :company, :company_description)
  end

end