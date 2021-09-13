class PolicyPlansController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :choose_institution, :choose_gamebook, :choose_timeline, :open_accordion]

  def show
    set_policy_plan
    @policy_making = @policy_plan.policy_making
    @policy_plan_institutions = PolicyPlanInstitution.where(policy_plan: @policy_plan)
    @goals = Goal.where(policy_plan: @policy_plan).order(:order)
    @timesteps = Timestep.where(policy_plan: @policy_plan).order(:date)
    set_gamebook
  end

  def choose_institution
    # when the user clicks in one of the institutions cards
    # we call this method and pass the needed ids in the params
    @policy_plan = PolicyPlan.find(params[:policy_plan_id])
    @policy_plan_institutions = PolicyPlanInstitution.where(policy_plan: @policy_plan)
    @policy_plan_institution = PolicyPlanInstitution.find(params[:policy_plan_institution_id])
    # then it renders choose_institution.js.erb automatically
    # which in turn renders the institution_description.html.erb partial
  end

  def choose_gamebook
    @selected = 'gamebook'
    set_policy_plan
    set_gamebook
  end

  def choose_timeline
    @selected = 'timeline'
    set_policy_plan
    @timesteps = Timestep.where(policy_plan: @policy_plan).order(:date)
  end

  def open_accordion
    @policy_plan = PolicyPlan.find(params[:policy_plan_id])
    @goal = Goal.find(params[:goal_id])
    @game_question = GameQuestion.where(policy_plan: @policy_plan).find_by(order: @goal.order)
    @game_answers = GameAnswer.where(game_question: @game_question)
  end

  private

  def set_policy_plan
    @policy_plan = PolicyPlan.find(params[:id])
  end

  def set_gamebook
    @game_questions = GameQuestion.where(policy_plan: @policy_plan)
    @game_questions = @policy_plan.strategy ? @game_questions.order(:order) : @game_questions.order(:date)
    @next_question = @game_questions.first
    @next_answers = GameAnswer.where(game_question: @next_question)
  end
end
