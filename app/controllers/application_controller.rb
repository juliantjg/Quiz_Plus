class ApplicationController < ActionController::Base
    before_action :seed

    def seed
        if Question.all.size == 0
            questions_list = JSON.parse(File.read('quiz.json'))

            questions_list.each do |q|
                answerTotal = ""
                q['answers'].values.each do |ans|
                    if ans != nil
                        answerTotal += ans + ","
                    end
                end
                answersFinal = answerTotal[0..answerTotal.length() - 2]

                correctTotal = ""
                q['correct_answers'].values.each do |ans|
                    correctTotal += ans + ","
                end
                correctFinal = correctTotal[0..correctTotal.length() - 2] 

                # Explanation
                if q['explanation'] == nil
                    q['explanation'] = ""
                end

                # Tip
                if q['tip'] == nil
                    q['tip'] = ""
                end

                # Tags
                tagTotal = ""
                q['tags'].each do |tag|
                    tagTotal += tag['name'] + ","
                end
                tagFinal = tagTotal[0..tagTotal.length() - 2]; 

                Question.create(question_form: q['question'], description: q['description'], answers: answersFinal, multiple_correct_answers: q['multiple_correct_answers'], correct_answers: correctFinal,
                explanation: q['explanation'], tip: q['tip'], tags: tagFinal, category: q['category'], difficulty: q['difficulty'])
            end
        end
    end
end
