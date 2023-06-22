class RecipesController < ApplicationController

    def index
        user = User.find_by(id: session[:user_id])
        if user
            recipes = Recipe.all 
            render json: recipes, stauts: :created
        else
            render json: { errors: ["User is not logged in, Please log in first"]}, status: :unauthorized
        end
    end

    def create
        user = User.find_by(id: session[:user_id])
        if user
            recipe = user.recipes.create(recipe_params)
            if recipe.valid?    
            render json: recipe, status: :created
            else
                render json: { errors: recipe.errors.full_messages }, status: :unprocessable_entity
            end
        else
            render json: { errors: ["User is not logged in, Please log in first"]}, status: :unauthorized
        end
    end

    private

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end

end
