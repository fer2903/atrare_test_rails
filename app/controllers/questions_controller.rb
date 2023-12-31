class QuestionsController < ApplicationController
	before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :set_quiz
  before_action :set_kindof_questions
  before_action :admin!, except: [:index]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = @quiz.questions.build
    4.times { @question.possible_answers.build }
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = @quiz.questions.build(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to @quiz, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:title, :kind, :right_answer, :quiz_id, possible_answers_attributes: [:id, :title])
    end
    def set_quiz
      @quiz = Quiz.find(params[:quiz_id])
    end
    def set_kindof_questions
      @kind_options = [
        ["MCQ", "choice"]
      ]
    end
    def admin!
      authenticate_user!
      redirect_to root_path, alert: "You are not authorized to perform this action" unless current_user.admin?
    end

end
