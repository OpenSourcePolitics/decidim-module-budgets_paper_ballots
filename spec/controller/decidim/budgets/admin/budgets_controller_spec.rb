# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Budgets
    module Admin
      describe BudgetsController, type: :controller do
        routes { Decidim::Budgets::AdminEngine.routes }

        let(:organization) { create(:organization) }
        let(:current_user) { create(:user, :confirmed, :admin, organization:) }
        let(:participatory_space) { create(:assembly, organization:) }
        let(:component) { create(:budgets_component, organization:, participatory_space:) }
        let(:budget) { create(:budget, component:) }

        before do
          request.env["decidim.current_organization"] = component.organization
          request.env["decidim.current_participatory_space"] = participatory_space
          request.env["decidim.current_component"] = component
          sign_in current_user
        end

        describe "paper_ballots_count" do
          let!(:project) { create(:project, component:, budget:) }
          let(:params) do
            {
              component_id: component.id,
              assembly_slug: participatory_space.slug
            }
          end

          context "when there are paper ballots for the budgets" do
            let!(:paper_ballot_result) { create :paper_ballot_result, project:, votes: 20 }
            let(:project2) { create(:project, component:, budget:) }
            let!(:paper_ballot_result2) { create :paper_ballot_result, project: project2, votes: 30 }
            let(:project3) { create(:project, component:) }
            let!(:paper_ballot_result3) { create :paper_ballot_result, project: project3, votes: 15 }

            it "gives the count of paper ballots for all budgets" do
              get :index, params: params
              expect(controller.paper_ballots_count).to eq(65)
            end
          end

          context "when there are no paper ballots" do
            it "returns 0" do
              get :index, params: params
              expect(controller.paper_ballots_count).to eq(0)
            end
          end
        end
      end
    end
  end
end
