require 'rails_helper'
include SessionsHelper

RSpec.describe Trainee::CoursesController, type: :controller do
  let!(:user) {FactoryBot.create(:user, roles: "trainee")}
  let!(:course) {FactoryBot.create(:course, user_ids:[user.id])}

  describe "GET index" do
    context "when curren is loggin" do
      before do
        log_in user
        get :index
      end

      it "assign @Course" do
        expect(assigns(:courses)).to eq([course])
      end

      it "render the index template" do
        get :index
        expect(response).to render_template("index")
      end
    end
  end

  describe "GET #show" do
    context "when user is loggin" do
      before do
        log_in user
        get :show, params: { id: course.id }
      end

      it "assigns the @course" do
        expect(assigns(:course)).to eq(course)
      end

      it "renders the #show view" do
        expect(response).to render_template :show
      end
    end
  end
end
