class RepliesController < ApplicationController
	 before_action :authenticate_user!
  def new

    @quiz = Quiz.find(params[:quiz_id])
    @reply = @quiz.replies.build
    @quiz.questions.each {|question| @reply.answers.build(question: question)}

  end

  def create
    @quiz = Quiz.find(params[:quiz_id])
    @reply = @quiz.replies.build reply_params
    if @reply.save
      count_replies(@reply)
      redirect_to @quiz, notice: "Thank you for taking the quiz"
    end
  end
  def count_replies(reply)
      reply.answers.each do |answer|
        if answer.possible_answer.present? && (answer.possible_answer.title == answer.question.right_answer)
            CountReply.create(title:"Correcta",user_id:current_user.id,quiz_id:params[:quiz_id])
        else
            CountReply.create(title:"Incorrectas",user_id:current_user.id,quiz_id:params[:quiz_id]) 
        end
      end
  end

  def reply_params
    params.require(:reply).permit( answers_attributes: [ :value, :question_id, :possible_answer_id ] ).merge(user_id:current_user.id)
  end

end
