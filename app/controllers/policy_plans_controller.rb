class PolicyPlansController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :choose_institution, :choose_gamebook, :choose_timeline, :open_accordion, :close_accordion]

  def index
    @policy_plans = PolicyPlan.all
  end

  def show
    set_policy_plan
    @policy_making = @policy_plan.policy_making
    @policy_plan_institutions = PolicyPlanInstitution.where(policy_plan: @policy_plan)
    @goals = Goal.where(policy_plan: @policy_plan).order(:order)
    @timesteps = Timestep.where(policy_plan: @policy_plan).order(:date)
    set_gamebook
    @young_contributors = YoungContributor.where(policy_plan: @policy_plan)
  end

  def new
    @policy_plan = PolicyPlan.new
  end

  def create
    @policy_plan = PolicyPlan.new(policy_plan_params)
    if @policy_plan.save
      redirect_to edit_policy_plan_path(@policy_plan)
    else
      render :new
    end
  end

  def edit
    set_policy_plan
    prepare_data_for_policy_plan_edit
  end

  def update
    set_policy_plan
    @policy_plan.update(policy_plan_params)
    respond_to { |format| format.js }
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

  def close_accordion
    @policy_plan = PolicyPlan.find(params[:policy_plan_id])
    @goal = Goal.find(params[:goal_id])
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

  def policy_plan_params
    params.require(:policy_plan).permit(:policy_making_id, :name, :short_description, :content, :strategy, :video_url, :video_alt_text, :video_source, :ambassador_id)
  end

  def prepare_data_for_policy_plan_edit
    @policy_making = @policy_plan.policy_making
    @policy_plan_institutions = PolicyPlanInstitution.where(policy_plan: @policy_plan)
    @new_policy_plan_institution = PolicyPlanInstitution.new
    @new_institution = Institution.new
    @timesteps = Timestep.where(policy_plan: @policy_plan).order(:date)
    @new_timestep = Timestep.new
    @game_questions = GameQuestion.where(policy_plan: @policy_plan)
    @game_questions = @policy_plan.strategy ? @game_questions.order(:order) : @game_questions.order(:date)
    @new_game_question = GameQuestion.new
    @game_answers = {}
    @game_questions.each do |game_question|
      @game_answers[game_question.id] = GameAnswer.where(game_question: game_question)
    end
    @new_game_answer = GameAnswer.new
    @goals = Goal.where(policy_plan: @policy_plan).order(:order)
    @goals_n_games = []
    if @policy_plan.strategy
      @goals.each do |goal|
        game_question = @game_questions.find_by(order: goal.order)
        @goals_n_games.push({ goal: goal, game_question: game_question, game_answers: @game_answers[game_question.id] })
      end
    end
  end
end
