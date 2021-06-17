class QuestionsController < ApplicationController
    def index
        num_of_questions = params[:num]
        category = params[:category]

        cookies[:category] = category

        cookies[:total_questions_count] = num_of_questions

        cookies[:num_questions_answered] = "0"
        cookies[:correct_answers] = "0"
        cookies[:questions_answered] = ""

        redirect_to("/questions")
    end

    def question
        questions_answered_string = cookies[:questions_answered] 
        questions_answered = questions_answered_string.split(",")

        category = cookies[:category]

        returnNum = 0
        randomNum = rand(1..Question.count)
        if category != "none"
            while true
                if !questions_answered.include? randomNum.to_s
                    break if Question.find(randomNum).category == category
                end
                randomNum = rand(1..Question.count)
            end
        else
            while questions_answered.include? randomNum.to_s
                randomNum = rand(1..Question.count)
            end
        end

        @the_question = Question.find(randomNum)

        @id = @the_question.id

        @answers = @the_question.answers.split(",")

        @answered_qs = cookies[:questions_answered]

    end

    def submit
        @message = "Please answer the question before continuing"
        if params[:choice] != nil 
            choice = params[:choice]
            question_id = params[:question_id]

            the_question = Question.find(question_id)

            questions_answers = the_question.answers.split(",")
            correct_answers = the_question.correct_answers.split(",")

            # PA level correct answer is only 1
            index = 0
            i=0
            questions_answers.each do |a|
                if a == choice.to_s
                    index=i
                end
                i+=1
            end

            # If answer is true then increment correct answers cookie
            if correct_answers[index] == "true"
                current_correct_answers = cookies[:correct_answers].to_i
                current_correct_answers += 1
                cookies[:correct_answers] = current_correct_answers.to_s
            end

            # Increment number of questions answered
            current_answered = cookies[:num_questions_answered].to_i
            current_answered += 1
            cookies[:num_questions_answered] = current_answered.to_s

            # Increment questions answered so no repetition
            answered_ids = cookies[:questions_answered].to_s
            answered_ids += question_id.to_s + ","
            cookies[:questions_answered] = answered_ids

            if cookies[:num_questions_answered] == cookies[:total_questions_count]
                redirect_to("/endgame")
            else    
                redirect_to("/questions")
            end
        end
    end

    def endgame
        correct_answers = cookies[:correct_answers]
        
        @final_score = correct_answers + "/" + cookies[:total_questions_count]

        current_time = DateTime.current.to_date

        if cookies[:history].blank?
            cookies[:history] = current_time.to_s + "#" + @final_score
        else
            temp_history = cookies[:history].split(",")
            @history_array = temp_history[0...5]
            retVal = current_time.to_s + "#" + @final_score + "," + cookies[:history]
            cookies[:history] = retVal
        end            
    end
end
