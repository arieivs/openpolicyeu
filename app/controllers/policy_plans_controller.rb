class PolicyPlansController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :choose_institution, :choose_gamebook, :choose_timeline, :open_accordion, :close_accordion]

  def index
    @policy_plans = PolicyPlan.includes(policy_making: [:country, :topic]).order(:name)
  end

  def show
    set_policy_plan
    @policy_making = @policy_plan.policy_making
    @policy_plan_institutions = PolicyPlanInstitution.includes(institution: {logo_attachment: :blob}).where(policy_plan: @policy_plan)
    @goals = Goal.where(policy_plan: @policy_plan).order(:order)
    @timesteps = Timestep.where(policy_plan: @policy_plan).order(:date)
    set_gamebook
    @young_contributors = YoungContributor.includes(logo_attachment: :blob).where(policy_plan: @policy_plan)
  end

  def new
    @policy_plan = PolicyPlan.new
  end

  def create
    @policy_plan = PolicyPlan.new(policy_plan_params)
    if @policy_plan.save
      redirect_to edit_policy_plan_path(@policy_plan)
      flash[:notice] = "Policy Plan/Strategy created successfully! Scroll down and keep editing."
    else
      flash.now[:alert] = "Something went wrong. Please review your inputs above."
      render :new
    end
  end

  def edit
    @policy_makings = PolicyMaking.includes(:topic, :country)
    set_policy_plan
    prepare_data_for_policy_plan_edit
  end

  def update
    @policy_makings = PolicyMaking.includes(:topic, :country)
    set_policy_plan
    if @policy_plan.update(policy_plan_params)
      respond_to { |format| format.js { flash.now[:notice] = "Policy Plan/Strategy updated successfully!" } }
    else
      respond_to { |format| format.js { flash.now[:alert] = "Something went wrong. Please review your inputs above." } }
    end
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
    @game_questions = @policy_plan.goals ? @game_questions.order(:order) : @game_questions.order(:date)
    @next_question = @game_questions.first
    @next_answers = GameAnswer.where(game_question: @next_question)
  end

  def policy_plan_params
    params.require(:policy_plan).permit(:policy_making_id, :name, :short_description, :content, :goals, :video_url, :video_alt_text, :video_source, :ambassador_id)
  end

  def prepare_data_for_policy_plan_edit
    # Institutions
    @policy_making = @policy_plan.policy_making
    @policy_plan_institutions = PolicyPlanInstitution.includes(:institution).where(policy_plan: @policy_plan)
    @new_policy_plan_institution = PolicyPlanInstitution.new
    @new_institution = Institution.new
    # Timesteps -> only for Policy Plans
    if !@policy_plan.goals
      @timesteps = Timestep.where(policy_plan: @policy_plan).order(:date)
      @new_timestep = Timestep.new
    end
    # Gamebook/Questions for Goals
    @game_questions = GameQuestion.where(policy_plan: @policy_plan)
    @game_questions = @policy_plan.goals ? @game_questions.order(:order) : @game_questions.order(:date)
    @new_game_question = GameQuestion.new
    @game_answers = {}
    @game_questions.each do |game_question|
      @game_answers[game_question.id] = GameAnswer.where(game_question: game_question)
    end
    @new_game_answer = GameAnswer.new
    # Goals -> only for Strategies
    if @policy_plan.goals
      @goals = Goal.where(policy_plan: @policy_plan).order(:order)
      @goals_n_games = []
      @goals.each do |goal|
        game_question = @game_questions.find_by(order: goal.order)
        game_answers = game_question.nil? ? nil : @game_answers[game_question.id]
        @goals_n_games.push({ goal: goal, game_question: game_question, game_answers: game_answers })
      end
      @new_goal = Goal.new
      @new_goal_order = @goals.empty? ? 1 : @goals.last.order + 1
    end
  end
end
