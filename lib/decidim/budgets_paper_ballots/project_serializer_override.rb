# frozen_string_literal: true

module Decidim
  module BudgetsPaperBallots
    module ProjectSerializerOverride
      def serialize
        {
          id: project.id,
          taxonomies:,
          participatory_space: {
            id: project.participatory_space.id,
            url: Decidim::ResourceLocatorPresenter.new(project.participatory_space).url
          },
          component: { id: component.id },
          title: project.title,
          description: project.description,
          budget: { id: project.budget.id,
                    title: project.budget.title,
                    url: budget_url },
          budget_amount: project.budget_amount,
          confirmed_votes: (project.confirmed_orders_count if
            project.component.current_settings.show_votes?),
          paper_ballots: project.paper_ballots,
          total_votes: project.total_votes,
          comments: project.comments_count,
          created_at: project.created_at,
          url: project.polymorphic_resource_url({}),
          address: project.address,
          updated_at: project.updated_at,
          selected_at: project.selected_at,
          reference: project.reference,
          follows_count: project.follows_count,
          latitude: project.latitude,
          longitude: project.longitude,
          related_proposals: related_proposals,
          related_proposal_titles: related_proposal_titles,
          related_proposal_urls: related_proposal_urls
        }
      end
    end
  end
end
