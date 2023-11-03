class ChartsController < ApplicationController
	def index
		id_quiz=[]
		quizes_all=Quiz.all.each do|q|
			id_quiz << q.id
		end
		
			@chart_quiz1=Quiz.find(1).nil? ? "sin dato " : Quiz.find(1) 
	
			@chart_quiz2=Quiz.find(2).nil? ? "sin dato " : Quiz.find(2) 
		
			@chart_quiz3=Quiz.find(3).nil? ? "sin dato " : Quiz.find(3) 
		
			@chart_quiz4=Quiz.find(4).nil? ? "sin dato " : Quiz.find(4) 


		
	end	
	

end
