class QuizzesController < ApplicationController
  before_action :set_quiz, only: [:show, :edit, :update, :destroy]
  before_action :admin!, except: [:index, :show]
  # GET /quizzes
  # GET /quizzes.json
  def index
    @quizzes = Quiz.all
    

  end

  def count_errors
    @quizzes_counted = Quiz.all
    @total=[] 
     @errores = ["incorrecta"]
     @correctas = ["Correcta"]
     @quizzes.last.replies.each do |reply|
      reply.answers.each do |answer|
        if answer.possible_answer.present? && (answer.possible_answer.title == answer.question.right_answer)
          @correctas 
          #@total_score= @scores.inject(0) { |total,sum| total+=sum}
          @total << @correctas 
        else
          @total << @errores 
        end
      end
    end
  end

  def show
    @scores = []
    @total_score =[]
    @errors_user =[]
    @total_incorrect =[]
    @quiz_id=Quiz.find(params[:id]).id
    #@quiz.replies.each do |reply|

    @quiz.replies.where(user_id:current_user.id).each do |reply|
      reply.answers.each do |answer|
        if answer.possible_answer.present? && (answer.possible_answer.title == answer.question.right_answer)
          @scores << 1
          @total_score= @scores.inject(0) { |total,sum| total+=sum}
        end
      end
    end
  end


  def new
    @quiz = Quiz.new
  end

  # GET /quizzes/1/edit
  def edit
  end

  def create
    @quiz = Quiz.new(quiz_params)

    respond_to do |format|
      if @quiz.save
        format.html { redirect_to @quiz, notice: 'Quiz was successfully created.' }
        format.json { render :show, status: :created, location: @quiz }
      else
        format.html { render :new }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @quiz.update(quiz_params)
        format.html { redirect_to @quiz, notice: 'Quiz was successfully updated.' }
        format.json { render :show, status: :ok, location: @quiz }
      else
        format.html { render :edit }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quizzes/1
  # DELETE /quizzes/1.json
  def destroy
    @quiz.destroy
    respond_to do |format|
      format.html { redirect_to quizzes_url, notice: 'Quiz was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def download_xlsx
    @resp_admin=[]
    @resp_user=[]
    if current_user.admin? 
      data=Quiz.find(params[:quiz_id])
        data.replies.each do |reply|
         reply.answers.each do |answer|
          
              @resp_admin << answer
              
          end
        end
        xlsx_respuestas(@resp_admin)
    end
  end
  #xlsx
  def xlsx_respuestas(resp_user)
    xlsx_package = Axlsx::Package.new
      wb = xlsx_package.workbook
      headers = headers_quiz
      wb.styles do |style|
        xlsx_styles style, mock_quiz
        wb.add_worksheet(name: 'hoja1') do |sheet|
          sheet.add_row headers, style: @main_header, row_offset: 1
          t = 0
          resp_user.each do |resp|
            map_data = map_respuestas(resp)
              if t.zero?
                sheet.add_row map_data ,style: @perfect_style, row_offset:2
                t=1
              else
                sheet.add_row map_data ,style: @perfect_style2, row_offset:2
                t=0
              end
          end
        end
      end
      send_data xlsx_package.to_stream.read, filename: "ReporteDeCurso-#{Date.today}.xlsx"
  end

  
  private
    # Use callbacks to share common setup or constraints between actions.
    #xlsx
    def stiles style
    @style1 = style.add_style(:bg_color => '4472C4', :fg_color => 'D9E2F2', :sz => 14, :alignment => { :horizontal=> :center },:format_code => 'YYYY-MM-DD')
    @style2 = style.add_style(:bg_color => 'B4C6E7', :fg_color => '4472C4', :sz => 14, :alignment => { :horizontal=> :center },:format_code => 'YYYY-MM-DD')
    @style3 = style.add_style(:bg_color => 'D9E2F2', :fg_color => '4472C4', :sz => 14, :alignment => { :horizontal=> :center },:format_code => 'YYYY-MM-DD')

  end

  def xlsx_styles style, mock
    bg_header_color = "4472C4"
    fg_header_color = "D9E2F2"
    bg_first_color = "B4C6E7"
    fg_first_color = "4472C4"
    bg_second_color = "D9E2F2"
    # @fg_second_color = "4472C4"
    size_style = 14

    @main_header = style.add_style(bg_color: bg_header_color, fg_color: fg_header_color, sz: size_style, alignment: { horizontal: :center })
    styles = []
    formats = [
      {name: "DateTime", format: "dd-mm-yyyy"},
      {name: "Date", format: "dd-mm-yyyy mm:hh"},
      {name: "Currency", format: "[$$-es-MX]#,##0.00"},
      {name: "Integer", format: "0"},
      {name: "String", format: "@"}
    ]
    formats.each do |f|
      styles.push f
      styles.last[:styles] = []
      styles.last[:styles].push style.add_style(bg_color: bg_first_color, fg_color: fg_first_color,sz: size_style, alignment: { horizontal: :center }, format_code: f[:format])
      styles.last[:styles].push style.add_style(bg_color: bg_second_color, fg_color: fg_first_color,sz: size_style, alignment: { horizontal: :center }, format_code: f[:format])
    end

    @perfect_style = []
    @perfect_style2 = []

    mock.each do |type_data|
      style_select = styles.select {|s| s[:name] == type_data}.first
      unless style_select.nil?
        @perfect_style.push style_select[:styles][0]
        @perfect_style2.push style_select[:styles][1]
      end
    end
  end

  def gen_workbook
    xlsx_package = Axlsx::Package.new
    return xlsx_package
  end




  def map_respuestas(resp)
        
      datos=[
             resp.reply.user.email,
             resp.reply.quiz.title,
             resp.question.title,
             resp.possible_answer.title,
             resp.possible_answer.question.right_answer,
             (resp.possible_answer.title == resp.question.right_answer) ? "correcta" : "Incorrecta"
            ]
  end
  def headers_quiz
    [
      "Usuario",
      "Titulo",
      "Pregunta",
      "Respuesta del usuario",
      "Respuesta correcta",
      "Puntuación",
    ]
    
  end
  def mock_quiz
    [
      "String",
      "String",
      "String",
      "String",
      "String",
      "String"
    ]
  end


    def set_quiz
      @quiz = Quiz.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quiz_params
      params.require(:quiz).permit(:title)
    end
    def admin!
      authenticate_user!
      redirect_to root_path, alert: "You are not authorized to perform this action" unless current_user.admin?
    end
end
