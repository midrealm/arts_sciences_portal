class DivisionRubricsController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin
  before_action :set_division, only: [:show]

  def index
    @show_deprecated = ActiveModel::Type::Boolean.new.cast(params[:show_deprecated])
    @divisions = DivisionRepository.for_index(show_deprecated: @show_deprecated).default_order
  end

  def show
    @show_deprecated = ActiveModel::Type::Boolean.new.cast(params[:show_deprecated])
    @criteria_types = CriteriaType.by_division(@division).top_level
    @criteria_types = @criteria_types.where(deprecated: false) unless @show_deprecated
    @criteria_types = @criteria_types.includes(:criteriums).to_a
    @criteria_types.sort_by! { |criteria_type| criteria_type_sort_index(criteria_type) }
  end

  private

  def set_division
    @division = Division.find(params[:id])
  end

  def criteria_type_sort_index(criteria_type)
    CriteriaType::ORDER_ARRAY.index(criteria_type.description) || CriteriaType::ORDER_ARRAY.size
  end
end
