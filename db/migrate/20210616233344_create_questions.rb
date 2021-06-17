class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :question_form
      t.string :description
      t.string :answers
      t.boolean :multiple_correct_answers
      t.string :correct_answers
      t.string :explanation
      t.string :tip
      t.string :tags
      t.string :category
      t.string :difficulty


      t.timestamps
    end
  end
end
