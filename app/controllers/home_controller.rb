class HomeController < ApplicationController
    def index
        if !cookies[:category].blank?
            @categorySet = cookies[:category]
        end
        if !cookies[:total_questions_count].blank?
            @numSet = cookies[:total_questions_count]
        end
    end
end
