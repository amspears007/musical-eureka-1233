require 'rails_helper'

RSpec.describe 'Ingredient Index', type: :feature do
  let!(:chicken) {Ingredient.create!(name: "Chicken", cost: 10)}
  let!(:ravioli) {Ingredient.create!(name: "Ravioli", cost: 2)}
  let!(:cheese) {Ingredient.create!(name: "Parmesan", cost:5)}
  let!(:sauce) {Ingredient.create!(name: "Marinara", cost:3)}
  let!(:bread_crumbs) {Ingredient.create!(name: "Bread Crumbs", cost:1)}

  let!(:pasta_dish) {Recipe.create(name: "Pasta with sauce", complexity: 2, genre: "Italian")}
  let!(:mac_n_cheese) {Recipe.create(name: "macaroni and cheese", complexity: 3, genre: "American")}
  let!(:chicken_fingers) {Recipe.create(name: "Chicken Fingers", complexity: 2, genre: "Kids Food")}

  let!(:chicken_pasta_dish) {RecipeIngredient.create!(ingredient_id: chicken.id, recipe_id: pasta_dish.id)}
  let!(:ravioli_pasta_dish) {RecipeIngredient.create!(ingredient_id: ravioli.id, recipe_id: pasta_dish.id)}
  let!(:sauce_pasta_dish) {RecipeIngredient.create!(ingredient_id: sauce.id, recipe_id: pasta_dish.id)}
  let!(:chicken_chicken_fingers) {RecipeIngredient.create!(ingredient_id: chicken.id, recipe_id: chicken_fingers.id)}
  let!(:bread_crumbs_chicken_fingers) {RecipeIngredient.create!(ingredient_id: bread_crumbs.id, recipe_id: chicken_fingers.id)}

  describe "visit '/ingredients" do
    it "I see a list of all the ingredients including their name and cost" do
      visit "/ingredients"
      # save_and_open_page
      within("h1")do
        expect(page).to have_content("Ingredient Index Page")
      end

      within("#ingredient_info") do
      expect(page).to have_content(chicken.name)
      expect(page).to have_content(ravioli.name)
      expect(page).to have_content(sauce.name)
      expect(page).to have_content(chicken.cost)
      expect(page).to have_content(bread_crumbs.cost)
      expect(page).to have_content(cheese.cost)
      end
    end

    describe "Ingredients Sorted Alphabetically " do
      it " I see that the list of ingredients is sorted alphabetically by name" do
        visit "/ingredients"

        expect(bread_crumbs.name).to appear_before(chicken.name)
        expect(cheese.name).to appear_before(ravioli.name)
        expect(chicken.name).to appear_before(sauce.name)
      end
    end
  end
end