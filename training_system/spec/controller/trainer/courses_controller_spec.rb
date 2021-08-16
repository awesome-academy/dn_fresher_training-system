require "rails_helper"
include SessionsHelper

RSpec.describe Trainer::CoursesController, type: :controller do
  let!(:user) {FactoryBot.create :user}
  let!(:course) {FactoryBot.create :course}

  describe "GET #index" do
    context "when user is loggin" do
      before do
        log_in user
        get :index
      end

      it "assign @courses" do
        expect(assigns(:courses)).to eq([course])
      end
    end

    context "fail when user login not yet" do
      before do
        get :index
      end

      it "show flash danger" do
        expect(flash[:danger]).to eq I18n.t("controllers.course_controller.let_login")
      end

      it "redirect to login_path" do
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "GET new" do
    context "when user is loggin render new" do
      before do
        log_in user
        get :new
      end

      it "should render #new template" do
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #show" do
    context "when user is loggin" do
      before do
        log_in user
        get :show, params: { id: course.id }
      end

      it "should show course" do
        expect(assigns(:course)).to eq(course)
      end

      it "renders the #show view" do
        expect(response).to render_template :show
      end
    end
  end

  describe "GET #edit" do
    context "when user is loggin" do
      before do
        log_in user
        get :edit, params: { id: course.id }
      end

      it "should show course" do
        expect(assigns(:course)).to eq(course)
      end

      it "renders the #edit view" do
        expect(response).to render_template :edit
      end
    end
  end

  describe "POST course#create" do
    let!(:user1) {FactoryBot.create :user}
    let!(:user2) {FactoryBot.create :user}
    let!(:subject1) {FactoryBot.create :subject}
    let!(:subject2) {FactoryBot.create :subject}

    context "success when valid attributes" do
      let!(:params_course) {{name: "ruby", description: "test",
                              start_date: "2021-09-03", end_date: "2021-09-30", status: :init,
                              user_ids: [user1.id, user2.id], subject_ids: [subject1.id, subject2.id]}}
      before do
        log_in user
        post :create, params: {
          course: params_course
        }
      end

      it "creates a new course" do
        expect{
          post :create, params: {
            course: params_course
          }
        }.to change(Course, :count).by 1
      end

      it "assign @corse " do
        expect(assigns(:course)).not_to be_nil
      end

      it "redirect trainer courses path" do
        expect(response).to redirect_to(trainer_courses_path)
      end
    end

    context "fail when invalid attributes" do
      let!(:params_course1) {FactoryBot.build(:course).as_json}
      before do
        log_in user
        post :create, params: {
          course: 
            params_course1
        }
      end

      it "renders the new template" do
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PUT course#update" do
    let!(:course1) {FactoryBot.create(:course, name: "a", description: "b", start_date: "2021-09-19", end_date: "2021-10-21", status: :in_progress)}

    context "success when valid attributes" do
      before do
        log_in user
        patch :update, params: {
          course: {name: "Change Name"},
          id: course1.id
        }
      course1.reload 
      end

      it "update db success" do
        expect([course1.name]).to eq(["Change Name"])
      end

      it "update db success" do
        expect(flash[:success]).to eq I18n.t("courses.update.success")
      end

      it "redirects to the trainer course path" do
        expect(response).to redirect_to trainer_course_path
      end
    end

    context "fail when params id not found" do
      before do
        log_in user
        put :update, params: {
          course: {name: "Change Name"},
            id: -1
          }
      end

      it "display flash danger " do
        expect(flash[:danger]).to eq I18n.t("controllers.course_subjects_controller.error_show")
      end
    end

    context "fail when invalid attributes" do
      before do
        log_in user
        put :update, params: {
          course: {name: ""},
            id: course1.id
          }
      end

      it "display flash danger " do
        expect(flash[:danger]).to eq I18n.t("courses.update.failed")
      end

      it "render edit" do
        expect(response).to render_template :edit
      end
    end
  end

  describe "PATCH #start_course" do

    context "suscces with valid attr" do
      before do
        log_in user
        put :start_course, params: {
          course: {status: :in_progress},
            id: course.id
          }
      end

      it "update db success" do
        expect([course.status]).to eq(["in_progress"])
      end

      it "updates status course" do
        expect(flash[:success]).to eq I18n.t("courses.update.success")
        expect(response).to redirect_to trainer_courses_path
      end
    end
  end
end
