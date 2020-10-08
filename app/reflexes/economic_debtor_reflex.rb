# frozen_string_literal: true

class EconomicDebtorReflex < StimulusReflex::Reflex
  def create
    CreateEconomicDebtorJob.perform_now(element.dataset[:customer_id])
  end
end
