# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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