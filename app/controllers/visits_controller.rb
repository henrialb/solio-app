class VisitsController < ApplicationController
  before_action :set_visit, only: %i[show update destroy]

  def index
    @visits = Visit.all
    render json: VisitBlueprint.render(@visits)
  end

  def create
    @visit = Visit.new(visit_params)
    if @visit.save
      render json: VisitBlueprint.render(@visit)
    else
      render json: @visit.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: VisitBlueprint.render(@visit)
  end

  def update
    if @visit.update(visit_params)
      render json: VisitBlueprint.render(@visit)
    else
      render json: @visit.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @visit.destroy
  end

  private

  def set_visit
    @visit = Visit.find(params[:id])
  end

  def visit_params
    params.require(:visit).permit(:full_name, :name, :dob, :is_active, :citizen_no, :nif_no, :health_no, :social_security_no, :clothes_tag, :sex)
  end
end
