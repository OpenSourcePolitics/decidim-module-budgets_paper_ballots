# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Budgets
    module Admin
      describe ProjectsController, type: :controller do
        routes { Decidim::Budgets::AdminEngine.routes }

        let(:organization) { create(:organization) }
        let(:user) { create(:user, :confirmed, :admin, organization:) }
        let(:participatory_space) { create(:assembly, organization:) }
        let(:component) { create(:budgets_component, organization:, participatory_space:) }

        before do
          request.env["decidim.current_organization"] = organization
          request.env["decidim.current_participatory_space"] = participatory_space
          request.env["decidim.current_component"] = component
          sign_in user
        end

        describe "PATCH update" do
          let(:taxonomy) { create(:taxonomy, :with_parent, organization:) }
          let(:project) { create(:project, component:, taxonomies: [taxonomy]) }
          let(:project_title) { project.title }
          let(:project_params) do
            {
              title: project_title,
              description: project.description,
              budget_amount: project.budget_amount,
              proposal_ids: project.linked_resources(:proposals, "included_proposals").pluck(:id),
              selected: project.selected?,
              photos: project.photos.map { |a| a.id.to_s }
            }
          end
          let(:params) do
            {
              id: project.id,
              budget_id: project.budget.id,
              project: project_params,
              component_id: component.id,
              assembly_slug: participatory_space.slug
            }
          end

          it "updates the project" do
            allow(controller).to receive(:budget_projects_path).and_return("/projects")

            patch :update, params: params

            expect(flash[:notice]).not_to be_empty
            expect(response).to have_http_status(:found)
          end

          context "when the existing project has attachments and there are other errors on the form" do
            include_context "with controller rendering the view" do
              let(:project_title) { { en: "" } }
              let(:project) { create(:project, :with_photos, component: component) }

              controller(ProjectsController) do
                helper_method :proposals_picker_projects_path
                def proposals_picker_projects_path
                  "/"
                end
              end

              it "displays the editing form with errors" do
                patch :update, params: params

                expect(flash[:alert]).not_to be_empty
                expect(response).to have_http_status(:unprocessable_entity)
                expect(subject).to render_template(:edit)
                expect(response.body).to include("There was a problem updating this project")
              end
            end
          end
        end
      end
    end
  end
end
